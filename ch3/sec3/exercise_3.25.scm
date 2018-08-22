(define (make-table)
  (let ((local-table (list '*table*)))

    (define (lookup keys)
      (define (iter keys table)
        (cond
          ; if we are at the last key return false nothing found
          ((null? keys) #f)
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
      (define (create-chain keys)
        (if (null? (cdr keys))
            (cons (car keys) value)
            (list (car keys) (create-chain (cdr keys)))))

      (define (iter keys table)
        (cond
          ((null? (cdr keys))
           (let ((record (assoc (car keys) (cdr table))))
             ; if the record exists replace it's value otherwise create it
             (if record
                 (set-cdr! record value)
                 (set-cdr! table
                           (cons (cons (car keys) value) (cdr table))))))
          (else
            (let ((subtable (assoc (car keys) (cdr table))))
              (if subtable
                  ; if the subtable exists proceed to the next key
                  (iter (cdr keys) subtable)
                  ; otherwise create it and proceed down the chain with the
                  ; rest of the keys and create the rest
                  (set-cdr! table
                            (cons (list (car keys)
                                        (create-chain (cdr keys)))
                                  (cdr table))))))))

      (iter keys local-table)
      'ok)

    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))

; Todo test this
