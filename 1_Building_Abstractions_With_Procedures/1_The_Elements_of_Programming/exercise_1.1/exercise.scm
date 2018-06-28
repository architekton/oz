;: 10
;: Answer: 10

;: (+ 5 3 4)
;: Answer: 12

;: (- 9 1)
;: Answer: 8

;: (/ 6 2)
;: Answer: 3

;: (+ (* 2 4) (- 4 6))
;: Answer: 6

;: (define a 3)
;: (define b (+ a 1))

;: (+ a b (* a b))
;: Answer: 19

;: (= a b)
;: Answer #f (false)

;: (if (and (> b a) (< b (* a b)))
;:     b
;:     a)
;: Answer: 4

;: (cond ((= a 4) 6)
;:       ((= b 4) (+ 6 7 a))
;:       (else 25))
;: Answer: 16

;: (+ 2 (if (> b a) b a))
;: Answer: 6

;: (* (cond ((> a b) a)
;: 	 ((< a b) b)
;: 	 (else -1))
;:    (+ a 1))
;: Answer: 16

;: The above were evaluated without the interpreter and then checked for
;: mistakes.

