; a)
; .
; .
; .
; ev-application
; (save continue)
; (assign unev (op operands) (reg exp))
; (assign exp (op operator) (reg exp))
; (test (op variable?) (reg exp))
; (branch (label ev-appl-no-restore-dispatch))
; (save unev)
; (save env)
; (assign continue (label ev-appl-did-operator))
; (goto (label eval-dispatch))
; ev-appl-no-restore-dispatch
; (assign continue (label ev-appl-did-operator-no-restore))
; (goto (label eval-dispatch))
; ev-appl-did-operator
; (restore unev)
; (restore env)
; ev-appl-did-operator-no-restore
; (assign argl (op empty-arglist))
; (assign proc (reg val))
; (test (op no-operands?) (reg unev))
; (branch (label apply-dispatch))
; (save proc)
; .
; .
; .

; b) It is possible but it would be incredibly inefficient for an evaluator. It
; would increase evaluation time significantly. A compiler would only have to
; perform the optimisations once per compilation, unlike an evaluator.
