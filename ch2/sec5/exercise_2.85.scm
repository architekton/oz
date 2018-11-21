(load "common.scm")
(load "exercise_2.84.scm")
(load "exercise_2.83.scm")

; complex -> rational
(put 'project 'complex
     (lambda (x)
       (let ((rational (inexact->exact (real-part x))))
         (make-rational (numerator rational)
                        (denominator rational)))))

; rational -> integer
(put 'project 'rational
     (lambda (x) (make-scheme-number (round (/ (numer x) (denom x))))))

(define (drop datum)
  (let* ((type (type-tag datum))
         (cont (contents datum))
         (proc (get 'project type)))
    (if proc
        (let ((projected (proc cont)))
          (if (equal? (raise projected) datum)
              (drop projected)
              datum))
        datum)))


(define c1 (make-complex-from-real-imag 2 0))
(drop c1)
; 2

(define c2 (make-complex-from-real-imag (/ 3 2) 0))
(drop c2)
; (rational 3 . 2)

(define c3 (make-complex-from-real-imag 1 1))
(drop c3)
; (complex rectangular 1 . 1)

(define (apply-generic op . args)
  (define should-drop?
    (not (or (equal? op 'raise) (equal? op 'project) (equal? op 'equ?))))
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (if should-drop?
              (drop (apply proc (map contents args)))
              (apply proc (map contents args)))
          (if (= (length args) 2)
              (let ((a1 (car args))
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


(add c1 c1)
; 4
