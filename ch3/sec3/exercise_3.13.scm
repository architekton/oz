(define (append x y)
  (if (null? x)
      y
      (cons (car x) (append (cdr x) y))))

(define (append! x y)
  (set-cdr! (last-pair x) y)
  x)

(define (last-pair x)
  (if (null? (cdr x)) x (last-pair (cdr x))))

(define x (list 'a 'b))
(define y (list 'c 'd))
(define z (append x y))

(cdr x)
; (b)
; Here we do not mutate the original pairs rather we create. cons builds the
; new list structure by creating new pairs

(define w (append! x y))
(cdr x)
; (b c d)
; The contrary occurs here where set-cdr! performs a mutation on the existing
; pairs splicing the two lists together.
