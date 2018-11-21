(load "common.scm")
(load "exercise_2.83.scm")
(load "exercise_2.84.scm")
(load "exercise_2.85.scm")

(define numer car)
(define denom cdr)

(define (rat-helper x)
  (let ((rat (inexact->exact x)))
    (make-rational (numerator rat)
                   (denominator rat))))

; insert in scheme-number package
(put 'sine '(scheme-number) (lambda (x) (attach-tag 'scheme-number (sin x))))
(put 'cosine '(scheme-number) (lambda (x) (attach-tag 'scheme-number (cos x))))
(put 'arctan '(scheme-number scheme-number) (lambda (x y) (attach-tag 'scheme-number (atan x y))))
(put 'sqroot '(scheme-number) (lambda (x) (attach-tag 'scheme-number (sqrt x))))
(put 'sq '(scheme-number) (lambda (x) (attach-tag 'scheme-number (square x))))

; insert in rational package
(put 'sine '(rational) (lambda (x) (rat-helper (sin (/ (numer x) (denom x))))))
(put 'cosine '(rational) (lambda (x) (rat-helper (cos (/ (numer  x) (denom x))))))
(put 'arctan '(rational rational) (lambda (x y) (rat-helper (atan (/ (numer x) (denom x))
                                                      (/ (numer y) (denom y))))))
(put 'sqroot '(rational) (lambda (x) (rat-helper (sqrt (/ (numer x) (denom x))))))
(put 'sq '(rational) (lambda (x) (rat-helper (square (/ (numer x) (denom x))))))

(define (sine x) (apply-generic 'sine x))
(define (cosine x) (apply-generic 'cosine x))
(define (arctan x y) (apply-generic 'arctan x y))
(define (sqroot x) (apply-generic 'sqroot x))
(define (sq x) (apply-generic 'sq x))

(define (install-rectangular-package)
  ; internal procedures
  (define (real-part z) (car z))
  (define (imag-part z) (cdr z))
  (define (make-from-real-imag x y) (cons x y))
  (define (magnitude z)
    (sqroot (add (sq (real-part z))
                 (sq (imag-part z)))))
  (define (angle z)
    (arctan (imag-part z) (real-part z)))
  (define (make-from-mag-ang r a)
    (cons (mul r (cosine a)) (mul r (sine a))))

  ; interface to the rest of the system
  (define (tag x) (attach-tag 'rectangular x))
  (put 'real-part '(rectangular) real-part)
  (put 'imag-part '(rectangular) imag-part)
  (put 'magnitude '(rectangular) magnitude)
  (put 'angle '(rectangular) angle)
  (put 'make-from-real-imag 'rectangular
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'rectangular
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)

;------

(define (install-polar-package)
  ; internal procedures
  (define (magnitude z) (car z))
  (define (angle z) (cdr z))
  (define (make-from-mag-ang r a) (cons r a))
  (define (real-part z)
    (mul (magnitude z) (cosine (angle z))))
  (define (imag-part z)
    (mul (magnitude z) (sine (angle z))))
  (define (make-from-real-imag x y)
    (cons (sqroot (add (sq x) (sq y)))
          (arctan y x)))

  ; interface to the rest of the system
  (define (tag x) (attach-tag 'polar x))
  (put 'real-part '(polar) real-part)
  (put 'imag-part '(polar) imag-part)
  (put 'magnitude '(polar) magnitude)
  (put 'angle '(polar) angle)
  (put 'make-from-real-imag 'polar
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'polar
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)
(define (install-complex-package)
  ; imported procedures from rectangular and polar packages
  (define (make-from-real-imag x y)
    ((get 'make-from-real-imag 'rectangular) x y))
  (define (make-from-mag-ang r a) ((get 'make-from-mag-ang 'polar) r a))
  ; internal procedures
  (define (add-complex z1 z2)
    (make-from-real-imag (add (real-part z1) (real-part z2))
                         (add (imag-part z1) (imag-part z2))))
  (define (sub-complex z1 z2)
    (make-from-real-imag (sub (real-part z1) (real-part z2))
                         (sub (imag-part z1) (imag-part z2))))
  (define (mul-complex z1 z2)
    (make-from-mag-ang (mul (magnitude z1) (magnitude z2))
                       (mul (angle z1) (angle z2))))
  (define (div-complex z1 z2)
    (make-from-mag-ang (div (magnitude z1) (magnitude z2))
                       (sub (angle z1) (angle z2))))

  ; interface to rest of the system
  (define (tag z) (attach-tag 'complex z))
  (put 'add '(complex complex)
       (lambda (z1 z2) (tag (add-complex z1 z2))))
  (put 'sub '(complex complex)
       (lambda (z1 z2) (tag (sub-complex z1 z2))))
  (put 'mul '(complex complex)
       (lambda (z1 z2) (tag (mul-complex z1 z2))))
  (put 'div '(complex complex)
       (lambda (z1 z2) (tag (div-complex z1 z2))))
  (put 'make-from-real-imag 'complex
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'complex
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)

(install-polar-package)
(install-rectangular-package)
(install-complex-package)

(define c1 (make-complex-from-real-imag (make-rational 3 1) (make-scheme-number 2)))
(define c2 (make-complex-from-real-imag (make-scheme-number 3) (make-scheme-number 0)))
(add c1 c2)
(sub c1 c2)
(mul c1 c2)
(div c1 c2)
