; a) if we replace an-integer-between by an-integer-starting-from we will get
; a pause as the evaluator will be enumerating one of the numbers to
; infinity and the other two will be stuck at 1. We would need to have a
; variable taking any number and the other two to have a finite number of
; possibilities using an-integer-between based off that variable.

(load "../mceval.scm")
(load "../ambeval.scm")

(define the-global-environment (setup-environment))
(driver-loop)

(define (require p)
  (if (not p) (amb)))

(define (an-element-of items)
  (require (not (null? items)))
  (amb (car items) (an-element-of (cdr items))))

(define (an-integer-starting-from n)
  (amb n (an-integer-starting-from (+ n 1))))

(define (an-integer-between a b)
  (require (<= a b))
  (amb a (an-integer-between (+ a 1) b)))

(define (a-pythagorean-triple low)
  (let ((hypot (an-integer-starting-from low)))
    (let ((i (an-integer-between low hypot)))
      (let ((j (an-integer-between low hypot)))
        (require (= (+ (* i i) (* j j)) (* hypot hypot)))
        (list i j hypot)))))

(a-pythagorean-triple 1)

try-again
