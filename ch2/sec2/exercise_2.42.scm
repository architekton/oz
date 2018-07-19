(define nil '())

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
		((predicate (car sequence))
		 (cons (car sequence)
			   (filter predicate (cdr sequence))))
		(else (filter predicate (cdr sequence)))))


(define (accumulate op initial sequence)
  (if (null? sequence)
	  initial
	  (op (car sequence)
		  (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(define (enumerate-interval low high) 
  (if (> low high) 
	  nil 
	  (cons low (enumerate-interval (+ low 1) high))))


; The representation I chose for positions was just a coordinate pair. A
; solution is represented by n positions of queens. All solutions are represented
; by m * n coordinate pairs, where m is the number of solutions. The described 
; structure has a depth of 2 (starting form 0)

(define empty-board nil)

(define (adjoin-position new-row k rest-of-queens)
  (cons (list new-row k) rest-of-queens))

(define (safe? k positions)
  (define (col-safe-iter? row positions count)
	(if (= count k)
		#t
		(let ((curr-row (caar positions)))
		  (if (or (= curr-row row)
				  (= (+ curr-row count) row)
				  (= (- curr-row count) row))
			  #f
			  (col-safe-iter? row (cdr positions) (+ 1 count))))))
  (col-safe-iter? (caar positions) (cdr positions) 1))

(define (queens board-size)
  (define (queen-cols k)
	(if (= k 0)
		(list empty-board)
		(filter
		  (lambda (positions) (safe? k positions))
		  (flatmap
			(lambda (rest-of-queens)
			  (map (lambda (new-row)
					 (adjoin-position new-row k rest-of-queens))
				   (enumerate-interval 1 board-size)))
			(queen-cols (- k 1))))))
  (queen-cols board-size))

(length (queens 1))
(length (queens 2))
(length (queens 3))
(length (queens 4))
(length (queens 5))
(length (queens 6))
(length (queens 7))
(length (queens 8))
(length (queens 9))
