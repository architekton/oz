(load "../regsim.scm")

(define expt-rec-machine
  (make-machine
    '(continue n res b)
    (list (list '* *) (list '= =) (list '- -))
    '(controller
       (assign continue (label expt-done))

       expt-loop
       (test (op =) (reg n) (const 0))
       (branch (label expt-base))
       (save continue)
       (assign n (op -) (reg n) (const 1))
       (assign continue (label after-expt))
       (goto (label expt-loop))

       after-expt
       (restore continue)
       (assign res (op *) (reg b) (reg res))
       (goto (reg continue))

       expt-base
       (assign res (const 1))
       (goto (reg continue))

       expt-done)))

(set-register-contents! expt-rec-machine 'n 5)
(set-register-contents! expt-rec-machine 'b 2)

(start expt-rec-machine)

(get-register-contents expt-rec-machine 'res)

(define expt-iter-machine
  (make-machine
    '(continue n b product counter)
    (list (list '* *) (list '= =) (list '- -))
    '(controller
       (assign counter (reg n))
       (assign product (const 1))

       expt-loop
       (test (op =) (reg counter) (const 0))
       (branch (label expt-done))
       (assign counter (op -) (reg counter) (const 1))
       (assign product (op *) (reg product) (reg b))
       (goto (label expt-loop))

       expt-done)))

(set-register-contents! expt-iter-machine 'n 5)
(set-register-contents! expt-iter-machine 'b 2)

(start expt-iter-machine)

(get-register-contents expt-iter-machine 'product)


