; (define (add-assertion! assertion)
;   (store-assertion-in-index assertion)
;   (set! THE-ASSERTIONS
;     (cons-stream assertion THE-ASSERTIONS))
;   'ok)

; The following produces an infinite stream when forcing, using let produces
; the correct delayed evaluation we expect.
