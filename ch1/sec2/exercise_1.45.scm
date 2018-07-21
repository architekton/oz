(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (average x y)
  (/ (+ x y) 2))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (define (iter c result)
    (if (= c 0)
        result
        (iter (- c 1) (compose f result))))

  (iter n (lambda (x) x)))

(define (nth-root x n)
  (fixed-point 
    (repeated 
      (average-damp 
        (lambda (y) 
          (/ x (expt y (- n 1)))))
      (floor (/ (log n) (log 2))))
    1.0))


(nth-root 8 3)

