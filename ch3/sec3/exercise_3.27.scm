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
               (cdr (car set-of-records)))
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

(define (lookup key table)
  ((table 'lookup-proc) key))

(define (insert! key value table)
  ((table 'insert-proc!) key value))

(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))

(define (memoize f)
  (let ((table (make-table)))
    (lambda (x)
      (let ((previously-computed-result (lookup x table)))
        (or previously-computed-result
            (let ((result (f x)))
              (insert! x result table)
              result))))))

(define memo-fib
  (memoize (lambda (n)
             (cond ((= n 0) 0)
                   ((= n 1) 1)
                   (else (+ (memo-fib (- n 1))
                            (memo-fib (- n 2))))))))

(memo-fib 6)

; This is standard dynamic programming, we do not recompute our solved
; subproblems. In this case n - 2 and n - 1, hence going from exponential to
; linear by caching our sub problems in the table.

; No it won't work. fib is defined to call itself and not memo-fib. So the
; memoization procedure won't be called on the subproblems.

