(load "common-final.scm")
(load "symbolic_algebra.scm")

(define (adjoin-term term term-list)
  (let* ((ord (order term))
        (coe (coeff term)))
    (define (iter left terms)
      (cond ((null? terms)
             (list coe))
            ((= left 0)
             (cons coe terms))
            (else
              (iter (- left 1) terms))))
    (iter ord term-list)))

(define (the-empty-termlist) '())
(define (first-term term-list) (car term-list))
(define (rest-terms term-list) (cdr term-list))
(define (empty-termlist? term-list) (null? term-list))

(define (make-term order coeff) (list order coeff))
(define (order term) (car term))
(define (coeff term) (cadr term))

; Book example test
(define t (adjoin-term (make-term 5 1) (the-empty-termlist)))
(define t (adjoin-term (make-term 4 2) t))
(define t (adjoin-term (make-term 3 0) t))
(define t (adjoin-term (make-term 2 3) t))
(define t (adjoin-term (make-term 1 -2) t))
(define t (adjoin-term (make-term 0 -5) t))
t
