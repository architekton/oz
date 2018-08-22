; if then else
(define true
  (lambda (x y) x))

(define false
  (lambda (x y) y))

(define if-then-else
  (lambda (f x y) (f x y)))

(if-then-else true #t #f)

(if-then-else true #t #f)

