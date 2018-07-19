(define (cont-frac-iter n d k)
  (define (iter c result)
	(if (= c 0)
		result
		(iter (- c 1) (/ (n c) (+ (d c) result)))))

  (iter k 0))


(define (tan-cf x k)
  (cont-frac-iter 
	(lambda (n) (if (= n 1) 
					x 
					(- (square x))))
	(lambda (n) (- (* 2 n) 1.0))
	k))

(tan-cf 1.0 5)
