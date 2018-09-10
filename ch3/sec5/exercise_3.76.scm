(define (smooth s)
  (stream-map
    (lambda (x y)
      (/ (+ x y) 2))
    s
    (stream-cdr s)))

(define (zero-crossings input-stream)
  (let ((sm (smooth input-stream)))
    (stream-map sign-change-detector input-stream (stream-cdr input-stream))))



