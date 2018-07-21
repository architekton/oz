(define (p) (p))

(define (test x y)
  (if (= x 0) 0 y))

(test 0 (p))

; What is the observation with - applicative-order evaluation
;                               - normal-order evaluation
;
; Applicative-order:
; Infinite recursion since p evaluates to itself
;
; Normal-order:
; p never has to evaluate because the if statement evaluates to true hence the
; result is 0
