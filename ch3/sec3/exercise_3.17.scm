(define (count-pairs x)
  (let ((seen '()))
    (define (is-seen? x)
      (if (memq x seen)
          #t
          (begin (set! seen (cons x seen)) #f)))

    (define (count x)
      (if (and (pair? x) (not (is-seen? x)))
          (+ (count (car x)) (count (cdr x)) 1)
          0))
    (count x)))


(define three (list 'a 'b 'c))
three
(count-pairs three)

(define a (cons 'a 'b)) ; 1
(define b (cons 'c 'd)) ; 1
(set-car! a b)
a ; now 2
(define four (cons a b)) ; 4
four
(count-pairs four)

(define a (list 'a))
(define b (cons a a))
(define seven (cons b b))
seven
(count-pairs seven)

; Now correctly outputs 3 in all cases
