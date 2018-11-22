(load "common-final.scm")
(load "symbolic_algebra.scm")

; put the following in the package (it is already included above)
; zero?
; (define (zero-terms? termlist)
;   (if (empty-termlist? termlist)
;       '#t
;       (and (=zero? (coeff (first-term termlist)))
;            (zero-terms? (rest-terms termlist)))))
;
;
; (put '=zero? '(polynomial) (lambda (x) (zero-terms? (term-list x))))

(define p1 (make-polynomial 'x (list (list 3 0) (list 1 0) (list 0 0))))
(=zero? p1)

(define p1 (make-polynomial 'x (list (list 3 1) (list 1 1) (list 0 0))))
(=zero? p1)
