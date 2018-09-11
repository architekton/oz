(load "streams.scm")

(define random-init 7)

(define (rand-update x)
  (let ((a 27) (b 26) (m 127))
    (modulo (+ (* a x) b) m)))

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define (random-in-range-stream low high)
  (cons-stream (random-in-range low high) (random-in-range-stream low high)))

(define (monte-carlo experiment-stream passed failed)
  (define (next passed failed)
    (cons-stream
      (/ passed (+ passed failed))
      (monte-carlo
        (stream-cdr experiment-stream) passed failed)))
  (if (stream-car experiment-stream)
      (next (+ passed 1) failed)
      (next passed (+ failed 1))))

(define (p x y)
  (< (sqrt (+ (square x) (square y))) 1))

(define (estimate-intergral p x1 x2 y1 y2)
  (define area (* (- x2 x1) (- y2 y1)))
  (define experiment
    (let ((xstream (random-in-range-stream x1 x2))
          (ystream (random-in-range-stream y1 y2)))
      (stream-map p xstream ystream)))

  (scale-stream (monte-carlo experiment 0 0) area))

(define t (estimate-intergral p -1.0 1.0 -1.0 1.0))

(stream-ref t 100000)


