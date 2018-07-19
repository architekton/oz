(define (inc x) (+ 1 x))
(define (ident x) x)

; a)
(define (accumulate combiner null-value term a next b)
  (define (iter a result)
	(if (> a b)
		result
		(iter (next a) (combiner (term a) result))))

  (iter a null-value))

(define (sum term a next b)
  (accumulate + 0 term a next b))

(define (prod term a next b)
  (accumulate * 1 term a next b))


(sum ident 1 inc 5)

(prod ident 1 inc 5)


; b)
(define (accumulate-rec combiner null-value term a next b)
  (if (> a b)
	  null-value
	  (combiner (term a) (accumulate combiner null-value term (next a) next b))))

