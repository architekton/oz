(load "common.scm")

(define (apply-generic op . args)
  (define (apply-coerced args)
    (if (null? args)
        (error "No method for these types")
        (let ((coerced-list
                ; returns the list of coerced types of the args list to the
                ; first type (car args)
                (map (lambda (x)
                       (let ((proc (get-coercion
                                     (type-tag x)
                                     (type-tag (car args)))))
                         (if proc (proc x) x)))
                     args)))

          (let ((proc (get op (map type-tag coerced-list))))
            (if (proc)
                (apply proc (map contents coerced-list))
                (apply-coerced (cdr args)))))))

  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (apply-coerced args)))))


; Simple test
(define (scheme-number->scheme-number n) n)
(define (complex->complex z) z)

(put-coercion 'scheme-number 'scheme-number
              scheme-number->scheme-number)
(put-coercion 'complex 'complex complex->complex)

(put 'exp '(scheme-number scheme-number)
     (lambda (x y) (attach-tag 'scheme-number (expt x y))))

(define (exp x y) (apply-generic 'exp x y))
(exp 10 2)
(exp (make-scheme-number 10) (make-scheme-number 2))

(exp (make-complex-from-real-imag 10 0) (make-complex-from-real-imag 2 0))



