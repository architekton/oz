; Modification from exercise 3.17
(define (has-cycle? x)
  (let ((seen '()))
    (define (is-seen? x)
      (if (memq x seen)
          #t
          (begin (set! seen (cons x seen)) #f)))

    (define (cycle? x)
      (cond ((not (pair? x)) #f)
            ((is-seen? x) #t)
            (else
              (or (cycle? (car x))
                  (cycle? (cdr x))))))

    (cycle? x)))

; Taken from exercise 3.16
(define cycle (list 'a 'b 'c))
; Set the null terminating element to point to the begining of the list or any
; element for that matter, we could set the first link to point back to itself.
(set-cdr! (cddr cycle) cycle)

(has-cycle? cycle)
