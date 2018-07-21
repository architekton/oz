(define (average a b c)
  (/ (+ a b c) 3))

(define (smooth f)
  (let ((dx 0.000001))
    (lambda (x) (average (f (- x dx)) (f x) (f (+ x dx))))))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (define (iter c result)
    (if (= c 0)
        result
        (iter (- c 1) (compose f result))))

  (iter n (lambda (x) x)))


((repeated (smooth square) 2) 2)
