(load "streams.scm")

(define random-init 7)

(define (rand-update x)
  (let ((a 27) (b 26) (m 127))
    (modulo (+ (* a x) b) m)))


(define (rand-stream command-stream)
  (cons-stream random-init
               (stream-map
                 (lambda (n cmd)
                   (if (eq? cmd 'generate)
                       (rand-update n)
                       cmd))
                 (rand-stream cmd)
                 cmd))


