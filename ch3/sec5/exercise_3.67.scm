(load "streams.scm")

(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
                   (interleave s2 (stream-cdr s1)))))

; considering the table introduced we just don't want to throw away the rest of
; the column
(define (pairs s t)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (interleave
      (interleave
        (stream-map (lambda (x) (list (stream-car s) x))
                    (stream-cdr t))
        (stream-map (lambda (x) (list (stream-car t) x))
                    (stream-cdr s)))
      (pairs (stream-cdr s) (stream-cdr t)))))

(define s (pairs integers integers))

(display-stream s)


