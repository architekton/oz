(define (remove x lst)
  (cond ((null? lst) '())
        ((= x (car lst))
         (remove x (cdr lst)))
        (else
          (cons (car lst) (remove x (cdr lst))))))


(define (permutations lst)
  (if (null? lst)
      (list '())
      (apply append (map (lambda (i)
                           (map (lambda (j) (cons i j))
                                (permutations (remove i lst))))
                         lst))))

(define (multiple-dwelling-pred p)
  (let ((baker (car p))
        (cooper (cadr p))
        (fletcher (caddr p))
        (miller (cadddr p))
        (smith (cadddr (cdr p))))
    (and
      (not (= baker 5))
      (not (= cooper 1))
      (not (= fletcher 5))
      (not (= fletcher 1))
      (> miller cooper)
      (not (= (abs (- smith fletcher)) 1))
      (not (= (abs (- fletcher cooper)) 1)))))


(map (lambda (x) (map list '(baker cooper fletcher miller smith) x))
     (filter multiple-dwelling-pred
             (permutations (list 1 2 3 4 5))))



