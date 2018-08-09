(define (make-account balance password)
  (let ((attempts 0))
    (define (call-the-cops)
      "Calling the cops")
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
          (begin (set! attempts 0)
                 (cond ((eq? m 'withdraw) withdraw)
                       ((eq? m 'deposit) deposit)
                       (else (error "Unknown request -- MAKE-ACCOUNT"
                                    m))))
          (lambda (amount)
            (if (> attempts 6)
                (call-the-cops)
                (begin (set! attempts (+ 1 attempts)) attempts)))))

    dispatch))

(define acc (make-account 100 'secret-password))

((acc 'secret-password 'withdraw) 40)
((acc 'some-other-password 'withdraw) 50)
((acc 'some-other-password 'withdraw) 50)
((acc 'some-other-password 'withdraw) 50)
((acc 'some-other-password 'withdraw) 50)
((acc 'some-other-password 'withdraw) 50)
((acc 'some-other-password 'withdraw) 50)
((acc 'some-other-password 'withdraw) 50)
((acc 'some-other-password 'withdraw) 50)
