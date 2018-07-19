(define (double f)
  (lambda (x) (f (f x))))

(define (inc n) (+ 1 n))


(((double (double double)) inc) 5)

; The nested (double double) gives a procedure that will apply 2*2 times
; The outer double with the new procedure returns a procedure that will apply
; (2*2) * (2*2) times, hence inc will increase n by 16 every time. So 21

