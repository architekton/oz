(define (even? n)
  (= (remainder n 2) 0))

(define (double x) (+ x x))
(define (halve x) (/ x 2))

(define (* a b)
  (define (mult-iter x a b)
	(cond ((= b 0) x)
		  ((even? b) (mult-iter x (double a) (halve b)))
		  (else (mult-iter (+ x a) a (- b 1)))))

  (mult-iter 0 a b))

(* 2 5)
(* 10 10)

