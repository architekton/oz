(define (last-pair lst)
  (define (last-pair-iter curr-item lst)
	(if (null? lst)
		curr-item
		(last-pair-iter lst (cdr lst))))

  (last-pair-iter lst (cdr lst)))

(last-pair (list 1 2 3 4))
