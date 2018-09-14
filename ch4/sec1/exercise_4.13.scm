; unbinds it from the first frame, opposite to define-variable

(define (make-unbound! var env)
  (let ((frame (first-frame env)))
    (define (scan vars vals)
      (cond ((null? vars)
             'done)
            ((eq? var (car vars))
             (begin (set-car! vals (cdr vals))
                    (set-car! vars (cdr vars))))
            (else
              (scan (cdr vars) (cdr vals)))))

    (scan (frame-variables frame)
          (frame-values frame))))

