(load "streams.scm")
(load "exercise_3.61.scm")

(define (div-series s1 s2)
  (let ((denom (stream-car s2)))
    (if (= 0 denom)
        (error "zero division -- DIV-SERIES")
        (scale-stream (mul-series s1
                                  (invert-unit-series
                                    (scale-stream s2 (/ 1 denom))))
                      (/ 1 denom)))))

(define tangent (div-series sine-series cosine-series))

(define x (stream-map display-line tangent))
(stream-ref x 10)

