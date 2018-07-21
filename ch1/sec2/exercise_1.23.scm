(define (next test-divisor)
  (if (= 2 test-divisor)
      3
      (+ 2 test-divisor)))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (search-for-primes a b)
  (define (prime-iter n)
    (if (<= n b) (timed-prime-test n))
    (if (<= n b) (prime-iter (+ 2 n))))

  (prime-iter (if (even? a)
                  (+ a 1)
                  a)))



(search-for-primes 1000 1500)
(search-for-primes 10000 10500)
(search-for-primes 100000 100500)
(search-for-primes 1000000 1000500)


; Meaningful timing, results are consistent with growth sqrt(10)
(search-for-primes 10000000000 10000000100)
(search-for-primes 100000000000 100000000100)

; With the improved divisor it takes 2/3 of the time the old one takes.
; We introduce another conditional statement in our next procedure, hence we
; won't get a ratio of 1/2.
