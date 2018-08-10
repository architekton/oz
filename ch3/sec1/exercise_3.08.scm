(define f
  (let ((called #f))
    (lambda (arg)
      (if called
          0
          (begin (set! called #t) arg)))))

(define g
  (let ((called #f))
    (lambda (arg)
      (if called
          0
          (begin (set! called #t) arg)))))

(+ (f 0) (f 1))
(+ (g 1) (g 0))

