(define (make-let bindings body)
  (list 'let (list bindings) body))

(define (let*->nested-lets exps)
  (define (iter bindings body)
    (let ((first (car exps))
          (rest (cdr exps)))
      (if (null? rest)
          (make-let first body)
          (make-let first (iter rest)))))

  (iter (cadr exps) (caddr exps)))
