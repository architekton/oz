(define nil '())
(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right) (list entry left right))


(define (lookup given-key set-of-records)
  (cond ((null? set-of-records) #f)
        ((= given-key (key (car set-of-records)))
         (car set-of-records))
        ((< given-key (key (car set-of-records)))
         (lookup given-key (left-branch set-of-records)))
        (else
          (lookup (given-key (right-branch set-of-records))))))
