(load "../mceval.scm")
(load "../ambeval.scm")

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
        ((definition? exp) (analyze-definition exp))
        ((if? exp) (analyze-if exp))
        ((if-fail? exp) (analyze-if-fail exp))
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

(define the-global-environment (setup-environment))
(driver-loop)

(define (an-element-of items)
  (require (not (null? items)))
  (amb (car items) (an-element-of (cdr items))))

(define (require p)
  (if (not p) (amb)))

(if-fail (let ((x (an-element-of '(1 3 5))))
           (require (even? x))
           x)
         'all-odd)

(if-fail (let ((x (an-element-of '(1 3 5 8))))
           (require (even? x))
           x)
         'all-odd)
