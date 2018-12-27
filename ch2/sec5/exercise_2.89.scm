(load "common-final.scm")
(load "symbolic_algebra.scm")

(define (adjoin-term term term-list)
      (cond ((= (coeff term) 0)
             term-list)
            ((= (order term) (length term-list))
             (cons (coeff term) term-list))
            (else
              (adjoin-term term (cons 0 term-list)))))

(define (the-empty-termlist) '())
(define (first-term term-list) (make-term (- (length term-list) 1 ) (car term-list)))
(define (rest-terms term-list) (cdr term-list))
(define (empty-termlist? term-list) (null? term-list))

(define (make-term order coeff) (list order coeff))
(define (order term) (car term))
(define (coeff term) (cadr term))

; Book example test
(define t (adjoin-term (make-term 0 -5) (the-empty-termlist)))
(define t (adjoin-term (make-term 1 -2) t))
(define t (adjoin-term (make-term 2 3) t))
(define t (adjoin-term (make-term 4 2) t))
(define t (adjoin-term (make-term 5 1) t))
t
