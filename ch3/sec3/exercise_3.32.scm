(define (and-gate a1 a2 output)
  (define (and-action-procedure)
    (let ((new-value
            (logical-and (get-signal a1) (get-signal a2))))
      (after-delay and-gate-delay
                   (lambda ()
                     (set-signal! output new-value)))))
  (add-action! a1 and-action-procedure)
  (add-action! a2 and-action-procedure)
  'ok)

; Tracing through the agenda when the inputs change from 0 1 to 1 0
; 0 1
; 1 1
; 1 0
; Call action procedure set output to 1
; Call action procedure set output to 0

; The above is correct but if we had a stack instead the output would be 1,
; hence wrong.
