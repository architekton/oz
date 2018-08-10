(define random-init 7)

; From ch3support.scm
(define (rand-update x)
  (let ((a 27) (b 26) (m 127))
    (modulo (+ (* a x) b) m)))

(define rand
  (let ((x random-init))
    (define (dispatch msg)
      (cond ((eq? msg 'generate)
             (begin (set! x (rand-update x)) x))
            ((eq? msg 'reset)
             (lambda (val)
               (set! x val)
               x))
            (else
              (error "Invalid symbol"))))
    dispatch))

((rand 'reset) 10)
(rand 'generate)
(rand 'generate)
((rand 'reset) 10)
(rand 'generate)
(rand 'generate)
