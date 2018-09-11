(load "streams.scm")

(define (integral delayed-integrand initial-value dt)
  (define int
    (cons-stream initial-value
                 (let ((integrand (force delayed-integrand)))
                   (add-streams (scale-stream integrand dt)
                                int))))
  int)

(define (RLC R L C dt)
  (define (int vc0 il0)
    (define vc (integral (delay dvc) vc0 dt))
    (define il (integral (delay dil) il0 dt))
    (define dvc (scale-stream il (/ -1 C)))
    (define dil (add-streams (scale-stream vc (/ 1 L))
                             (scale-stream il (/ (- 0 R) L))))
    (cons vc il))
  int)


(define proc (RLC 1 1 0.2 0.1))
(define g (proc 0 10))

(stream-ref (car g) 0)
(stream-ref (cdr g) 0)
