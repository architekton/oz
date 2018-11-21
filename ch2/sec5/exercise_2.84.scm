(load "common.scm")
(load "exercise_2.83.scm")

(define highest-type 'complex)

(define (raise-to-type datum-from datum-to)
  (let* ((type1 (type-tag datum-from))
         (type2 (type-tag datum-to)))
    (if (equal? type1 type2)
        datum-from
        (if (not (eq? type1 highest-type))
            (let ((raised (raise datum-from)))
              (if raised
                  (raise-to-type raised datum-to)
                  #f))
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
                (cond ((raise-to-type a1 a2)
                       (apply-generic op (raise-to-type a1 a2) a2))
                      ((raise-to-type a2 a1)
                       (apply-generic op a1 (raise-to-type a2 a1)))
                      (else
                        (error "No method for these types"
                               (list op type-tags)))))
              (error "No method for these types"
                     (list op type-tags)))))))


(define d1 (make-rational 4 1))
(define d2 (make-scheme-number 2))
(raise-to-type d1 d2)
(raise-to-type d2 d1)

(add d1 d2)
