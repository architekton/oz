(load "../regsim.scm")
(load "../syntax.scm")
(load "../eceval-support.scm")
(load "../eceval.scm")

(define the-global-environment (setup-environment))
(start eceval)

(define (factorial n)
  (define (iter product counter)
    (if (> counter n)
    product
    (iter (* counter product) (+ counter 1))))
  (iter 1 1))

(factorial 1)
(factorial 2)
(factorial 3)
(factorial 4)
(factorial 5)

; a) 10
; b) 29 + 35n
