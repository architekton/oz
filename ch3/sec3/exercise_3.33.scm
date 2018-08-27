(load "constraint_system.scm")

(define (averager a b c)
  (let ((s (make-connector))
        (f (make-connector)))
    (constant (/ 1 2) f)
    (adder a b s)
    (multiplier s f c)
    'ok))

(define a (make-connector))
(define b (make-connector))
(define avg (make-connector))

(averager a b avg)

(probe "Average" avg)
(probe "v1" a)
(probe "v2" b)

(set-value! a 25 'user)
(set-value! b 35 'user)
