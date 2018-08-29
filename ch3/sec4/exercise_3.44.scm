; (define (transfer from-account to-account amount)
;   ((from-account 'withdraw) amount)
;   ((to-account 'deposit) amount))

; He is not right. This is equivalent to calling two serialized procedures.
; Unlike the exchange procedure there is no variable we need to calculate
; before calling these, the amount is predefined.
