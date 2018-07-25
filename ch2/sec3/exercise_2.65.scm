(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right) (list entry left right))

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (entry set)) true)
        ((< x (entry set))
         (element-of-set? x (left-branch set)))
        ((> x (entry set))
         (element-of-set? x (right-branch set)))))

(define (adjoin-set x set)
  (cond ((null? set) (make-tree x '() '()))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree (entry set)
                    (adjoin-set x (left-branch set))
                    (right-branch set)))
        ((> x (entry set))
         (make-tree (entry set)
                    (left-branch set)
                    (adjoin-set x (right-branch set))))))
; From 2.63
(define (tree->list tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))

; From 2.64
(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))

; Ordered list intersection
(define (intersection-set-list set1 set2)
  (if (or (null? set1) (null? set2))
      '()
      (let ((x1 (car set1)) (x2 (car set2)))
        (cond ((= x1 x2)
               (cons x1
                     (intersection-set-list (cdr set1)
                                       (cdr set2))))
              ((< x1 x2)
               (intersection-set-list (cdr set1) set2))
              ((< x2 x1)
               (intersection-set-list set1 (cdr set2)))))))

; Ordered list union
(define (union-set-list set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        ((= (car set1) (car set2))
         (cons (car set1) (union-set-list (cdr set1) (cdr set2))))
        ((< (car set1) (car set2))
         (cons (car set1) (union-set-list (cdr set1) set2)))
        (else
          (cons (car set2) (union-set-list set1 (cdr set2))))))


; Given that tells us to use 2.63 and 2.64, conversion from a tree to a list
; takes O(n), finding the intersection or union of an ordered list again is
; O(n), converting back to a balaned tree takes O(n), hence, sequentially these
; operations O(n). TODO alternative solution without 2.63/2.64

(define (intersection-set tree1 tree2)
  (list->tree (intersection-set-list (tree->list tree1)
                                     (tree->list tree2))))

(define (union-set tree1 tree2)
  (list->tree (union-set-list (tree->list tree1)
                              (tree->list tree2))))

; Taken from figure 2.16 they are all representations of the same list
(define tree1 '(7 (3 (1 () ()) (5 () ())) (9 () (11 () ()))))
(define tree2 '(3 (1 () ()) (7 (5 () ()) (9 () (11 () ())))))
(define tree3 '(5 (3 (1 () ()) ()) (9 (7 () ()) (11 () ()))))

; Should all be the same
(intersection-set tree1 tree2)
(intersection-set tree1 tree3)
(intersection-set tree2 tree1)
(intersection-set tree2 tree3)
(intersection-set tree3 tree1)
(intersection-set tree3 tree2)

(union-set tree1 tree2)
(union-set tree1 tree3)
(union-set tree2 tree1)
(union-set tree2 tree3)
(union-set tree3 tree1)
(union-set tree3 tree2)
