; a)
(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars))
             (if (eq? (car vals) '*unassigned*)
                 (error "Variable has no value" var)
                 (car vals)))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))

; b)

; Transformation from the book

; (lambda <vars>
;   (define u <e1>)
;   (define v <e2>)
;   <e3>)

; (lambda <vars>
;   (let ((u '*unassigned*)
;         (v '*unassigned*))
;     (set! u <e1>)
;     (set! v <e2>)
;     <e3>))

(define (scan-out-defines body)
  (define (make-set var val)
    (list 'set! var val))

  (define (make-binding var)
    (list var '*unassigned*))

  (define (define? exps)
    (eq? (car exps) 'define))

  (let ((definitions (filter define? body)))
    (append (list 'let
                  (map make-binding
                       (map cadr definitions)))
            (map make-set
                 (map cadr definitions)
                 (map caddr definitions))
            (filter (lambda (exps) (not (define? exps))) body)))))

(define test '(lambda (var)
                (define u 1)
                (define v (list 1 2 3))
                (append u v)))

(scan-out-defines (cddr test))
