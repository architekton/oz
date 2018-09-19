; a)
; In this case the contents of the lambda function contain primitive
; procedures, whose arguments are forced and evaluated, so in this case ben is
; right.

; b)
; The value is used hence has to be prepended.
; (1 2)
; The procedure(thunk) passed as argument e is never evaluated, only 1 is
; returned.
; 1

; c)
; For the same reason as a, a primitive procedure forces the thunk.

; d)
; One is pure lazy (original) and Cy's isn't, either or personal preference
