; until <condition> do <body>

(define (until? exps) (tagged-list? exps 'until))
(define (until-condition exps) (cadr exps))
(define (until-body exps) (cadddr exps))

(define (until->combination exps)
  (list
    (list 'define
          (list 'iter
                (make-if (until->condition exps)
                         '() ; if the condition is true exit
                         (list 'begin ; otherwise continue executing
                               (until-body exps)
                               (list 'iter)))))
    (list 'iter)))


