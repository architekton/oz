; lives-near is defined as:

; (rule (lives-near ?person-1 ?person-2)
;       (and (address ?person-1 (?town . ?rest-1))
;            (address ?person-2 (?town . ?rest-2))
;            (not (same ?person-1 ?person-2))))

; they are both satisfied since person-1 lives near person-2 and vise versa and
; they are both different people. We could filter out the duplicates by
; ordering such that the person-1 < person-2 or vise versa.

