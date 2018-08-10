(define random-init 7)

; From ch3support.scm
(define (rand-update x)
  (let ((a 27) (b 26) (m 127))
    (modulo (+ (* a x) b) m)))

(define rand
  (let ((x random-init))
    (lambda ()
      (set! x (rand-update x))
      x)))

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1) (+ trials-passed 1)))
          (else
            (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0))

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

; exercise 3.05
(define (p x y)
  (< (sqrt (+ (square x) (square y))) 1))

(define (estimate-intergral p x1 x2 y1 y2 trials)
  (define area (* (- x2 x1) (- y2 y1)))
  (define (experiment)
    (let ((x (random-in-range x1 x2))
          (y (random-in-range y1 y2)))
      (p x y)))

  (* area (monte-carlo trials experiment)))

(estimate-intergral p -1.0 1.0 -1.0 1.0 10000)

