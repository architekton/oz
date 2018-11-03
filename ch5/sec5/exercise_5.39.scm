(define (lexical-address frame offset) (cons frame offset))
(define (lexical-address-frame lexical-address) (car lexical-address))
(define (lexical-address-offset lexical-address) (cdr lexical-address))

(define (lexical-address-lookup lexical-address run-time-environment)
  (let ((value (cdr
                 (list-ref
                   (list-ref run-time-environment
                             (lexical-address-frame lexical-address))
                   (lexical-address-offset lexical-address)))))
    (if (eq? value '*unassigned*)
        (error "Unassigned variable! -- LEXICAL-ADDRESS-LOOKUP" lexical-address)
        value)))

(define (lexical-address-set! lexical-address run-time-environment value)
  (let ((pair ((list-ref
                   (list-ref run-time-environment
                             (lexical-address-frame lexical-address))
                   (lexical-address-offset lexical-address)))))
    (set-cdr! pair value)))


