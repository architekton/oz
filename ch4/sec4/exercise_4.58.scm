; (rule (big-shot ?person ?division)
;       (and (job ?person (?division . ?rest))
;            (supervisor ?person ?boss)
;            (job ?boss (?div . ?other))
;            (not (same ?div ?division))))
