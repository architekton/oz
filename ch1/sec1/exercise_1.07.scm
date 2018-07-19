(define (sqrt-iter guess x)
  (if (good-enough? guess x)
	  guess
	  (sqrt-iter (improve guess x)
				 x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

; Change good-enough to use a relative tolerance between two consecutive
; guesses of 0.001
(define (good-enough? guess x)
  (< (abs(- (improve guess x) guess)) (* guess 0.001)))

(define (sqrt x)
  (sqrt-iter 1.0 x))

(sqrt 9)

; For very large numbers the procedure might never terminate due to the
; evaluation of good-enough to #f. Precision is at fault here because we might
; not be able to represent small differences for very large numbers
(sqrt 10000000000)

; For very small numbers clearly we can exceed the range defined by
; good-enough and present and errornous value
(sqrt 0.0004)
