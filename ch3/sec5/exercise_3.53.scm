; powers of two, keeps doubling the stream recursively
(define s (cons-stream 1 (add-streams s s)))



