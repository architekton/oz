; Recursive process
(controller
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

  expt-done)

; Iterative process
(controller
  (assign counter (reg n))
  (assign product (const 1))

  expt-loop
  (test (op =) (reg counter) (const 0))
  (branch (label expt-done))
  (assign counter (op -) (reg counter) (const 1))
  (assign product (op *) (reg product) (reg b))
  (goto (label expt-loop))

  expt-done)

; Todo maybe diagrams
