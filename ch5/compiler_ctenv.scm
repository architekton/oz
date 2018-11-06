; 5.41
(define (find-variable variable ctenv)
  (define (iter-frames cnt ctenv)
    (if (null? ctenv)
        'not-found
        (let ((position (find-in-frame (car ctenv))))
          (if position
              (list cnt position)
              (iter-frames (+ cnt 1) (cdr ctenv))))))

  (define (find-in-frame frame)
    (define (iter cnt frame)
      (cond ((null? frame) #f)
            ((eq? (car frame) variable) cnt)
            (else (iter (+ cnt 1) (cdr frame)))))
    (iter 0 frame))

  (iter-frames 0 ctenv))

; 5.39
(define (lexical-address frame offset) (cons frame offset))
(define (lexical-address-frame lexical-address) (car lexical-address))
(define (lexical-address-offset lexical-address) (cdr lexical-address))

(define (lexical-address-lookup lexical-address run-time-environment)
  (let ((value (cdr
                 (list-ref
                   (list-ref run-time-environment
                             (lexical-address-frame lexical-address))
                   (lexical-address-offset lexical-address)))))
    (if (eq? value '*unassigned*)
        (error "Unassigned variable! -- LEXICAL-ADDRESS-LOOKUP" lexical-address)
        value)))

(define (lexical-address-set! lexical-address run-time-environment value)
  (let ((pair ((list-ref
                 (list-ref run-time-environment
                           (lexical-address-frame lexical-address))
                 (lexical-address-offset lexical-address)))))
    (set-cdr! pair value)))

(define (compile exp target linkage ctenv)
  (cond ((self-evaluating? exp)
         (compile-self-evaluating exp target linkage))
        ((quoted? exp) (compile-quoted exp target linkage))
        ((variable? exp)
         (compile-variable exp target linkage ctenv))
        ((assignment? exp)
         (compile-assignment exp target linkage ctenv))
        ((definition? exp)
         (compile-definition exp target linkage ctenv))
        ((if? exp) (compile-if exp target linkage ctenv))
        ((lambda? exp) (compile-lambda exp target linkage ctenv))
        ((begin? exp)
         (compile-sequence (begin-actions exp)
                           target
                           linkage ctenv))
        ((cond? exp) (compile (cond->if exp) target linkage ctenv))
        ((application? exp)
         (compile-application exp target linkage ctenv))
        (else
          (error "Unknown expression type -- COMPILE" exp))))


(define (make-instruction-sequence needs modifies statements)
  (list needs modifies statements))

(define (empty-instruction-sequence)
  (make-instruction-sequence '() '() '()))


;;;SECTION 5.5.2

;;;linkage code

(define (compile-linkage linkage)
  (cond ((eq? linkage 'return)
         (make-instruction-sequence '(continue) '()
                                    '((goto (reg continue)))))
        ((eq? linkage 'next)
         (empty-instruction-sequence))
        (else
          (make-instruction-sequence '() '()
                                     `((goto (label ,linkage)))))))

(define (end-with-linkage linkage instruction-sequence)
  (preserving '(continue)
              instruction-sequence
              (compile-linkage linkage)))


;;;simple expressions

(define (compile-self-evaluating exp target linkage)
  (end-with-linkage linkage
                    (make-instruction-sequence '() (list target)
                                               `((assign ,target (const ,exp))))))

(define (compile-quoted exp target linkage)
  (end-with-linkage linkage
                    (make-instruction-sequence '() (list target)
                                               `((assign ,target (const ,(text-of-quotation exp)))))))

(define (compile-variable exp target linkage ctenv)
  (let ((lexical-addr (find-variable exp ctenv)))
    (end-with-linkage linkage
                      (make-instruction-sequence
                        '(env) (list target)
                        (if (eq? lexical-addr 'not-found)
                            `((assign ,target
                                      (op lookup-variable-value)
                                      (const ,exp)
                                      (reg env)))
                            `((assign ,target
                                      (op lexical-address-lookup)
                                      (const ,lexical-addr)
                                      (reg env))))))))

(define (compile-assignment exp target linkage ctenv)
  (let ((var (assignment-variable exp))
        (get-value-code (compile (assignment-value exp) 'val 'next ctenv)))
    (let ((lexical-addr (find-variable var ctenv)))
      (end-with-linkage linkage
                        (preserving '(env)
                                    get-value-code
                                    (make-instruction-sequence
                                      '(env val) (list target)
                                      (if (eq? lexical-addr 'not-found)
                                          `((perform (op set-variable-value!)
                                                     (const ,var)
                                                     (reg val)
                                                     (reg env))
                                            (assign ,target (const ok)))
                                          `((perform (op lexical-address-set!)
                                                     (const ,lexical-addr)
                                                     (reg val)
                                                     (reg env))
                                            (assign ,target (const ok))))))))))

(define (compile-definition exp target linkage ctenv)
  (let ((var (definition-variable exp))
        (get-value-code
          (compile (definition-value exp) 'val 'next ctenv)))
    (end-with-linkage linkage
                      (preserving '(env)
                                  get-value-code
                                  (make-instruction-sequence '(env val) (list target)
                                                             `((perform (op define-variable!)
                                                                        (const ,var)
                                                                        (reg val)
                                                                        (reg env))
                                                               (assign ,target (const ok))))))))


;;;conditional expressions

;;;labels (from footnote)
(define label-counter 0)

(define (new-label-number)
  (set! label-counter (+ 1 label-counter))
  label-counter)

(define (make-label name)
  (string->symbol
    (string-append (symbol->string name)
                   (number->string (new-label-number)))))

;; end of footnote
(define (compile-if exp target linkage ctenv)
  (let ((t-branch (make-label 'true-branch))
        (f-branch (make-label 'false-branch))
        (after-if (make-label 'after-if)))
    (let ((consequent-linkage
            (if (eq? linkage 'next) after-if linkage)))
      (let ((p-code (compile (if-predicate exp) 'val 'next ctenv))
            (c-code
              (compile
                (if-consequent exp) target consequent-linkage ctenv))
            (a-code
              (compile (if-alternative exp) target linkage ctenv)))
        (preserving '(env continue)
                    p-code
                    (append-instruction-sequences
                      (make-instruction-sequence '(val) '()
                                                 `((test (op false?) (reg val))
                                                   (branch (label ,f-branch))))
                      (parallel-instruction-sequences
                        (append-instruction-sequences t-branch c-code)
                        (append-instruction-sequences f-branch a-code))
                      after-if))))))

;;; sequences
(define (compile-sequence seq target linkage ctenv)
  (if (last-exp? seq)
      (compile (first-exp seq) target linkage ctenv)
      (preserving '(env continue)
                  (compile (first-exp seq) target 'next ctenv)
                  (compile-sequence (rest-exps seq) target linkage ctenv))))

;;;lambda expressions
(define (compile-lambda exp target linkage ctenv)
  (let ((proc-entry (make-label 'entry))
        (after-lambda (make-label 'after-lambda)))
    (let ((lambda-linkage
            (if (eq? linkage 'next) after-lambda linkage)))
      (append-instruction-sequences
        (tack-on-instruction-sequence
          (end-with-linkage lambda-linkage
                            (make-instruction-sequence '(env) (list target)
                                                       `((assign ,target
                                                                 (op make-compiled-procedure)
                                                                 (label ,proc-entry)
                                                                 (reg env)))))
          (compile-lambda-body exp proc-entry ctenv))
        after-lambda))))

(define (extend-ctenv frame ctenv)
  (cons frame ctenv))

(define (compile-lambda-body exp proc-entry ctenv)
  (let ((formals (lambda-parameters exp)))
    (append-instruction-sequences
      (make-instruction-sequence '(env proc argl) '(env)
                                 `(,proc-entry
                                    (assign env (op compiled-procedure-env) (reg proc))
                                    (assign env
                                            (op extend-environment)
                                            (const ,formals)
                                            (reg argl)
                                            (reg env))))
      (compile-sequence (lambda-body exp) 'val 'return
                        (extend-ctenv formals ctenv)))))


;;;SECTION 5.5.3

;;;combinations

(define (compile-application exp target linkage ctenv)
  (let ((proc-code (compile (operator exp) 'proc 'next ctenv))
        (operand-codes
          (map (lambda (operand) (compile operand 'val 'next ctenv))
               (operands exp))))
    (preserving '(env continue)
                proc-code
                (preserving '(proc continue)
                            (construct-arglist operand-codes)
                            (compile-procedure-call target linkage)))))

(define (construct-arglist operand-codes)
  (let ((operand-codes (reverse operand-codes)))
    (if (null? operand-codes)
        (make-instruction-sequence '() '(argl)
                                   '((assign argl (const ()))))
        (let ((code-to-get-last-arg
                (append-instruction-sequences
                  (car operand-codes)
                  (make-instruction-sequence '(val) '(argl)
                                             '((assign argl (op list) (reg val)))))))
          (if (null? (cdr operand-codes))
              code-to-get-last-arg
              (preserving '(env)
                          code-to-get-last-arg
                          (code-to-get-rest-args
                            (cdr operand-codes))))))))

(define (code-to-get-rest-args operand-codes)
  (let ((code-for-next-arg
          (preserving '(argl)
                      (car operand-codes)
                      (make-instruction-sequence '(val argl) '(argl)
                                                 '((assign argl
                                                           (op cons) (reg val) (reg argl)))))))
    (if (null? (cdr operand-codes))
        code-for-next-arg
        (preserving '(env)
                    code-for-next-arg
                    (code-to-get-rest-args (cdr operand-codes))))))

;;;applying procedures

(define (compile-procedure-call target linkage)
  (let ((primitive-branch (make-label 'primitive-branch))
        (compiled-branch (make-label 'compiled-branch))
        (after-call (make-label 'after-call)))
    (let ((compiled-linkage
            (if (eq? linkage 'next) after-call linkage)))
      (append-instruction-sequences
        (make-instruction-sequence '(proc) '()
                                   `((test (op primitive-procedure?) (reg proc))
                                     (branch (label ,primitive-branch))))
        (parallel-instruction-sequences
          (append-instruction-sequences
            compiled-branch
            (compile-proc-appl target compiled-linkage))
          (append-instruction-sequences
            primitive-branch
            (end-with-linkage linkage
                              (make-instruction-sequence '(proc argl)
                                                         (list target)
                                                         `((assign ,target
                                                                   (op apply-primitive-procedure)
                                                                   (reg proc)
                                                                   (reg argl)))))))
        after-call))))

;;;applying compiled procedures

(define (compile-proc-appl target linkage)
  (cond ((and (eq? target 'val) (not (eq? linkage 'return)))
         (make-instruction-sequence '(proc) all-regs
                                    `((assign continue (label ,linkage))
                                      (assign val (op compiled-procedure-entry)
                                              (reg proc))
                                      (goto (reg val)))))
        ((and (not (eq? target 'val))
              (not (eq? linkage 'return)))
         (let ((proc-return (make-label 'proc-return)))
           (make-instruction-sequence '(proc) all-regs
                                      `((assign continue (label ,proc-return))
                                        (assign val (op compiled-procedure-entry)
                                                (reg proc))
                                        (goto (reg val))
                                        ,proc-return
                                        (assign ,target (reg val))
                                        (goto (label ,linkage))))))
        ((and (eq? target 'val) (eq? linkage 'return))
         (make-instruction-sequence '(proc continue) all-regs
                                    '((assign val (op compiled-procedure-entry)
                                              (reg proc))
                                      (goto (reg val)))))
        ((and (not (eq? target 'val)) (eq? linkage 'return))
         (error "return linkage, target not val -- COMPILE"
                target))))

;; footnote
(define all-regs '(env proc val argl continue))


;;;SECTION 5.5.4

(define (registers-needed s)
  (if (symbol? s) '() (car s)))

(define (registers-modified s)
  (if (symbol? s) '() (cadr s)))

(define (statements s)
  (if (symbol? s) (list s) (caddr s)))

(define (needs-register? seq reg)
  (memq reg (registers-needed seq)))

(define (modifies-register? seq reg)
  (memq reg (registers-modified seq)))


(define (append-instruction-sequences . seqs)
  (define (append-2-sequences seq1 seq2)
    (make-instruction-sequence
      (list-union (registers-needed seq1)
                  (list-difference (registers-needed seq2)
                                   (registers-modified seq1)))
      (list-union (registers-modified seq1)
                  (registers-modified seq2))
      (append (statements seq1) (statements seq2))))
  (define (append-seq-list seqs)
    (if (null? seqs)
        (empty-instruction-sequence)
        (append-2-sequences (car seqs)
                            (append-seq-list (cdr seqs)))))
  (append-seq-list seqs))

(define (list-union s1 s2)
  (cond ((null? s1) s2)
        ((memq (car s1) s2) (list-union (cdr s1) s2))
        (else (cons (car s1) (list-union (cdr s1) s2)))))

(define (list-difference s1 s2)
  (cond ((null? s1) '())
        ((memq (car s1) s2) (list-difference (cdr s1) s2))
        (else (cons (car s1)
                    (list-difference (cdr s1) s2)))))

(define (preserving regs seq1 seq2)
  (if (null? regs)
      (append-instruction-sequences seq1 seq2)
      (let ((first-reg (car regs)))
        (if (and (needs-register? seq2 first-reg)
                 (modifies-register? seq1 first-reg))
            (preserving (cdr regs)
                        (make-instruction-sequence
                          (list-union (list first-reg)
                                      (registers-needed seq1))
                          (list-difference (registers-modified seq1)
                                           (list first-reg))
                          (append `((save ,first-reg))
                                  (statements seq1)
                                  `((restore ,first-reg))))
                        seq2)
            (preserving (cdr regs) seq1 seq2)))))

(define (tack-on-instruction-sequence seq body-seq)
  (make-instruction-sequence
    (registers-needed seq)
    (registers-modified seq)
    (append (statements seq) (statements body-seq))))

(define (parallel-instruction-sequences seq1 seq2)
  (make-instruction-sequence
    (list-union (registers-needed seq1)
                (registers-needed seq2))
    (list-union (registers-modified seq1)
                (registers-modified seq2))
    (append (statements seq1) (statements seq2))))

'(COMPILER LOADED)
