(load "streams.scm")

(define sum 0)

(define (accum x)
  (set! sum (+ x sum))
  sum)

; sum = 1
; first number in sequence
(define seq (stream-map accum (stream-enumerate-interval 1 20)))

; sum = 1 + 2 + 3 = 6
; first even number in sequence
(define y (stream-filter even? seq))

; sum = 10
; first number divisible by 5 in the sequence
(define z (stream-filter (lambda (x) (= (remainder x 5) 0))
                         seq))

; the sum up to the 7th even number
(stream-ref y 7)

; display all multiples of 5 in the sequence
(display-stream z)

; Without the memo-proc, accum would keep getting called on forcing the
; calculation of the stream and our sum would not be the same.
