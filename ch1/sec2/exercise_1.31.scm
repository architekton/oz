(define (prod-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))

  (iter a 1))

; b)
(define (prod-rec term a next b)
  (if (> a b)
      1
      (* (term a)
         (prod-rec term (next a) next b))))

(define (inc n) (+ n 1))

; a) 

; factorial
(define (ident x) x)

(define (factorial-iter n)
  (prod-iter ident 1 inc n))

(define (factorial-rec n)
  (prod-rec ident 1 inc n))

(factorial-iter 1)
(factorial-iter 2)
(factorial-iter 3)
(factorial-iter 4)
(factorial-iter 5)

(factorial-rec 1)
(factorial-rec 2)
(factorial-rec 3)
(factorial-rec 4)
(factorial-rec 5)

; pi
(define (pi-term x)
  (if (even? x)
      (/ (+ x 2) (+ x 1))
      (/ (+ x 1) (+ x 2))))

(define (pi-approx-iter n)
  (* 4.0 (prod-iter pi-term 1 inc n)))

(define (pi-approx-rec n)
  (* 4.0 (prod-rec pi-term 1 inc n)))

(pi-approx-iter 1000)

(pi-approx-rec 1000)
