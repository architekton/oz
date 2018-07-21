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

(define (transform-painter painter origin corner1 corner2)
  (lambda (frame)
	(let ((m (frame-coord-map frame)))
	  (let ((new-origin (m origin)))
		(painter
		  (make-frame new-origin
					  (sub-vect (m corner1) new-origin)
					  (sub-vect (m corner2) new-origin)))))))


; From book
(define (flip-vert painter)
  (transform-painter painter
					 (make-vect 0.0 1.0)    
					 (make-vect 1.0 1.0)    
					 (make-vect 0.0 0.0)))  

(define (rotate90 painter)
  (transform-painter painter
					 (make-vect 1.0 0.0)
					 (make-vect 1.0 1.0)
					 (make-vect 0.0 0.0)))

(define (flip-horiz painter)
  (transform-painter painter 
					 (make-vect 1.0 0.0)
					 (make-vect 0.0 0.0)
					 (make-vect 1.0 1.0)))

(define (rotate180 painter)
  (flip-vert painter))

(define (rotate270 painter)
  ((rotate90 flip-vert) painter)
