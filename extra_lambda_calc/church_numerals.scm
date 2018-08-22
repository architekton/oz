; Definition for zero and false, thex are the same
(define zero
  (lambda (f x) x))

(define false zero)

; Definition for one
(define one
  (lambda (f x) (f x)))

; Definition for two
(define two
  (lambda (f x) (f (f x))))

;.
;.
;.

(define (inc x)
  (+ x 1))

(two inc 0)
