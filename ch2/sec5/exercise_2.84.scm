(load "common.scm")

(define (raise-to-type type1 type2)
  (if (equal? type1 type2)
      type1
      (let ((raised-type1) (raise type1))
        (if raised-type1
            (raise-to-type raised-type1 type2)
            #f))))

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
                  (cond ((raise-to-type type1 type2)
                          (apply-generic op (raise-to-type a1 a2) a2))
                        ((raise-to-type type2 type1)
                          (apply-generic op a1 (raise-to-type a2 a1))
                        (else
                          (error "No method for these types"
                                 (list op type-tags))))))
              (error "No method for these types"
                     (list op type-tags)))))))


