;;; An interesting extract from the book page 28-29. 
;;;
;;; The contrast between function and procedure is a reflection of the
;;; general distinction between describing properties of things and describ-
;;; ing how to do things, or, as it is sometimes referred to, the distinction
;;; between declarative knowledge and imperative knowledge. In mathe-
;;; matics we are usually concerned with declarative (what is) descriptions,
;;; whereas in computer science we are usually concerned with imperative
;;; (how to) descriptions.

;;; Taking the calculation of a square root as an example.
;;; x^(1/2) = y such that y >= 0 and y^2 = x 
;;; 
;;; The above is the declarative definition of a square root, and perfect valid
;;; mathematical function. However it gives no information on imperative
;;; descriptions. An imperative procedure would be Newton's method, in this
;;; case.

;;; https://en.wikipedia.org/wiki/Newton%27s_method

;;; The following is extracted from the book:

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
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

(sqrt 49)
