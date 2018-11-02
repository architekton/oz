(load "../syntax.scm")
(load "../compiler.scm")

; a)
(define (spread-arguments operands-list)
  (if (null? operands-list)
      (empty-instruction-sequence)
      (let ((second-seq (compile (cadr operands-list)
                                 'arg2
                                 'next))
            (first-seq (compile (car operands-list)
                                'arg1
                                'next)))
        (preserving
          '(env)
          second-seq
          (preserving '(arg2)
                      first-seq
                      (make-instruction-sequence
                        '(arg2)
                        '()
                        '()))))))

(spread-arguments (list '(+ 1 2) 2))

; b)
(define (compile-op exp target linkage)
  (let ((operator (operator exp))
        (operands (operands exp)))
    (end-with-linkage
      linkage
      (preserving
        '(env continue)
        (spread-arguments operands)
        (make-instruction-sequence
          '(arg1 arg2)
          (list target)
          `((assign ,target (op ,operator) (reg arg1) (reg arg2))))))))

(define (open-code? exp)
  (or (tagged-list? exp '*)
      (tagged-list? exp '+)
      (tagged-list? exp '-)
      (tagged-list? exp '+)))

(define (compile exp target linkage)
  (cond ((self-evaluating? exp)
         (compile-self-evaluating exp target linkage))
        ((quoted? exp)
         (compile-quoted exp target linkage))
        ((open-code? exp)
         (compile-op exp target linkage))
        ((variable? exp)
         (compile-variable exp target linkage))
        ((assignment? exp)
         (compile-assignment exp target linkage))
        ((definition? exp)
         (compile-definition exp target linkage))
        ((if? exp) (compile-if exp target linkage))
        ((lambda? exp) (compile-lambda exp target linkage))
        ((begin? exp)
         (compile-sequence (begin-actions exp)
                           target
                           linkage))
        ((cond? exp) (compile (cond->if exp) target linkage))
        ((application? exp)
         (compile-application exp target linkage))
        (else
          (error "Unknown expression type -- COMPILE" exp))))


; c)
(define tx (compile
             '(define (factorial n)
                (if (= n 1)
                    1
                    (* (factorial (- n 1)) n)))
             'val
             'next))

(for-each (lambda (x) (newline) (display x)) (caddr tx))

; (assign val (op make-compiled-procedure) (label entry6) (reg env))
; (goto (label after-lambda5))
; entry6
; (assign env (op compiled-procedure-env) (reg proc))
; (assign env (op extend-environment) (const (n)) (reg argl) (reg env))
; (assign arg2 (const 1))
; (assign arg1 (op lookup-variable-value) (const n) (reg env))
; (assign val (op =) (reg arg1) (reg arg2))
; (test (op false?) (reg val))
; (branch (label false-branch8))

; true-branch9
; (assign val (const 1))
; (goto (reg continue))

; false-branch8
; (save continue)
; (assign arg2 (op lookup-variable-value) (const n) (reg env))

;; save arg2 -> right to left
; (save arg2)

;; calculate the first argument (factorial (- n 1))
; (assign proc (op lookup-variable-value) (const factorial) (reg env))
; (assign arg2 (const 1))
; (assign arg1 (op lookup-variable-value) (const n) (reg env))
; (assign val (op -) (reg arg1) (reg arg2))
; (assign argl (op list) (reg val))
; (test (op primitive-procedure?) (reg proc))
; (branch (label primitive-branch12))
; compiled-branch11
; (assign continue (label proc-return13))
; (assign val (op compiled-procedure-entry) (reg proc))
; (goto (reg val))
; proc-return13
; (assign arg1 (reg val))
; (goto (label after-call10))
; primitive-branch12
; (assign arg1 (op apply-primitive-procedure) (reg proc) (reg argl))
; after-call10
; (restore arg2)

;; after calculate after restore arg2
; (assign val (op *) (reg arg1) (reg arg2))
; (restore continue)
; (goto (reg continue))
; after-if7
; after-lambda5
; (perform (op define-variable!) (const factorial) (reg val) (reg env))
; (assign val (const ok))

; d)
; (+ 1 2 3 4) - > (+ 1 (+ 2 (+ 3 4))) even
; (+ 1 2 3) - > (+ 1 (+ 2 3)) odd

; or

; (+ 1 2 3 4) - > (+ (+ 1 2) (+ 3 4)) even
; (+ 1 2 3) - > (+ (+ 1 2) 3)) odd

; This one is more costly since it requires us to save restore. The
; first one however chains the evaluation such that only the first evaluation
; requires both arg registers (right to left) and also makes the coding easier.

(define (group-by-two operator operands)
  (if (null? (cdr operands))
      (car operands)
      (list operator (car operands)
            (group-by-two operator (cdr operands)))))

(group-by-two '+ (list 1 2 3 4))
(group-by-two '+ (list 1 2 3))

(define (compile-op exp target linkage)
  (let ((operator (operator exp))
        (operands (operands exp)))
    (if (and (or (eq? operator '+) (eq? operator '*)) (> (length operands) 2))
        (compile (group-by-two operator operands) target linkage)
        (end-with-linkage
          linkage
          (preserving
            '(env continue)
            (spread-arguments operands)
            (make-instruction-sequence
              '(arg1 arg2)
              (list target)
              `((assign ,target (op ,operator) (reg arg1) (reg arg2)))))))))

(define tx (compile '(+ 1 2 3 4) 'val 'next))
(for-each (lambda (x) (newline) (display x)) (caddr tx))

; (assign arg2 (const 4))
; (assign arg1 (const 3))
; (assign arg2 (op +) (reg arg1) (reg arg2))
; (assign arg1 (const 2))
; (assign arg2 (op +) (reg arg1) (reg arg2))
; (assign arg1 (const 1))
; (assign val (op +) (reg arg1) (reg arg2))

(define tx (compile '(+ 1 2 3 (+ 4 5 (* 6 7 8))) 'val 'next))
(for-each (lambda (x) (newline) (display x)) (caddr tx))

; (assign arg2 (const 8))
; (assign arg1 (const 7))
; (assign arg2 (op *) (reg arg1) (reg arg2))
; (assign arg1 (const 6))
; (assign arg2 (op *) (reg arg1) (reg arg2))
; (assign arg1 (const 5))
; (assign arg2 (op +) (reg arg1) (reg arg2))
; (assign arg1 (const 4))
; (assign arg2 (op +) (reg arg1) (reg arg2))
; (assign arg1 (const 3))
; (assign arg2 (op +) (reg arg1) (reg arg2))
; (assign arg1 (const 2))
; (assign arg2 (op +) (reg arg1) (reg arg2))
; (assign arg1 (const 1))
; (assign val (op +) (reg arg1) (reg arg2))
