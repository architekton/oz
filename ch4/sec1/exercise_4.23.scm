; Alyssa's program will loop around all the procedures in the begin statement
; and execute them in the given environment.

; The procedure in the book unrolls the above so it does not loop on every
; call. It performs analysis once and returns the unrolled version of the
; above as nested lambdas.

; Alyssa's program is therefore slower since it performs analysis more than
; needed.
