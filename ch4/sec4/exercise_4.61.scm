(load "../query.scm")

(initialize-data-base microshaft-data-base)
(query-driver-loop)

(rule (?x next-to ?y in (?x ?y . ?u)))
(rule (?x next-to ?y in (?v . ?z))
     (?x next-to ?y in ?z))

; a)
(?x next-to ?y in '(1 (2 3) 4))
; (1 next-to (2 3) in ...)
; ((2 3) next-to 4 in ...)

(?x next-to 1 in '(2 1 3 1))
; (3 next-to 1 in ...)
; (2 next-to 1 in ...)

