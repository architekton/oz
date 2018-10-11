; a) 3

; b)
(load "../regsim.scm")
(define (extract-labels text receive)
  (if (null? text)
      (receive '() '())
      (extract-labels (cdr text)
                      (lambda (insts labels)
                        (let ((next-inst (car text)))
                          (if (symbol? next-inst)
                              (let ((val (assoc next-inst labels)))
                                (if val
                                    (error "Label name already used: EXTRACT-LABELS" next-inst)
                                    (receive insts
                                             (cons (make-label-entry next-inst
                                                                     insts)
                                                   labels))))
                              (receive (cons (make-instruction next-inst)
                                             insts)
                                       labels)))))))



(define test-machine
  (make-machine
    '(a)
    (list)
    '(start
       (goto (label here))
       here
       (assign a (const 3))
       (goto (label there))
       here
       (assign a (const 4))
       (goto (label there))
       there)))

(start test-machine)
(get-register-contents test-machine 'a)

