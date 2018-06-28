;;; The model of evaluation allows compound expressions; observe:

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

(a-plus-abs-b 10 5)
(a-plus-abs-b 10 -5)

;;; The sub-expression is evaluated first, allowing the choice of operator
;;; depending on the value of b, hence then name of the procedure.
