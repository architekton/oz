(define nil '())

(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
  (list entry left right))

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

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((l-size (quotient (- n 1) 2)))
        (let ((r-size (- n (+ l-size 1))))
          (cons
            (make-tree
              ; this entry
              (cadr (partial-tree elts l-size))
              ; left tree
              (car (partial-tree elts l-size))
              ; right tree
              (car (partial-tree (cddr (partial-tree elts l-size)) r-size)))
            ; remaining elements not part of the tree
            (cdr (partial-tree (cddr (partial-tree elts l-size)) r-size)))))))


(partial-tree (list 1 3 5 7 9 11) 6)

; a)
; partlal-tree splits the list into 3 parts the left-tree, this-entry and
; right-tree. The split occurs at (n-1)/2, n/2, (n+1)/2 by doing car and cdr
; manipulations. We then recursively build the subtrees into a balanced tree.
; The tree is balanced because we split the list and sublists symmetrically.

; b) The recurrence relation is T(n) = 2*T(n) + O(1). By the master theorem
; time complexity is O(n).

; https://en.wikipedia.org/wiki/Master_theorem_(analysis_of_algorithms)

