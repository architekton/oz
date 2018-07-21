; Iterative process
(define (cont-frac-iter n d k)
  (define (iter c result)
    (if (= c 0)
        result
        (iter (- c 1) (/ (n c) (+ (d c) result)))))

  (iter k 0))

; Approximation within 4 decimal places when k = 12
(/ 1 (cont-frac-iter (lambda (i) 1.0) (lambda (i) 1.0) 12))

; Recursive process
(define (cont-frac-rec n d k)
  (if (= k 0)
      0
      (/ (n k) (+ (d k) (cont-frac-rec n d (- k 1))))))

(/ 1 (cont-frac-rec (lambda (i) 1.0) (lambda (i) 1.0) 12))
