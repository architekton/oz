; a
(define (make-semaphore n)
  (let ((mut (make-mutex))
        (in-use 0))
    (define  (the-semaphore m)
      (cond ((eq? m 'acquire)
             (mut 'acquire)
             (if (< in-use n)
                 (begin (set! in-use (+ 1 in-use)) (mut 'release))
                 (begin (mut 'release) (the-semaphore 'acquire))))
            ((eq? m 'release)
             (mut 'acquire)
             (set! in-use (- in-use 1))
             (mut 'release))))
    the-semaphore))


; b
(define (make-semaphore n)
  (let ((in-use 0))

    (define (test-and-set!)
      (if (< in-use n)
          (begin (set! in-use (+ 1 in-use)) #f)
          #t))

    (define (clear!)
      (if (> in-use 0)
          (set! in-use (- in-use 1))))

    (define (the-semaphore m)
      (cond ((eq? m 'acquire)
             (if (test-and-set!)
                 ; keep waiting
                 the-semaphore 'acquire))
            ((eq? m 'release)
             (clear!))))))


