; We can eliminate all the options shown in the table using nested let
; statements and we also don't have to use distinct

; |   | B | C | F | M | S |
; |---|---|---|---|---|---|
; | 1 |   | - | - | - |   |
; | 2 |   |   |   | - |   |
; | 3 |   |   |   |   |   |
; | 4 |   |   |   |   |   |
; | 5 | - |   | - |   |   |

; The bars indicate elimintated possibilities, the other constraint is that we
; have unique floors, and the rest is left to the program.

(load "../mceval.scm")
(load "../ambeval.scm")

(define the-global-environment (setup-environment))
(driver-loop)

(define (require p)
  (if (not p) (amb)))

(define (multiple-dwelling)
  (let ((baker (amb 1 2 3 4 5)))
    (require (not (= baker 5)))
    (let ((cooper (amb 1 2 3 4 5)))
      (require (not (= cooper 1)))
      (require (not (= cooper baker)))
      (let ((fletcher (amb 1 2 3 4 5)))
        (require (not (= fletcher 5)))
        (require (not (= fletcher 1)))
        (require (not (= fletcher baker)))
        (require (not (= fletcher cooper)))
        (require (not (= 1 (abs (- fletcher cooper)))))
        (let ((miller (amb 1 2 3 4 5)))
          (require (> miller cooper))
          (require (not (= miller baker)))
          (require (not (= miller cooper)))
          (require (not (= miller fletcher)))
          (let ((smith (amb 1 2 3 4 5)))
            (require (not (= smith baker)))
            (require (not (= smith cooper)))
            (require (not (= smith fletcher)))
            (require (not (= smith miller)))
            (require (not (= 1 (abs (- smith fletcher)))))
            (list (list 'baker baker)
                  (list 'cooper cooper)
                  (list 'fletcher fletcher)
                  (list 'miller miller)
                  (list 'smith smith))))))))

(multiple-dwelling)
