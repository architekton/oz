; The procedure application will try to evaluate what is supposed to be a an
; assignment as a procedure application.

(define (application? exp) (tagged-list? exp 'call))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

