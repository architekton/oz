(define (make-accumulator initial-amount)
  (lambda (amount)
    (begin (set! initial-amount (+ initial-amount amount))
           initial-amount)))

(define A (make-accumulator 5))

(A 10)
(A 10)
