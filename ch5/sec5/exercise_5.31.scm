; 1. Saves and restores env around the evaluation of the operator.
; 2. Saves and restores env around the evaluation of each operand (except the last one).
; 3. Saves and restores argl around the evaluation of each operand.
; 4. Saves and restores proc around the evaluation of the operand sequence.


; (f 'x 'y)
; In this case all of the above save and restores are superflous, since
; openards are quoted and f requires only a lookup.

; ((f) 'x 'y)
; Case 1 is needed because the evaluation of (f) might change env. The rest are
; not for the same reason as above.

; (f (g 'x) y)
; Case 1 is superflous.
; Case 2 is needed for the first argument. (Only one possible)
; Case 3 is needed for the first argument.
; Case 4 is needed for the first argument.
; Case 3 is superflous for the last argument.
; Case 4 is needed for the last argument.

; (f (g 'x) 'y)
; Case 1 is superflous.
; Case 2 is superflous. (Only one possible)
; Case 3 is needed for the first argument.
; Case 4 is needed for the first argument.
; Case 3 is superflous for the last argument.
; Case 4 is needed for the last argument.



