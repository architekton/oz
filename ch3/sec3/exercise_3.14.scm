(define (mystery x)
  (define (loop x y)
    (if (null? x)
        y
        (let ((temp (cdr x)))
          (set-cdr! x y)
          (loop temp x))))
  (loop x '()))

(define v (list 'a 'b 'c 'd))
(define w (mystery v))

w
v

; The mystery procedure reverses a list in place. a originally points to be
; which originally ppoints to c and so on. Because set-cdr! performs a mutation
; when the first iteration happens we have b pointing to c pointing to d
; pointing to a. However a points to nothing as it is the end of the list.
; Therefore v is modified and becomes just (a), and w is now d pointing to c
; pointing to b which points to a; the list is reversed.
