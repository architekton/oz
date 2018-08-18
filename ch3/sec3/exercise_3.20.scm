(define x (cons 1 2))
(define z (cons x x))
(set-car! (cdr z) 17)
(car x)

; TODO
;
;                  .--------------------------------.
;                  | cons                           |
;                  | car                            |
;                  | cdr                            |
; global env------>| set-car!                       |
;                  | set-cdr!                       |
;                  | x                              |
;                  | z                              |
;                  '--------------------------------'
;

