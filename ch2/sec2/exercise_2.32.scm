(define nil '())

; See the counting change problem, the concept is similar, the difference is
; here rather than counting we produce the actual subsets

(define (subsets s)
  (if (null? s)
      (list nil)
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (x) (cons (car s) x)) rest)))))


(subsets (list 1 2 3))
