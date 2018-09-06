(load "streams.scm")

(define factorials
  (cons-stream 1 (mul-streams factorials (stream-cdr integers))))

(stream-ref factorials 1)
(stream-ref factorials 2)
(stream-ref factorials 3)
