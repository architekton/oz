(define (rec-process n) 
  (if (< n 3) 
      n
      (+ (rec-process (- n 1))
         (* 2 (rec-process (- n 2)))
         (* 3 (rec-process (- n 3))))))

(rec-process 0)
(rec-process 1)
(rec-process 2)
(rec-process 3)
(rec-process 4)
(rec-process 5)
(rec-process 6)

(define (iter-process n)
  (define (iter a b c count)
    (if (= count 0)
        a
        (iter b c (+ c (* 2 b) (* 3 a)) (- count 1))))

  (iter 0 1 2 n))

(iter-process 0)
(iter-process 1)
(iter-process 2)
(iter-process 3)
(iter-process 4)
(iter-process 5)
(iter-process 6)
