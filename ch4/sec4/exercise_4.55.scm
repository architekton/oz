(load "../query.scm")

(initialize-data-base microshaft-data-base)
(query-driver-loop)


; a)
(supervisor ?x (Ben Bitdiddle))

; b)
(job ?x (accounting . ?rest))

; c)
(address ?x (Slummerville . ?rest))


