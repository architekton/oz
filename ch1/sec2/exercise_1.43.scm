(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (define (iter c result)
    (if (= c 0)
        result
        (iter (- c 1) (compose f result))))

  (iter n (lambda (x) x)))

((repeated square 2) 5)

(define (repeated f n)
  (if (= n 0)
      (lambda (x) x)
      (compose f (repeated f (- n 1)))))


((repeated square 2) 5)

