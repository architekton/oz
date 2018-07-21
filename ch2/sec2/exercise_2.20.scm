(define (same-parity x . rest)
  (define (iter matches-parity? lst result)
    (if (null? lst)
        (reverse result)
        (iter matches-parity? (cdr lst)
              (if (matches-parity? (car lst))
                  (cons (car lst) result)
                  result))))

  (iter (if (even? x) even? odd?) rest (list x)))

(same-parity 1 2 3 4 5 6 7)
(same-parity 2 3 4 5 6 7)

