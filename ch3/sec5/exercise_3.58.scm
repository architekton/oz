(load "streams.scm")

(define (expand num den radix)
  (cons-stream
    (quotient (* num radix) den)
    (expand (remainder (* num radix) den) den radix)))

(define x (stream-map display-line (expand 1 7 10)))
(define y (stream-map display-line (expand 3 8 10)))

(stream-ref x 10)
(stream-ref y 10)

(define p (stream-map display-line (expand 355 1130 10)))
(stream-ref p 10)

; num / den in base radix. The stream represents the numerical result of the
; division

