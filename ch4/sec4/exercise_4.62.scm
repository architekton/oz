(load "../query.scm")

(initialize-data-base microshaft-data-base)
(query-driver-loop)

(rule (last-pair (?x) (?x)))
(rule (last-pair (?x . ?y) (?z))
      (last-pair (?y (?z))))

(last-pair (3) ?x)
; (last-pair (3) (3))

(last-pair (1 2 3) ?x)
; (last-pair (1 2 3) (3))

(last-pair (2 ?x) (3))
; (last-pair (2 3) (3))

; (last-pair ?x (3))
; not possible infinite lists ending with 3, if it was around brackets then
; there is only (3)

