(load "../regsim.scm")

(define fact-machine
  (make-machine
    '(product count n val continue)
    (list (list '= =) (list '* *) (list '- -))
    '(controller
       (assign continue (label fact-done))

       fact-loop
       (test (op =) (reg n) (const 1))
       (branch (label base-case))
       (save continue)
       (save n)
       (assign n (op -) (reg n) (const 1))
       (assign continue (label after-fact))
       (goto (label fact-loop))

       after-fact
       (restore n)
       (restore continue)
       (assign val (op *) (reg n) (reg val))
       (goto (reg continue))

       base-case
       (assign val (const 1))
       (goto (reg continue))

       fact-done)))

(set-register-contents! fact-machine 'n 2)
(start fact-machine)
(get-register-contents fact-machine 'val)
((fact-machine 'stack) 'print-statistics)

(set-register-contents! fact-machine 'n 3)
(start fact-machine)
(get-register-contents fact-machine 'val)
((fact-machine 'stack) 'print-statistics)

(set-register-contents! fact-machine 'n 4)
(start fact-machine)
(get-register-contents fact-machine 'val)
((fact-machine 'stack) 'print-statistics)

(set-register-contents! fact-machine 'n 5)
(start fact-machine)
(get-register-contents fact-machine 'val)
((fact-machine 'stack) 'print-statistics)

(set-register-contents! fact-machine 'n 6)
(start fact-machine)
(get-register-contents fact-machine 'val)
((fact-machine 'stack) 'print-statistics)

; max-depth = 2(n-1) n > 1
; pushes = n(n-1) n > 1
