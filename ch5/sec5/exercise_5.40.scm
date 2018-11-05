(load "../syntax.scm")
(load "../compiler_ctenv.scm")

; see the loaded file above


(define tx
  (compile
    '(define (factorial n)
       (if (= n 1)
           1
           (* (factorial (- n 1)) n)))
    'val
    'next
    '()))

(for-each (lambda (x) (newline) (display x)) (caddr tx))


