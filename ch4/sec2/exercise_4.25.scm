(define (unless condition usual-value exceptional-value)
  (if condition exceptional-value usual-value))

(define (factorial n)
  (unless (= n 1)
    (* n (factorial (- n 1)))
    1))

(factorial 5)
; No it won't work because the arguments are evaluated before passed to unless
; hence we get infinite recursion depth because the branching does not evaluate
; the condition and only one of the two arguments, instead it evaluates all 3.

; Yes for the contrary reasons.
