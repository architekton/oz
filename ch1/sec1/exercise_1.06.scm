; Why if needs to be a special form demonstration.

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
		(else else-clause)))

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
		  guess
		  (sqrt-iter (improve guess x)
					 x)))


(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt x)
  (sqrt-iter 1.0 x))

; Using the sqrt function with the new-if defined above, as lisp is evaluated
; in applicative-order, or as we see in exercise 1.5, the operator and operands
; are evaluated first, therefore all sub-expressions. Sqrt-iter calls itself,
; and new-if evaluates all sub-expressions first, repeating,  we get infinite
; recursion, explaining the behaviour of exceeded recursive depth.
