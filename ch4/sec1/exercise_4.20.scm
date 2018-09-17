; a)
(define (letrec->combination body)
  (define (make-set var val)
    (list 'set! var val))

  (define (make-binding var)
    (list var '*unassigned*))

  (append (list 'let
                (map make-binding
                     (map car (car body))))

          (map make-set
               (map car (car body))
               (map cadr (car body)))

          (cdr body))))

(define test '(letrec
                ((fact (lambda (n)
                         (if (= n 1) 1 (* n (fact (-n 1)))))))
                (fact 10)))

(define (make-set var val)
  (list 'set! var val))

(letrec->combination (cdr test))

; b)
; The bindings in a let expressions which are actually converted to lambda
; expressions, cannot refer to themselves, without first being set!.
