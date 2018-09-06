(load "streams.scm")

(define (partial-sums s)
  (cons-stream (stream-car s)
               (add-streams (stream-cdr s) (partial-sums s))))

(define z (partial-sums integers))

(stream-ref z 1)
(stream-ref z 2)
(stream-ref z 3)
(stream-ref z 4)
