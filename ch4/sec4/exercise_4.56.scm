(load "../query.scm")

(initialize-data-base microshaft-data-base)
(query-driver-loop)


; a)
(and (supervisor ?person (Ben Bitdiddle))
     (address ?person ?address))

; b)
(and (salary ?person ?amount)
     (salary (Ben Bitdiddle) ?bens)
     (list-value > ?amount < ?bens))

; c)
(and (supervisor ?person ?super)
     (not (job ?super (computer . ?rest)))
     (job ?super ?work))


