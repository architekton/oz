(define (expmod base exp m)
  (define (square-check n)
    (if (and (= (remainder (square n) m) 1)
             (not (= n 1))
             (not (= n (- m 1))))
        0
        (remainder (square n) m)))

  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square-check (expmod base (/ exp 2) m))
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

(define (miller-rabin-prime? n)
  (fast-prime? n 10))

(miller-rabin-prime? 17)
(miller-rabin-prime? 21)

; Taken from the footnote in the book, Carmichael numbers
(miller-rabin-prime? 561)
(miller-rabin-prime? 1105)
(miller-rabin-prime? 1729)
(miller-rabin-prime? 2465)
(miller-rabin-prime? 2821)
(miller-rabin-prime? 6601)


