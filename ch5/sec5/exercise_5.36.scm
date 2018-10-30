(load "../syntax.scm")
(load "../compiler.scm")

(define tx (compile '(+ 1 (* 2 3)) 'val 'next))

(for-each (lambda (x) (newline) (display x)) (caddr tx))

(define (compile-application exp target linkage)
  (let ((proc-code (compile (operator exp) 'proc 'next))
        (operand-codes
          (map (lambda (operand) (compile operand 'val 'next))
               (operands exp))))
    (preserving '(env continue)
                proc-code
                (preserving '(proc continue)
                            (tack-on-instruction-sequence
                              (construct-arglist operand-codes)
                              (make-instruction-sequence
                                '(argl)
                                '(argl)
                                '((assign argl (op reverse) (reg argl)))))
                            (compile-procedure-call target linkage)))))

(define (construct-arglist operand-codes)
  ; removed reverse
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
                          (cdr operand-codes)))))))

(define tx (compile '(+ 1 (* 2 3)) 'val 'next))

(for-each (lambda (x) (newline) (display x)) (caddr tx))

;; ORIGINAL RIGHT TO LEFT (because we cons the arguments to the start of the
;; list)
; (assign proc (op lookup-variable-value) (const +) (reg env))
; (save proc)
; (assign proc (op lookup-variable-value) (const *) (reg env))
; (assign val (const 3))
; (assign argl (op list) (reg val))
; (assign val (const 2))
; (assign argl (op cons) (reg val) (reg argl))
; (test (op primitive-procedure?) (reg proc))
; (branch (label primitive-branch3))
; compiled-branch2
; (assign continue (label after-call1))
; (assign val (op compiled-procedure-entry) (reg proc))
; (goto (reg val))
; primitive-branch3
; (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
; after-call1
; (assign argl (op list) (reg val))
; (assign val (const 1))
; (assign argl (op cons) (reg val) (reg argl))
; (restore proc)
; (test (op primitive-procedure?) (reg proc))
; (branch (label primitive-branch6))
; compiled-branch5
; (assign continue (label after-call4))
; (assign val (op compiled-procedure-entry) (reg proc))
; (goto (reg val))
; primitive-branch6
; (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
; after-call4

;; LEFT TO RIGHT
; (assign proc (op lookup-variable-value) (const +) (reg env))
; (save proc)
; (assign val (const 1))
; (assign argl (op list) (reg val))
; (save argl)
; (assign proc (op lookup-variable-value) (const *) (reg env))
; (assign val (const 2))
; (assign argl (op list) (reg val))
; (assign val (const 3))
; (assign argl (op cons) (reg val) (reg argl))

;; after we finish constructing the argument list reverse them in order to
;; match the argument list to the expected argument order of the procedure.
; (assign argl (op reverse) (reg argl))

; (test (op primitive-procedure?) (reg proc))
; (branch (label primitive-branch9))
; compiled-branch8
; (assign continue (label after-call7))
; (assign val (op compiled-procedure-entry) (reg proc))
; (goto (reg val))
; primitive-branch9
; (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
; after-call7
; (restore argl)
; (assign argl (op cons) (reg val) (reg argl))
; (assign argl (op reverse) (reg argl))
; (restore proc)
; (test (op primitive-procedure?) (reg proc))
; (branch (label primitive-branch12))
; compiled-branch11
; (assign continue (label after-call10))
; (assign val (op compiled-procedure-entry) (reg proc))
; (goto (reg val))
; primitive-branch12
; (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
; after-call10


;; Efficiency is the same roughly, one reverses during compile time and one
;; during run time. I guess you could save compilation time. Either way it's a
;; compromise.
