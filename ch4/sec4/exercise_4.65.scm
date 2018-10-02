; (rule (wheel ?person)
;       (and (supervisor ?middle-manager ?person)
;            (supervisor ?x ?middle-manager)))

; Irrelevant
; (supervisor (Reasoner Louis) (Hacker Alyssa P))

; First layer
; (supervisor (Bitdiddle Ben) (Warbucks Oliver))
; (supervisor (Scrooge Eben) (Warbucks Oliver))
; (supervisor (Aull DeWitt) (Warbucks Oliver))

; Second layer
; (supervisor (Cratchet Robert) (Scrooge Eben))
; (supervisor (Hacker Alyssa P) (Bitdiddle Ben))
; (supervisor (Fect Cy D) (Bitdiddle Ben))
; (supervisor (Tweakit Lem E) (Bitdiddle Ben))

; Oliver Warbucks indirectly supervises 4 people as shown in the second layer
