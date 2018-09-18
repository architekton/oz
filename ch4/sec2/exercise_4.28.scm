; An example may be a compound procedure that has to be evaluated before the
; call to apply such as

(define (lt? a b) (< a b))

; lt? is a thunk here because it's delayed and (pred? x y) will fail and print an error
(define (proc pred? x y) (pred? x y))

(apply proc (list lt? 1 2))
