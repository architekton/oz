; prime test
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

; accumulate
(define (accumulate combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner (term a) result))))

  (iter a null-value))

(define (sum term a next b)
  (accumulate + 0 term a next b))

(define (prod term a next b)
  (accumulate * 1 term a next b))

(define (filtered-accumulate filter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (if (filter a)
                           (combiner (term a) result) 
                           result))))

  (iter a null-value))


; a)
(define (inc n) (+ n 1))

(define (sum-squared-prime a b)
    (filtered-accumulate miller-rabin-prime? + 0 square a inc b))

(sum-squared-prime 2 10)


; b)
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (rel-prime? i n)
  (= (gcd i n) 1))

(define (ident x) x)

(define (prod-rel-prime n)
  (define (filter i)
    (rel-prime? i n))

  (filtered-accumulate filter * 1 ident 1 inc n))

(prod-rel-prime 10)
