(load "common-final.scm")
(load "symbolic_algebra.scm")

; Install in generic package
; (put 'negate '(scheme-number) (lambda (x) (- 0 x)))
; (put 'negate '(rational) (lambda (x) (tag (make-rat (- 0 (numer x)) (denom x)))))
; (put 'negate '(comeplex)
;      (lambda (x) (tag (make-from-real-imag
;                         (- 0 (real-part x))
;                         (- 0 (imag-part x))))))

; (put 'sub '(polynomial polynomial)
;      (lambda (p1 p2) (tag (sub-poly p1 p2))))

; (define (negate x) (apply-generic 'negate x))

; Install in symbolic_algebra
; ; sub - add the negation of every term of the second polynomial to the first
; (define (sub-poly p1 p2)
;   (add-poly p1 (negate-poly p2)))
;
; (define (negate-poly p)
;   (make-poly (variable p) (negate-terms (term-list p))))
;
; (define (negate-terms termlist)
;   (if (empty-termlist? termlist)
;       (the-empty-termlist)
;       (adjoin-term (make-term
;                      (order (first-term termlist))
;                      (negate (coeff (first-term termlist))))
;                    (negate-terms (rest-terms termlist)))))

(define p1 (make-polynomial 'x (list (list 4 2) (list 2 10))))
(define p2 (make-polynomial 'x (list (list 4 1) (list 2 5))))

(sub p1 p2)
(sub p1 p1)
