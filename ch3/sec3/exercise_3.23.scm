; TODO
(define (make-dequeue)
  (let ((front-ptr '())
        (rear-ptr '()))

    (define (set-ptr-next! from to) (set! (cddr from) to))
    (define (set-ptr-prev! from to) (set! (cadr from) to))
    (define (empty-dequeue?) (null? front-ptr))

    (define (front-dequeue)
      (if (empty-dequeue?)
          (error "FRONT called with an empty dequeue")
          (car front-ptr)))

    (define (rear-dequeue)
      (if (empty-dequeue?)
          (error "REAR called with an empty dequeue")
          (car rear-ptr)))

    (define (front-insert-dequeue! item)
      (let ((new-pair (cons item (cons '() '()))))
        (cond ((empty-dequeue?)
               (set! front-ptr new-pair)
               (set! rear-ptr new-pair)
               front-ptr)
              (else
                (set-ptr-next! new-pair front-ptr)
                (set-ptr-prev! front-ptr new-pair)
                (set! front-ptr new-pair)
                front-ptr))))

    (define (rear-insert-dequeue! item)
      (let ((new-pair (cons item (cons '() '()))))
        (cond ((empty-dequeue?)
               (set! front-ptr new-pair)
               (set! rear-ptr new-pair)
               front-ptr)
              (else
                ; Reverse process
                (set-ptr-next! rear-ptr new-pair)
                (set-ptr-prev! new-pair rea-ptr)
                (set! rear-ptr new-pair)
                front-ptr))))

    (define (front-delete-dequeue!)
      (cond ((empty-dequeue?)
             (error "DELETE! called with an empty dequeue"))
            (else
              ; Set the new front to the next item
              (set! front-ptr (cddr front-ptr))
              front-ptr)))


    (define (rear-delete-dequeue!)
      (cond ((empty-dequeue?)
             (error "DELETE! called with an empty dequeue"))
            (else
              (set! rear-ptr (cadr rear-ptr))
              front-ptr)))

    ; Optional but useful
    (define (print-dequeue) front-ptr)

    (define (dispatch m)
      (cond ((eq? m 'empty-dequeue?) empty-dequeue?)
            ((eq? m 'front-dequeue) front-dequeue)
            ((eq? m 'rear-dequeue) rear-dequeue)
            ((eq? m 'front-insert-dequeue!) front-insert-dequeue!)
            ((eq? m 'front-delete-dequeue!) front-delete-dequeue!)
            ((eq? m 'rear-insert-dequeue!) rear-insert-dequeue!)
            ((eq? m 'rear-delete-dequeue!) rear-delete-dequeue!)
            ((eq? m 'print-dequeue) print-dequeue)
            (else (error "DISPATCH no such operation"))))

    dispatch))

(define q (make-dequeue))
((q 'front-insert-dequeue!) 1)
((q 'front-insert-dequeue!) 2)
((q 'print-dequeue))
((q 'rear-delete-dequeue!))
((q 'front-delete-dequeue!))
((q 'print-dequeue))


