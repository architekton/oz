(define nil '())

(define (square-list items)
  (define (iter things answer)
	(if (null? things)
		answer
		(iter (cdr things)
			  (cons (square (car things))
					answer))))
  (iter items nil))

; We extend the resulting list by going through items from the front of the
; original queue hence reversed 

(define (square-list items)
  (define (iter things answer)
	(if (null? things)
		answer
		(iter (cdr things)
			  (cons answer
					(square (car things))))))
  (iter items nil))

; We end up with a nested list structure
