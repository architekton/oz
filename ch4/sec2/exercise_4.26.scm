; (define (unless condition usual-value exceptional-value)
;   (if condition exceptional-value usual-value))
;

(define (unless? exps) (tagged-list? exps 'unless))
(define (unless-condition) (cadr exps))
(define (unless-usual-value) (caddr exps))
(define (unless-exceptional-value) (cadddr exps))

(define (unless->if exps)
  (make-if (unless-condition exps)
           (unless-exceptional-value)
           (unless-usual-value)))

