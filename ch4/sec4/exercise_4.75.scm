(load "../query.scm")

(define (singleton-stream? stream)
  (and (not (stream-null? stream))
       (stream-null? (stream-cdr stream))))

(define (unique-query exps) (car exps))

(define (uniquely-asserted contents frame-stream)
  (stream-flatmap
    (lambda (frame)
      (let ((qresult (qeval (unique-query contents)
                            (singleton-stream frame))))
        (if (singleton-stream? qresult)
            qresult
            the-empty-stream)))
    frame-stream))

(define (initialize-data-base rules-and-assertions)
  (define (deal-out r-and-a rules assertions)
    (cond ((null? r-and-a)
           (set! THE-ASSERTIONS (list->stream assertions))
           (set! THE-RULES (list->stream rules))
           'done)
          (else
            (let ((s (query-syntax-process (car r-and-a))))
              (cond ((rule? s)
                     (store-rule-in-index s)
                     (deal-out (cdr r-and-a)
                               (cons s rules)
                               assertions))
                    (else
                      (store-assertion-in-index s)
                      (deal-out (cdr r-and-a)
                                rules
                                (cons s assertions))))))))
  (let ((operation-table (make-table)))
    (set! get (operation-table 'lookup-proc))
    (set! put (operation-table 'insert-proc!)))
  (put 'and 'qeval conjoin)
  (put 'or 'qeval disjoin)
  (put 'not 'qeval negate)
  (put 'unique 'qeval uniquely-asserted) ; changed
  (put 'lisp-value 'qeval lisp-value)
  (put 'always-true 'qeval always-true)
  (deal-out rules-and-assertions '() '()))

(initialize-data-base microshaft-data-base)
(query-driver-loop)

(unique (job ?x (computer wizard)))

