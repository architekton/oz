(load "streams.scm")

(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
                   (interleave s2 (stream-cdr s1)))))

(define (pairs s t)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (interleave
      (stream-map (lambda (x) (list (stream-car s) x))
                  (stream-cdr t))
      (pairs (stream-cdr s) (stream-cdr t)))))

(define s (pairs integers integers))

(define (cnt-pre pair stream)
  (let ((count 0))
    (define (iter stream)
      (if (equal? (stream-car stream) pair)
          count
          (begin (set! count (+ 1 count))
                 (iter (stream-cdr stream)))))
    (iter stream)))

(cnt-pre '(1 100) s)
; 197
; 2 ^ 1 * (100 - 1) + 2 ^ (1 - 1) - 2 = 197

(cnt-pre '(2 100) s)
; 392
; 2 ^ 2 * (100 - 2) + 2 ^ (2 - 1) - 2 = 392

(cnt-pre '(3 100) s)
; 778
; 2 ^ 3  * (100 - 3) + 2 ^ (3 - 1) - 2 = 778

(cnt-pre '(4 100) s)
; 1542
; 2 ^ 4  * (100 - 4) + 2 ^ (4 - 1) - 2 = 1542

(cnt-pre '(5 100) s)
; 3054
; 2 ^ 5  * (100 - 5) + 2 ^ (5 - 1) - 2 = 3054

; 2 ^ i * (j - i) + 2 ^ (i - 1) - 2

; (100, 100)
; 2 ^ 100 - 2


