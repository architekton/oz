(define (sum term a next b)
  (define (iter a result)
	(if (> a b)
		result
		(iter (next a) (+ result (term a)))))

  (iter a 0))

(define (inc n) (+ n 1))

(sum square 0 inc 5)
