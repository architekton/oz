(define x-point car)
(define y-point cdr)

(define start-segment car)
(define end-segment cdr)

(define (make-point x y)
  (cons x y))

(define (make-segment s e)
  (cons s e))

(define (midpoint-segment segment)
  (make-point
    (/ (x-point (start-segment segment)) (x-point (start-segment segment)) 2)
    (/ (y-point (end-segment segment)) (y-point (end-segment segment)) 2)))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(print-point (midpoint-segment (make-segment (make-point 5 5) (make-point 10 10))))

