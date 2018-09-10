(load "streams.scm")

(define (integral integrand initial-value dt)
  (define int
    (cons-stream initial-value
                 (add-streams (scale-stream integrand dt)
                              int)))
  int)

(define (RC R C dt)
  (define (int s v0)
    (add-streams (scale-stream s R)
                 (integral (scale-stream s (/ 1 c)) v0 dt)))
  int)

(define sproc (RC 5 1 0.5))

(define s (sproc ones 0))

(display-stream s)
