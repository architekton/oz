(load "streams.scm")

; a)
(define (stream-div s1 s2)
  (stream-map / s1 s2))

(define (integrate-series s)
  (stream-div s integers))

(define t (stream-map display-line (integrate-series integers)))

; b)
(define cosine-series
  (cons-stream 1 (integrate-series (scale-stream sine-series -1))))

(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))


