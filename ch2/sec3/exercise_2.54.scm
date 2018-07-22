(define (equal? l1 l2)
  (if (and (pair? l1) (pair? l2))
      (and (equal? (car l1) (car l2))
           (equal? (cdr l1) (cdr l2)))
      (eq? l1 l2)))


(equal? '(this is a list) '(this is a list))
(equal? '(a (b (c (d e f)))) '(a (b (c (d e f)))))
(equal? '(this is a list) '(this (is a) list))
