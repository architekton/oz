(define (make-table)
  (let ((local-table (list '*table*)))

    (define (lookup keys)
      (define (iter keys table)
        (cond
          ; if we find a record with the last key return it else false
          ((null? (cdr keys))
           (let ((record (assoc (car keys) (cdr table))))
             (if record
                 (cdr record)
                 #f)))

          ; recurse with the cdr of keys
          (else
            (let ((subtable (assoc (car keys) (cdr table))))
              (if subtable
                  (iter (cdr keys) subtable)
                  #f)))))

      (iter keys local-table))


    (define (insert! keys value)

      (define (make-rest keys)
        (if (null? (cdr keys))
            (cons (car keys) '())
            (make-rest (cdr keys))))

      (define (iter keys table)
        (let ((record (assoc (car keys) (cdr table))))
          (cond
            ; we have reached the last key
            ((null? (cdr keys))
             ; if the record exists replace it's value otherwise create it
             (if record
                 (set-cdr! record value)
                 (set-cdr! table
                           (cons (cons (car keys) value) (cdr table)))))
          (else
            (if record
                (if (pair? (cdr record))
                    (iter (cdr keys) record)
                    (begin
                      (set-cdr! record (cons (cons (cadr keys) '()) '()))
                      (iter (cdr keys) record)))

                (set-cdr! table (cons (make-rest keys) (cdr table))))))))

      (iter keys local-table)
      'ok)

    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))

(define operation-table (make-table))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))

(put '(a) 1)
(put '(a b) 2)
(put '(a b c) 3)
(get '(a))
(get '(a b))
(get '(a b c))

