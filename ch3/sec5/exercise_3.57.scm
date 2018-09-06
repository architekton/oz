(load "streams.scm")

(define fibs
  (cons-stream
    0
    (cons-stream 1 (add-streams (stream-cdr fibs) fibs))))

; a)
; n - 1


; b)
; without the memo-proc procedure we would have to recompute the whole fib tree
; which would cost an order of phi ^ n
