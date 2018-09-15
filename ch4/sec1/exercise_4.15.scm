(define (run-forever) (run-forever))

(define (try p)
  (if (halts? p p) (run-forever) 'halted))

; (try try)
; (halts? try try) (run-forever) 'halted
; if the predicate returns true, we run-forever.
; if the predicate returns false, we halt.

; this violated the intended behaviour
