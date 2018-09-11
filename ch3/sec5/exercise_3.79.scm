(load "streams.scm")

(define (integral delayed-integrand initial-value dt)
  (define int
    (cons-stream initial-value
                 (let ((integrand (force delayed-integrand)))
                   (add-streams (scale-stream integrand dt)
                                int))))
  int)

(define (solve-2nd dt y0 dy0 f)
  (define y   (integral (delay dy) y0 dt))
  (define dy  (integral (delay ddy) dy0 dt))
  (define ddy (stream-map f dy y))
  y)

