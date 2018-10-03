(load "../query.scm")

(initialize-data-base microshaft-data-base)
(query-driver-loop)

(assert! (rule (append-to-form () ?y ?y)))
(assert! (rule (append-to-form (?u . ?v) ?y (?u . ?z))
               (append-to-form ?v ?y ?z)))

(assert! (rule (reverse () ())))
(assert! (rule (reverse (?f . ?r) ?x)
               ; z is the reverse of r
               (and (reverse ?r ?z)
                    ; z is then appended to the first, do these two operations
                    ; recursively to get the reverse of the whole list.
                    (append-to-form ?z (?f) ?x))))


(reverse (1 2 3) ?x)

; Infinite loop, if we change the order it works. ?x is not bound,
; the recursive call won't work in its current order.
(reverse ?x (1 2 3))


