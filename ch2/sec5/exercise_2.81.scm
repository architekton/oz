(load "common.scm")

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags))
                    (a1 (car args))
                    (a2 (cadr args)))
                (let ((t1->t2 (get-coercion type1 type2))
                      (t2->t1 (get-coercion type2 type1)))
                  (cond (t1->t2
                          (apply-generic op (t1->t2 a1) a2))
                        (t2->t1
                          (apply-generic op a1 (t2->t1 a2)))
                        (else
                          (error "No method for these types"
                                 (list op type-tags))))))
              (error "No method for these types"
                     (list op type-tags)))))))


(define (scheme-number->complex n)
  (make-complex-from-real-imag (contents n) 0))

;(define (scheme-number->scheme-number n) n)
;(define (complex->complex z) z)
;
;(put-coercion 'scheme-number 'scheme-number
;              scheme-number->scheme-number)
;(put-coercion 'complex 'complex complex->complex)

(put 'exp '(scheme-number scheme-number)
     (lambda (x y) (attach-tag 'scheme-number (expt x y))))

(define (exp x y) (apply-generic 'exp x y))

(exp 10 2)
(exp (make-scheme-number 10) (make-scheme-number 2))

(exp (make-complex-from-real-imag 10 0) (make-complex-from-real-imag 2 0))

; a)
; with louis coercion procedures the operation with scheme numbers works
; because we have an exp operation in the table

; with 2 complex numbers it does not and it results in infinite recursion
; instead of not finding the operation because resolving complex to complex
; means instead of transforming the type it will resolve to itself and search
; the same table again and again.

; b)
; It works correctly as it is, providing us with an error.

; c)
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags))
                    (a1 (car args))
                    (a2 (cadr args)))
                ; check before coercing
                (if (equal? type1 type2)
                    (error "No method for these types"
                           (list op type-tags))
                    (let ((t1->t2 (get-coercion type1 type2))
                          (t2->t1 (get-coercion type2 type1)))
                      (cond (t1->t2
                              (apply-generic op (t1->t2 a1) a2))
                            (t2->t1
                              (apply-generic op a1 (t2->t1 a2)))
                            (else
                              (error "No method for these types"
                                     (list op type-tags)))))))
              (error "No method for these types"
                     (list op type-tags)))))))


; Simple test
(define (scheme-number->scheme-number n) n)
(define (complex->complex z) z)

(put-coercion 'scheme-number 'scheme-number
              scheme-number->scheme-number)
(put-coercion 'complex 'complex complex->complex)

(exp 10 2)
(exp (make-scheme-number 10) (make-scheme-number 2))

(exp (make-complex-from-real-imag 10 0) (make-complex-from-real-imag 2 0))

