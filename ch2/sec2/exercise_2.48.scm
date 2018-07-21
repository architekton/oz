(define (make-vect x y)
  (cons x y))

(define xcor-vect car)
(define ycor-vect cdr)

(define (add-vect v1 v2)
  (make-vect (+ (xcor-vect v1) (xcor-vect v2))
			 (+ (ycor-vect v1) (ycor-vect v2))))

(define (sub-vect v1 v2)
  (make-vect (- (xcor-vect v1) (xcor-vect v2))
			 (- (ycor-vect v1) (ycor-vect v2))))

(define (scale-vect m v2)
  (make-vect (* m (xcor-vect v2))
			 (* m (ycor-vect v2))))

(define make-segment cons)
(define start-segment car)
(define end-segment cdr)


