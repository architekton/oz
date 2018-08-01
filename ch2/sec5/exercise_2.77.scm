(load "common.scm")

(put 'real-part '(complex) real-part)
(put 'imag-part '(complex) imag-part)
(put 'magnitude '(complex) magnitude)
(put 'angle '(complex) angle)

(magnitude (make-complex-from-real-imag 3 4))

; apply-generic is called 2 times, dispatching for each tagged layer until
; there are no more tags. The new put statements are required to resolve the
; first layer from our compound structure ('complex 'rectangular 3 4), since we
; have not defined them.
