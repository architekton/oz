 (define (scan nf f vars vals)
   (cond ((null? vars)
          (nf))
         ((eq? var (car vars))
          (f vals val))
         (else (scan nf f (cdr vars) (cdr vals)))))

(define (lookup-variable-value var env)
  (define (env-loop env)
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan
            (lambda () (env-loop (enclosing-environment env)))
            (lambda (vals val) (car vals))
            (frame-variables frame)
            (frame-values frame)))))

  (env-loop env))

(define (set-variable-value! var val env)
  (define (env-loop env)
    (if (eq? env the-empty-environment)
        (error "Unbound variable -- SET!" var)
        (let ((frame (first-frame env)))
          (scan
            (lambda () (env-loop (enclosing-environment env)))
            (lambda (vals val) (set-car! vals val))
            (frame-variables frame)
            (frame-values frame)))))

  (env-loop env))

(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (scan
      (lambda () (add-binding-to-frame! var val frame))
      (lambda (vals val) (set-car! vals val))
      (frame-variables frame)
      (frame-values frame))))
