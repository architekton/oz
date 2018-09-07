(load "streams.scm")

(define (average a b) (/ (+ a b) 2))

(define (sqrt-improve guess x)
  (average guess (/ x guess)))

(define (sqrt-stream x)
  (define guesses
    (cons-stream
      1
      (stream-map (lambda (guess) (sqrt-improve guess x))
      guesses)))
  guesses)

(define (stream-limit stream tolerance)
  (let ((a (stream-ref stream 0))
        (b (stream-ref stream 1)))
    (if (< (abs (- a b)) tolerance)
        b
        (stream-limit (stream-cdr stream) tolerance))))

(define (sqrt x tolerance)
  (stream-limit (sqrt-stream x) tolerance))

(exact->inexact (sqrt 2 0.000001))



