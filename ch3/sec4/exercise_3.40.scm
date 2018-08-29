(define x 10)
(parallel-execute ((lambda () (set! x (* x x))))
                  ((lambda () (set! x (* x x x)))))

; We will get values ranging from the minimum number of multiplications
; executed to all the multiplications executed normally.
; Therefore the values we get are:

; 100
; 1,000
; 10,000
; 100,000
; 1,000,000

(define x 10)
(define s (make-serializer))
(parallel-execute (s (lambda () (set! x (* x x))))
                  (s (lambda () (set! x (* x x x)))))

; If we serialize we get the same value depending on the order of procedure
; execution

; P1 -> P2 = 1,000,000
; P2 -> P1 = 1,000,000

