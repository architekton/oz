(load "../mceval.scm")
(load "../analyzingmceval.scm")

; a)
; Any procedure which will require the same thunk to be forced many times will
; benefit from memoization.

; b)
; ;;; M-Eval input:
; (define w (id (id 10)))
; ;;; M-Eval value:
; ok
;
; ;;; M-Eval input:
; count
; ;;; M-Eval value:
; 2
;
; ;;; M-Eval input:
; w
; ;;; M-Eval value:
; 10
;
; ;;; M-Eval input:
; count
; ;;; M-Eval value:
; 2


(driver-loop)

(define count 0)
(define (id x) (set! count (+ count 1)) x)
(define (square x) (* x x))
(define w (id (id 10)))

count
w
count
