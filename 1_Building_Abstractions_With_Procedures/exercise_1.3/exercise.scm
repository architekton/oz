;;; Create a procedure that takes 3 numbers and returns the sum of squares of
;;; the two larger ones.

(define (square x) (* x x))

(define (sum-of-squares x y)
  (+ (square x) (square y)))

(define (sum-of-square-largest-two x y z)
  (cond ((and (< x y) (< x z)) (sum-of-squares y z))
		((and (< y x) (< y z)) (sum-of-squares x z))
		((and (< z x) (< z y)) (sum-of-squares y x))))

(sum-of-square-largest-two 3 1 5)
