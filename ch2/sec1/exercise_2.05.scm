(define (cons x y)
  (* (expt 2 x) (expt 3 y)))


(define (find-exponent d n)
  (define (iter result n)
    (if (= 0 (remainder n d))
        (iter (+ 1 result ) (/ n d))
        result))

  (iter 0 n))

(define (car z)
  (find-exponent 2 z))

(define (cdr z)
  (find-exponent 3 z))

(car (cons 1 2))
(cdr (cons 1 2))
