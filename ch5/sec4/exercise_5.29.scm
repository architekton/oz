(load "../regsim.scm")
(load "../syntax.scm")
(load "../eceval-support.scm")
(load "../eceval.scm")

(define the-global-environment (setup-environment))
(start eceval)

(define (fib n)
  (if (< n 2)
      n
      (+ (fib (- n 1)) (fib (- n 2)))))

(fib 0)
(fib 1)
(fib 2)
(fib 3)
(fib 4)
(fib 5)
(fib 6)
(fib 7)

; a)
; Maximum depth: 3 + 5n

; b)
; Number of pushes:
; S(n) = S(n - 1) + S(n - 2) + k
; S(2) = 16 + 16 + 40 = 72
; S(3) = 72 + 16 + 40 = 128
; .
; .
; .

; a*Fib(n+1) + b
; 2a + b = 72
; 3a + b = 128
; a = 56
; b = -40


