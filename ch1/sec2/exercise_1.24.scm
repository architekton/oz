(define (expmod base exp m)
  (cond ((= exp 0) 1)
		((even? exp)
		 (remainder (square (expmod base (/ exp 2) m))
					m))
		(else
		  (remainder (* base (expmod base (- exp 1) m))
					 m))))        

(define (fermat-test n)
  (define (try-it a)
	(= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
		((fermat-test n) (fast-prime? n (- times 1)))
		(else false)))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (fast-prime? n 10)
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


; Results are consistent with logarithmic growth
(search-for-primes 10000000000 10000000100)
(search-for-primes 100000000000 100000000100)
