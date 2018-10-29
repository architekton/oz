(load "../syntax.scm")
(load "../compiler.scm")


(define tx
  (compile
    '(define (factorial n)
       (if (= n 1)
           1
           (* (factorial (- n 1)) n)))
    'val
    'next))

(for-each (lambda (x) (newline) (display x)) (caddr tx))

; (assign val (op make-compiled-procedure) (label entry2) (reg env))
; (goto (label after-lambda1))
; entry2
; (assign env (op compiled-procedure-env) (reg proc))
; (assign env (op extend-environment) (const (n)) (reg argl) (reg env))
; (save continue)
; (save env)
; (assign proc (op lookup-variable-value) (const =) (reg env))
; (assign val (const 1))
; (assign argl (op list) (reg val))
; (assign val (op lookup-variable-value) (const n) (reg env))
; (assign argl (op cons) (reg val) (reg argl))
; (test (op primitive-procedure?) (reg proc))
; (branch (label primitive-branch17))
; compiled-branch16
; (assign continue (label after-call15))
; (assign val (op compiled-procedure-entry) (reg proc))
; (goto (reg val))
; primitive-branch17
; (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
; after-call15
; (restore env)
; (restore continue)
; (test (op false?) (reg val))
; (branch (label false-branch4))
; true-branch5
; (assign val (const 1))
; (goto (reg continue))
; false-branch4
; (assign proc (op lookup-variable-value) (const *) (reg env))
; (save continue)
; (save proc)
; (assign val (op lookup-variable-value) (const n) (reg env))
; (assign argl (op list) (reg val))
; (save argl)
; (assign proc (op lookup-variable-value) (const factorial) (reg env))
; (save proc)
; (assign proc (op lookup-variable-value) (const -) (reg env))
; (assign val (const 1))
; (assign argl (op list) (reg val))
; (assign val (op lookup-variable-value) (const n) (reg env))
; (assign argl (op cons) (reg val) (reg argl))
; (test (op primitive-procedure?) (reg proc))
; (branch (label primitive-branch8))
; compiled-branch7
; (assign continue (label after-call6))
; (assign val (op compiled-procedure-entry) (reg proc))
; (goto (reg val))
; primitive-branch8
; (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
; after-call6
; (assign argl (op list) (reg val))

;; restore factorial
; (restore proc)
; (test (op primitive-procedure?) (reg proc))
; (branch (label primitive-branch11))
; compiled-branch10
; (assign continue (label after-call9))
; (assign val (op compiled-procedure-entry) (reg proc))

;; here we apply factorial without restoring all saved registers since we will
;; need them after the recursive evaluation of this argument
; (goto (reg val))
; primitive-branch11
; (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
; after-call9
; (restore argl)
; (assign argl (op cons) (reg val) (reg argl))
; (restore proc)
; (restore continue)
; (test (op primitive-procedure?) (reg proc))
; (branch (label primitive-branch14))
; compiled-branch13
; (assign val (op compiled-procedure-entry) (reg proc))
; (goto (reg val))
; primitive-branch14
; (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
; (goto (reg continue))
; after-call12
; after-if3
; after-lambda1
; (perform (op define-variable!) (const factorial) (reg val) (reg env))
; (assign val (const ok))

(define tx
  (compile
    '(define (factorial n)
       (define (iter product counter)
         (if (> counter n)
             product
             (iter (* counter product)
                   (+ counter 1))))
       (iter 1 1))
    'val
    'next))


(for-each (lambda (x) (newline) (display x)) (caddr tx))

; (assign val (op make-compiled-procedure) (label entry19) (reg env))
; (goto (label after-lambda18))

;; factorial procedure
; entry19
; (assign env (op compiled-procedure-env) (reg proc))
; (assign env (op extend-environment) (const (n)) (reg argl) (reg env))
; (assign val (op make-compiled-procedure) (label entry24) (reg env))
; (goto (label after-lambda23))

;; internal iteretive procedure
; entry24
; (assign env (op compiled-procedure-env) (reg proc))
; (assign env (op extend-environment) (const (product counter)) (reg argl) (reg env))
; (save continue)
; (save env)

;; predicate
; (assign proc (op lookup-variable-value) (const >) (reg env))
; (assign val (op lookup-variable-value) (const n) (reg env))
; (assign argl (op list) (reg val))
; (assign val (op lookup-variable-value) (const counter) (reg env))
; (assign argl (op cons) (reg val) (reg argl))
; (test (op primitive-procedure?) (reg proc))
; (branch (label primitive-branch39))
; compiled-branch38
; (assign continue (label after-call37))
; (assign val (op compiled-procedure-entry) (reg proc))
; (goto (reg val))

;; primitive branch gets called
; primitive-branch39
; (assign val (op apply-primitive-procedure) (reg proc) (reg argl))

;; test predicate true false and jump to correct branch
; after-call37
; (restore env)
; (restore continue)
; (test (op false?) (reg val))
; (branch (label false-branch26))

;; return the product
; true-branch27
; (assign val (op lookup-variable-value) (const product) (reg env))
; (goto (reg continue))

;; call the iter procedure
; false-branch26
; (assign proc (op lookup-variable-value) (const iter) (reg env))
; (save continue)
; (save proc)
; (save env)
; (assign proc (op lookup-variable-value) (const +) (reg env))
; (assign val (const 1))
; (assign argl (op list) (reg val))
; (assign val (op lookup-variable-value) (const counter) (reg env))
; (assign argl (op cons) (reg val) (reg argl))
; (test (op primitive-procedure?) (reg proc))
; (branch (label primitive-branch33))
; compiled-branch32
; (assign continue (label after-call31))
; (assign val (op compiled-procedure-entry) (reg proc))
; (goto (reg val))

;; primitive branch will be called +
; primitive-branch33
; (assign val (op apply-primitive-procedure) (reg proc) (reg argl))

;; next argument
; after-call31
; (assign argl (op list) (reg val))
; (restore env)
; (save argl)
; (assign proc (op lookup-variable-value) (const *) (reg env))
; (assign val (op lookup-variable-value) (const product) (reg env))
; (assign argl (op list) (reg val))
; (assign val (op lookup-variable-value) (const counter) (reg env))
; (assign argl (op cons) (reg val) (reg argl))
; (test (op primitive-procedure?) (reg proc))
; (branch (label primitive-branch30))
; compiled-branch29
; (assign continue (label after-call28))
; (assign val (op compiled-procedure-entry) (reg proc))
; (goto (reg val))

;; again primitive branch is called *
; primitive-branch30
; (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
; after-call28

;; we cons the new value to the argument list
; (restore argl)
; (assign argl (op cons) (reg val) (reg argl))

;; proc is restored to iter
; (restore proc)
; (restore continue)
; (test (op primitive-procedure?) (reg proc))
; (branch (label primitive-branch36))

;; goes to compiled branch
; compiled-branch35
; (assign val (op compiled-procedure-entry) (reg proc))
; (goto (reg val))
; primitive-branch36
; (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
; (goto (reg continue))
; after-call34
; after-if25
; after-lambda23
; (perform (op define-variable!) (const iter) (reg val) (reg env))
; (assign val (const ok))
; (assign proc (op lookup-variable-value) (const iter) (reg env))
; (assign val (const 1))
; (assign argl (op list) (reg val))
; (assign val (const 1))
; (assign argl (op cons) (reg val) (reg argl))
; (test (op primitive-procedure?) (reg proc))
; (branch (label primitive-branch22))
; compiled-branch21
; (assign val (op compiled-procedure-entry) (reg proc))
; (goto (reg val))
; primitive-branch22
; (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
; (goto (reg continue))
; after-call20
; after-lambda18
; (perform (op define-variable!) (const factorial) (reg val) (reg env))
; (assign val (const ok))

; We restore everything we have saved within the iter procedure before calling
; it again since we just evaluate the 2 arguments add them to argl and then
; call the function again with the new arguments.

