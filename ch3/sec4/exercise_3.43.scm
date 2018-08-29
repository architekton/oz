; TODO transfer diagram.

; Since the exchange can occur on a single account at a time, the money in each
; account remains the same.

; Here the total sum of our accounts remains correct because we still serialize
; our individual account operations, however accessing and exchanging
; simultaniously produces an errornous distribution ratio.

; After removing all serialization, there is nothing preventing the accessing
; of balance and the operations to be serialized on individual accounts hence,
; the total sum will also be wrong.
