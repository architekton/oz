(load "streams.scm")

(define (merge s1 s2 weight)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
          (let ((s1car (stream-car s1))
                (s2car (stream-car s2)))
            (cond ((< (weight s1car) (weight s2car))
                   (cons-stream s1car (merge (stream-cdr s1) s2 weight)))
                  ((> (weight s1car) (weight s2car))
                   (cons-stream s2car (merge s1 (stream-cdr s2) weight)))
                  (else
                    (cons-stream s1car
                                 (merge (stream-cdr s1)
                                        (stream-cdr s2)
                                        weight))))))))

(define (weighted-pairs s t weight)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (merge
      (merge
        (stream-map (lambda (x) (list (stream-car s) x))
                    (stream-cdr t))
        (stream-map (lambda (x) (list (stream-car t) x))
                    (stream-cdr s))
        weight)
      (weighted-pairs (stream-cdr s) (stream-cdr t) weight) weight)))

; a)
(define (weight p)
  (+ (car p) (cadr p)))

(define t (weighted-pairs integers integers weight))
(define f (stream-filter (lambda (p) (< (car p) (cadr p))) t))

; (display-stream f)

; b)
(define (divisible? a)
  (or (= (remainder a 2) 0)
      (or (= (remainder a 3) 0)
          (= (remainder a 5) 0))))

(define (weight p)
  (+ (* 2 (car p))
     (* 3 (cadr p))
     (* 5 (car p) (cadr p))))

(define t (weighted-pairs integers integers weight))
(define f (stream-filter (lambda (p) (and (not (divisible? (car p)))
                                          (not (divisible? (cadr p))))) t))

(display-stream f)



