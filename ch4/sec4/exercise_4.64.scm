; (rule (outranked-by ?staff-person ?boss)
;       (or (supervisor ?staff-person ?boss)
;           (and (outranked-by ?middle-manager ?boss)
;                (supervisor ?staff-person
;                            ?middle-manager))))

; The above version is the version that the rule goes into an infinite loop,
; the original version hand its and arguments reversed. Here we try to evaluate
; the recursive case first without having generated our ?middle-manager
; bindings. This continues in an infinite loop
