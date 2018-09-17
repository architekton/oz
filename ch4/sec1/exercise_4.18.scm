; (define (solve f y0 dt)
;   (define y (integral (delay dy) y0 dt))
;   (define dy (stream-map f y))
;   y)

; translates to

; (lambda (f y0 dt)
;   (let ((y '*unassigned*) (dy '*unassigned*))
;     (let ((a (integral (delay dy) y0 dt))
;           (b (stream-map f y)))
;       (set! y a)
;       (set! dy b))
;     y))

; when we (set! dy (stream-map f y)) y has not been evaluated yet, so it would
; not work.
