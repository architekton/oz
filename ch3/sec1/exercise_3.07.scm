(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch pass m)
    (if (equal? password pass)
        (cond ((eq? m 'withdraw) withdraw)
              ((eq? m 'deposit) deposit)
              (else (error "Unknown request -- MAKE-ACCOUNT"
                           m)))
        (lambda (amount) "Incorrect password")))

  dispatch)

; exercise 3.07
(define (make-joint acc old-pass new-pass)
  (define (dispatch pass m)
    (if (eq? pass new-pass)
        (acc old-pass m)
        "Invalid password"))
  dispatch)


(define peter-acc (make-account 100 'pass1234))
((peter-acc 'pass1234 'withdraw) 10)

(define paul-acc (make-joint peter-acc 'pass1234 'pass4321))
((paul-acc 'pass4321 'withdraw) 20)


