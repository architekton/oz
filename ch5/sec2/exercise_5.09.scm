(load "../regsim.scm")

; make-operation-exp calls make-primitive-exp and we can remove the label
; lookup and let it throw an unknown expression type for labels.

(define (make-primitive-exp exp machine labels)
  (cond ((constant-exp? exp)
         (let ((c (constant-exp-value exp)))
           (lambda () c)))
        ((register-exp? exp)
         (let ((r (get-register machine
                                (register-exp-reg exp))))
           (lambda () (get-contents r))))
        (else
          (error "Unknown expression type -- ASSEMBLE" exp))))


