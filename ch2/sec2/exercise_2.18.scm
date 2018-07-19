(define (reverse lst)
  (define (reverse-iter lst result)
	(if (null? lst)
		result
		(reverse-iter (cdr lst) (cons (car lst) result))))

  (reverse-iter lst '()))

(reverse (list 1 2 3 4))

(reverse '())
