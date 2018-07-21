(define (iterative-improve improve-guess good-enough?)
  (lambda (guess) 
    (define (iter x)
      (if (good-enough? x)
          x
          (iter (improve-guess x))))

    (iter guess)))

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) 0.000001))

  ((iterative-improve f (lambda (x) (close-enough? x (f x)))) first-guess))

(define (sqrt x)
  (define (average x y)
    (/ (+ x y) 2))

  (define (close-enough? guess)
    (< (abs (- (square guess) x)) 0.0001))

  ((iterative-improve (lambda (y) (average y (/ x y))) close-enough?) 1.0))

(sqrt 4)

(define (sqrt-fixed-point x)
  (define (average x y)
    (/ (+ x y) 2))

  (define (average-damp f)
    (lambda (x) (average x (f x))))

  (fixed-point (average-damp (lambda (y) (/ x y))) 1.0))

(sqrt-fixed-point 4)

