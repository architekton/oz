;;; Newton's method applied to calculate cube roots, by the given formula in the
;;; book, with the improved good-enough? created for exercise 1.7

(define (cube-root-iter guess x)
  (if (good-enough? guess x)
	  guess
	  (cube-root-iter (improve guess x)
				 x)))

(define (improve guess x)
 (/ (+ (/ x (square guess)) (* 2 guess)) 3))

(define (good-enough? guess x)
  (< (abs(- (improve guess x) guess)) (* guess 0.001)))

(define (cube-root x)
  (cube-root-iter 1.0 x))

(cube-root 1000)
