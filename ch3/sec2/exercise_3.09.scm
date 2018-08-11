(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))

; global env with factorial pointing to the body and variables

; E1: n: 6; (* 6 (factorial (5))) pointing to global
; E2: n: 5; (* 5 (factorial (4))) pointing to global
; E3: n: 4; (* 4 (factorial (3))) pointing to global
; E4: n: 3; (* 3 (factorial (2))) pointing to global
; E5: n: 2; (* 6 (factorial (1))) pointing to global
; E6: n: 1; 1 pointing to global

(define (factorial n)
  (fact-iter 1 1 n))

(define (fact-iter product counter max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))

; global env with references to both functions

; E1: n: 6; (fact-iter 1 1 n) pointing to global
; E2: max-count: 6
;     counter:   1
;     product:   1
;     (fact iter 1 2 6)
; E3: max-count: 6
;     counter:   2
;     product:   1
;     (fact iter 2 3 6)
; E4: max-count: 6
;     counter:   3
;     product:   2
;     (fact iter 6 4 6)
; E5: max-count: 6
;     counter:   4
;     product:   6
;     (fact iter 24 5 6)
; E6: max-count: 6
;     counter:   5
;     product:   24
;     (fact iter 120 7 6)
; E7: max-count: 6
;     counter:   6
;     product:   120
;     (fact-iter 720 7 6)
; E8: max-count: 6
;     counter:   7
;     product:   720
;     720

; All pointing to global
