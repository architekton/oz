; The previous implementation defined a serialiser and gave the caller the
; responsibility to assure deadlock-free and race-free code.

; Louis's version mixes the same serialiser with the account's internal
; functions (deposit, withdraw) and exposes it to serialized-exchange.
; Serialized exchange then locks the serializer and calls exchange.
; Exchange then tries to deposit or withdraw, hence the program never halts.
