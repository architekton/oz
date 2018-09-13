; a)
(define (eval-and exps env)
  (if ((null? exps)
       #t
       (let ((first (eval (car exps) env)))
         (if (first)
             (eval-and (cdr exps) env)
             #f)))))

(define (eval-or exps env)
  (if ((null? exps)
       #f
       (let ((first (eval (car exps) env)))
         (if (first)
             #t
             (eval-and (cdr exps) env))))))

(put 'and eval-and)
(put 'or eval-or)

; b)
(define (eval-and-derived exps env)
  (if (null? exps)
      #t
      (make-if (cond-predicate (car exps))
               (eval-and-derived (cdr exps) env)
               #f)))

(define (eval-or-derived exps env)
  (if (null? exps)
      #f
      (make-if (cond-predicate (car exps))
               #t
               (eval-and-derived (cdr exps) env))))

