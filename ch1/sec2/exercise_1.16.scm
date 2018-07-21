; (define (fast-expt b n)
;   (cond ((= n 0) 1)
;       ((even? n) (square (fast-expt b (/ n 2))))
;       (else (* b (fast-expt b (- n 1))))))

(define (even? n)
  (= (remainder n 2) 0))

(define (fast-expt b n)
  (define (fast-expt-iter a b n)
    (cond ((= n 0) a)
          ((even? n) (fast-expt-iter a (square b) (/ n 2)))
          (else (fast-expt-iter (* a b) b (- n 1)))))

  (fast-expt-iter 1 b n))

(fast-expt 5 0)
(fast-expt 5 1)
(fast-expt 5 2)
(fast-expt 5 3)
