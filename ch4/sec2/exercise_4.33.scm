; pass the env in eval as well
(define (text-of-quotation exp env)
  (define (convert exps)
    (cond ((null? exps)
           '())
          ((pair? exps)
           (eval (list 'cons (list 'quote (car exps))
                             (convert (cdr exps))) env))
          (else exps)))
  (convert (cadr exps)))

