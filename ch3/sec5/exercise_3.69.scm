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


(define (triples s t u)
    (cons-stream
      (list (stream-car s) (stream-car t) (stream-car u))
      (interleave
        (stream-map (lambda (x) (cons (stream-car s) x))
                    (pairs t u))
        (triples (stream-cdr s) (stream-cdr t) (stream-cdr u)))))


(define t (triples integers integers integers))

(define (p-triple? a b c)
  (= (square c)
     (+ (square a) (square b))))


(define p-triples
  (stream-filter
    (lambda (triple)
      (p-triple? (car triple) (cadr triple) (caddr triple)))
    t))

(display-stream p-triples)

; Improve the speed of this answer
