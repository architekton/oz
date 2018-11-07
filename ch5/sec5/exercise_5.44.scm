; changed
(define (open-code? exp ctenv)
  (or (and (tagged-list? exp '*) (eq? 'not-found (find-variable '* ctenv)))
      (and (tagged-list? exp '+) (eq? 'not-found (find-variable '+ ctenv)))
      (and (tagged-list? exp '-) (eq? 'not-found (find-variable '- ctenv)))
      (and (tagged-list? exp '=) (eq? 'not-found (find-variable '= ctenv)))))

(define (compile exp target linkage ctenv) ;changed
  (cond ((self-evaluating? exp)
         (compile-self-evaluating exp target linkage))
        ((quoted? exp)
         (compile-quoted exp target linkage))
        ((open-code? exp ctenv) ;changed
         (compile-op exp target linkage))
        ((variable? exp)
         (compile-variable exp target linkage))
        ((assignment? exp)
         (compile-assignment exp target linkage))
        ((definition? exp)
         (compile-definition exp target linkage))
        ((if? exp) (compile-if exp target linkage))
        ((lambda? exp) (compile-lambda exp target linkage))
        ((begin? exp)
         (compile-sequence (begin-actions exp)
                           target
                           linkage))
        ((cond? exp) (compile (cond->if exp) target linkage))
        ((application? exp)
         (compile-application exp target linkage))
        (else
          (error "Unknown expression type -- COMPILE" exp))))

; If the operators exist in the environment don't use open-code

