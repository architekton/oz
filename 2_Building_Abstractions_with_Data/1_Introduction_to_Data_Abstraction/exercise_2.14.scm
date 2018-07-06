(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
				 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
		(p2 (* (lower-bound x) (upper-bound y)))
		(p3 (* (upper-bound x) (lower-bound y)))
		(p4 (* (upper-bound x) (upper-bound y))))
	(make-interval (min p1 p2 p3 p4)
				   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval x
				(make-interval (/ 1.0 (upper-bound y))
							   (/ 1.0 (lower-bound y)))))



(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
				 (- (upper-bound x) (lower-bound y))))

(define (make-interval a b) (cons a b))

(define (lower-bound z) (min (car z) (cdr z)))
(define (upper-bound z) (max (car z) (cdr z)))

(define (div-interval x y)
  (if (= (upper-bound y) (lower-bound y))
	  (error "zero division")
	  (mul-interval x
					(make-interval (/ 1.0 (upper-bound y))
								   (/ 1.0 (lower-bound y))))))

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (make-center-percent c p)
  (make-interval (- c (* c (/ p 100))) (+ c (* c (/ p 100)))))

(define (percent i)
  (* 100 (/ (width i) (center i))))


(define (print-interval r)
  (newline)
  (display "[")
  (display (lower-bound r))
  (display ", ")
  (display (upper-bound r))
  (display "]"))


(print-interval 
  (div-interval
	(make-center-percent 1 1)
	(make-center-percent 1 2)))

