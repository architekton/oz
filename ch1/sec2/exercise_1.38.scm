(define (cont-frac-iter n d k)
  (define (iter c result)
    (if (= c 0)
        result
        (iter (- c 1) (/ (n c) (+ (d c) result)))))

  (iter k 0))

(+ 2 (cont-frac-iter 
       (lambda (x) 1.0) 
       (lambda (x) (if (= (remainder x 3) 2)
                       (/ (+ x 1) (/ 3 2))
                       1.0))
       10))
