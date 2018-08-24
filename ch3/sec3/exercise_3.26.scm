(define nil '())
(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right) (list entry left right))

; Small modifications to adjoin set. Since the entry is now (key value) we take
; the car of each entry to compare keys. Same goes for lookup. These were taken
; from chapter 2.

(define (adjoin-set x set)
  (cond ((null? set) (make-tree x '() '()))
        ((= (car x) (car (entry set)) set))
        ((< (car x) (car (entry set)))
         (make-tree (entry set)
                    (adjoin-set x (left-branch set))
                    (right-branch set)))
        ((> (car x) (car (entry set)))
         (make-tree (entry set)
                    (left-branch set)
                    (adjoin-set x (right-branch set))))))


(define (make-table)
  (let ((local-table '()))

    (define (lookup given-key)
      (define (iter given-key set-of-records)
        (cond ((null? set-of-records) #f)
              ((= given-key (car (entry set-of-records)))
               (car set-of-records))
              ((< given-key (car (entry set-of-records)))
               (iter given-key (left-branch set-of-records)))
              (else
                (iter given-key (right-branch set-of-records)))))

      (iter given-key local-table))


    (define (insert! key value)
      (set! local-table (adjoin-set (cons key value) local-table))
      'ok)

    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))

(define operation-table (make-table))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))

; Todo more testing
(put 1 'hi)
(put 3 'test)
(put 5 'world)
(get 3)
(get 5)
(get 1)

