(define (integral integrand initial-value dt)
  (cons-stream initial-value
               (if (stream-null? (force integrand))
                   the-empty-stream
                   (integral (delay (stream-cdr (force integrand)))
                             (+ (* dt (stream-car (force integrand)))
                                initial-value)
                             dt))))


