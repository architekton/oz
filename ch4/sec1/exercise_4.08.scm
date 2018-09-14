(define (let? exps) (tagged-list? exps 'let))
(define (named-let? exps) (and (let? exps) (symbol? (cadr exps))))

(define (let-vars exps)
  (if (null? exps)
      '()
      (cons (caar exps) (let-vars (cdr exps)))))

(define (let-vals exps)
  (if (null? exps)
      '()
      (cons (cadar exps) (let-vars (cdr exps)))))

(define (let->combination exps)
  (cons (make-lambda (let-vars (cadr exps))  (cddr exps))
        (let-vals (cadr exps))))

(define (let->combination exps)
  (define (named-let-comb exps)
    (list 'define (cadr exps)
          (cons (make-lambda (let-vars (caddr exps)) (cdddr exps))
                (let-vals (caddr exps)))))
  (define (let-comb exps)
      (cons (make-lambda (let-vars (cadr exps))  (cddr exps))
            (let-vals (cadr exps))))

  (if (named-let? exps)
      (named-let-comb exps)
      (let-comb exps)))







