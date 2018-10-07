; Old flatten
;
; (define (flatten-stream stream)
;   (if (stream-null? stream)
;       the-empty-stream
;       (interleave-delayed
;         (stream-car stream)
;         (delay (flatten-stream (stream-cdr stream))))))
;

; a)
(define (simple-stream-flatmap proc s)
  (simple-fratten (stream-map proc s)))

(define (simple-flatten stream)
  (stream-map stream-car
              (stream-filter (lambda (str) (not (stream-null? str))) stream)))

; b) No as long as there are no infinite streams

