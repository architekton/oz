; Instead of car choices and cdr choices replace with a random selection from
; the list and remove that random selection from the next selection.

(define (analyze-ramb exp)
  (let ((cprocs (map analyze (amb-choices exp))))
    (lambda (env succeed fail)
      (define (try-next choices)
        (if (null? choices)
            (fail)
            (let ((choice (list-ref choices (random (length choices)))))
              (choice env
                      succeed
                      (lambda ()
                        (try-next (remove choices choice)))))))
      (try-next cprocs))))


