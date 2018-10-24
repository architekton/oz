; ev-cond
; (assign unev (op cond-clauses) (reg exp))
;
; ev-cond-loop
; (assign exp (op first-clause) (reg unev))
; (test (op (cond-else-clause?) (reg exp)))
; (branch (label ev-cond-else))
; (save continue)
; (save env)
; (save exp)
; (save unev)
; (assign (exp (op cond-predicate) (reg exp)))
; (assign (continue (label ev-cond-pred)))
; (goto (label eval-dispatch))
;
; ev-cond-pred
; (restore unev)
; (restore exp)
; (restore env)
; (restore continue)
; (test (op true?) (reg val))
; (branch (label ev-cond-evseq))
; (assign unev (op rest-clauses) (reg unev))
; (goto (label ev-cond-loop))
;
; ev-cond-evseq
; (assign unev (op cond-actions) (reg exp))
; (save continue)
; (goto (label ev-sequence))
