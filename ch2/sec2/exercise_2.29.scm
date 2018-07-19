(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

; a)

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (car (cdr mobile)))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (car (cdr branch)))


; b)
(define (total-weight mobile)
  (if (null? mobile)
	  0
	  (if (pair? mobile)
		  (+ (total-weight (branch-structure (left-branch mobile)))
			 (total-weight (branch-structure (right-branch mobile))))
		  mobile)))


; c)
(define (mobile-balanced? mobile)
  (if (pair? mobile)
	  (= (* (total-weight (branch-structure (left-branch mobile)))
			(branch-length (left-branch mobile)))
		 (* (total-weight (branch-structure (right-branch mobile)))
			(branch-length (right-branch mobile))))
	  #t))


(define x (make-mobile (make-branch 5 10) (make-branch 5 10)))
(total-weight x)
(mobile-balanced? x)

; d) Only the selectors

(define (make-mobile left right)
  (cons left right))

(define (make-branch length structure)
  (cons length structure))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (cdr mobile))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (cdr branch))


(define x (make-mobile (make-branch 5 10) (make-branch 5 10)))
(total-weight x)
(mobile-balanced? x)

