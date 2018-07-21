(define x-point car)
(define y-point cdr)

(define start-segment car)
(define end-segment cdr)

(define (make-point x y)
  (cons x y))

(define (make-segment s e)
  (cons s e))

(define (length-segment segment)
  (let ((s (start-segment segment))
        (e (end-segment segment)))
    (let ((x1 (x-point s))
          (x2 (x-point e))
          (y1 (y-point s))
          (y2 (y-point e)))
      (sqrt (+ (square (- x1 x2))
               (square (- y1 y2))))   
      )))



; Make rectangle from perpendicular segments

(define (make-rect segment perp-segment)
  (cons segment perp-segment))

(define (per-rect rect)
  (* (+ (length-segment (car rect)) (length-segment (cdr rect))) 2))

(define (area-rect rect)
  (* (length-segment (car rect)) (length-segment (cdr rect))))


(per-rect (make-rect (make-segment
                       (make-point 0 0)
                       (make-point 2 0))
                     (make-segment 
                       (make-point 0 0)
                       (make-point 0 6))))


(area-rect (make-rect (make-segment
                        (make-point 0 0)
                        (make-point 2 0))
                      (make-segment 
                        (make-point 0 0)
                        (make-point 0 6))))

; TODO
