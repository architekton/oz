; Assuming the primitive procedures are defined in syntax.scm (as the exercise
; permits)

; Add to operations

(list 'cond? cond?)
(list 'cond->if cond-if)
(list 'let? let?)
(list 'let->combination let->combination)

; Add to eceval machine dispatch

(test (op cond?) (reg exp))
(branch (label ev-cond))
(test (op let?) (reg exp))
(branch (label ev-let))

; Add to eceval
ev-cond
(assign exp (op cond->if) (reg exp))
(branch (label ev-if))
ev-let
(assign exp (op let->combination) (reg exp))
(branch (label ev-application))

