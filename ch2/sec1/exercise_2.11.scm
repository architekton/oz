(define (make-interval a b) (cons a b))

(define (lower-bound z) (min (car z) (cdr z)))
(define (upper-bound z) (max (car z) (cdr z)))

(define (sign lower upper)
  (cond ((and (> lower 0) (> upper 0)) 1)
        ((and (< lower 0) (< upper 0)) -1)
        (else 0)))


; TODO
