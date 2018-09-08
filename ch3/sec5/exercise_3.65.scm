(load "streams.scm")

(define (partial-sums s)
  (cons-stream (stream-car s)
               (add-streams (stream-cdr s) (partial-sums s))))


(define (euler-transform s)
  (let ((s0 (stream-ref s 0))
        (s1 (stream-ref s 1))
        (s2 (stream-ref s 2)))
    (cons-stream (- s2 (/ (square (- s2 s1))
                          (+ s0 (* -2 s1) s2)))
                 (euler-transform (stream-cdr s)))))

(define (make-tableau transform s)
  (cons-stream s
               (make-tableau transform
                             (transform s))))

(define (accelerated-sequence transform s)
  (stream-map stream-car
              (make-tableau transform s)))

(define (s n)
  (cons-stream (/ 1.0 n)
               (stream-map - (s (+ 1 n)))))

(define ln2
  (partial-sums (s 1)))

;(display-stream ln2)
;(display-stream (euler-transform ln2))
(display-stream (accelerated-sequence euler-transform ln2))


