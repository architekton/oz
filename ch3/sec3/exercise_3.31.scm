; TODO add helpers
(define (accept-action-procedure! proc)
  (set! action-procedures (cons proc action-procedures))
  (proc))

; If it is not immediately run, our agenda will be without actions and our
; simulation will not work.
