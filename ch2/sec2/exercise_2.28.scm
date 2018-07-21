(define x (list (list 1 2) (list 3 4)))

(define nil '())

(define (fringe tree)
  (if (null? tree)
      nil
      (if (pair? (car tree))
          (append (car tree) (fringe (cdr tree)))
          (cons (car tree) (fringe (cdr tree))))))


(fringe x)
