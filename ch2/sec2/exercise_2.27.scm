(define x (list (list 1 2) (list 3 4)))

; If the item we are looking at is a list, call reverse on it recursively

(define (reverse lst)
  (define (reverse-iter lst result)
    (if (null? lst)
        result
        (reverse-iter (cdr lst) (cons (if (pair? (car lst))
                                          (reverse (car lst))
                                          (car lst))
                                      result))))

  (reverse-iter lst '()))


(reverse x)

(reverse (list 1 2 3 4))

(reverse '())
