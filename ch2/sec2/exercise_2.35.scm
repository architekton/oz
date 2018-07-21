(define nil '())

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(define (count-leaves t)
  (accumulate + 0 (map (lambda (curr)
                         (if (pair? curr)
                             (count-leaves curr)
                             1))
                       t)))

(count-leaves (list 1 (list 2 (list 3 4))))
