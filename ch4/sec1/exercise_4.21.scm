((lambda (n)
   ((lambda (fact) (fact fact n))
    (lambda (ft k) (if (= k 1) 1 (* k (ft ft (- k 1)))))))
 3)

; a)
((lambda (n)
   ((lambda (fib) (fib fib n))
    (lambda (ft k) (if (or (= k 1) (= k 0))
                       k
                       (+ (ft ft (- k 1)) (ft ft (- k 2)))))))
 8)

; 21

; b)
(define (f x)
  ((lambda (even? odd?) (even? even? odd? x))
   (lambda (ev? od? n)
     (if (= n 0) true (od? ev? od? (- n 1))))
   (lambda (ev? od? n)
     (if (= n 0) false (ev? ev? od? (- n 1))))))
