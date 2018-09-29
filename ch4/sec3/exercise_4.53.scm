(load "../mceval.scm")
(load "../ambeval.scm")

(define (permanent-assignment? exp)
  (tagged-list? exp 'permanent-set!))

(define (if-fail? exp)
  (tagged-list? exp 'if-fail))

(define (if-fail-succ exp) (cadr exp))
(define (if-fail-fail exp) (caddr exp))

(define (analyze exp)
  (cond ((self-evaluating? exp)
         (analyze-self-evaluating exp))
        ((quoted? exp) (analyze-quoted exp))
        ((variable? exp) (analyze-variable exp))
        ((assignment? exp) (analyze-assignment exp))
        ((permanent-assignment? exp) (analyze-permanent exp))
        ((if-fail? exp) (analyze-if-fail exp))
        ((definition? exp) (analyze-definition exp))
        ((if? exp) (analyze-if exp))
        ((lambda? exp) (analyze-lambda exp))
        ((begin? exp) (analyze-sequence (begin-actions exp)))
        ((cond? exp) (analyze (cond->if exp)))
        ((let? exp) (analyze (let->combination exp))) ;**
        ((amb? exp) (analyze-amb exp))                ;**
        ((application? exp) (analyze-application exp))
        (else
          (error "Unknown expression type -- ANALYZE" exp))))

(define (analyze-if-fail exp)
  (let ((sout (analyze (if-fail-succ exp)))
        (fout (analyze (if-fail-fail exp))))
    (lambda (env succeed fail)
      (sout env
            (lambda (val fail2)
              (succeed val fail2))
            (lambda ()
              (fout env succeed fail))))))

; same as analyze-assignment except we do not go back to the old value so we
; don't need the second branch

(define (analyze-permanent exp)
  (let ((var (assignment-variable exp))
        (vproc (analyze (assignment-value exp))))
    (lambda (env succeed fail)
      (vproc env
             (lambda (val fail2)        ; *1*
               (set-variable-value! var val env)
               (succeed 'ok fail2))
             fail))))


(define the-global-environment (setup-environment))
(driver-loop)

(define (require p)
  (if (not p) (amb)))

(define (an-element-of items)
  (require (not (null? items)))
  (amb (car items) (an-element-of (cdr items))))

(define (prime? n)
  (define (loop d)
    (cond ((< n (* d d)) true)
          ((zero? (modulo n d)) false)
          (else (loop (+ d 1)))))
  (loop 2))

(define (prime-sum-pair list1 list2)
  (let ((a (an-element-of list1))
        (b (an-element-of list2)))
    (require (prime? (+ a b)))
    (list a b)))

(let ((pairs '()))
  (if-fail
    (let ((p (prime-sum-pair '(1 3 5 8)
                             '(20 35 110))))
      (permanent-set! pairs (cons p pairs))
      (amb))
    pairs))

; ;;; Starting a new problem
; ;;; Amb-Eval value:
; ((8 35) (3 110) (3 20))
;
; ;;; Amb-Eval input:
; End of input stream reached.
; Moriturus te saluto.
