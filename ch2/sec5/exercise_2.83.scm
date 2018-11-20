(load "common.scm")

(define numer car)
(define denom cdr)

(put 'raise '(scheme-number)
     (lambda (x) (make-rational x 1)))

(put 'raise '(rational)
     (lambda (x) (make-complex-from-real-imag (/ (numer x) (denom x)) 0)))

(define (raise x) (apply-generic 'raise x))

(define n1 (make-scheme-number 1))
(raise n1)
(raise (raise n1))
