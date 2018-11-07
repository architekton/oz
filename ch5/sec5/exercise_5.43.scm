(load "../syntax.scm")
(load "../compiler.scm")

(define (compile-lambda-body exp proc-entry ctenv)
  (let ((formals (lambda-parameters exp)))
    (append-instruction-sequences
      (make-instruction-sequence '(env proc argl) '(env)
                                 `(,proc-entry
                                    (assign env (op compiled-procedure-env) (reg proc))
                                    (assign env
                                            (op extend-environment)
                                            (const ,formals)
                                            (reg argl)
                                            (reg env))))
      (compile-sequence (scan-out-defines (lambda-body exp)) 'val 'return
                        (extend-ctenv formals ctenv)))))

; 4.16 code
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


