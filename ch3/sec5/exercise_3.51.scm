(load "streams.scm")

(define (show x)
  (display-line x)
  x)

; This shows only the first item in the stream
(define x
  (stream-map show (stream-enumerate-interval 0 10)))

; Here we request items 1-5 to be mapped to show
(stream-ref x 5)

; Here we request items 6-7 to be mapped to show continuing where we had left
; off
(stream-ref x 7)


