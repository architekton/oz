; a)
; (controller
;   (assign continue (label fib-done))
;
;   fib-loop
;   (test (op <) (reg n) (const 2))
;   (branch (label immediate-answer))
;   (save continue)
;   (assign continue (label afterfib-n-1))
;   (save n)
;   (assign n (op -) (reg n) (const 1))
;   (goto (label fib-loop))
;
;   afterfib-n-1
;   (restore n)
;   (restore continue) ; redundant
;   (assign n (op -) (reg n) (const 2))
;   (save continue) ; redundant
;   (assign continue (label afterfib-n-2))
;   (save val)
;   (goto (label fib-loop))
;
;   afterfib-n-2
;   (restore n) ; changed
;   (restore continue)
;   (assign val (op +) (reg val) (reg n))
;   (goto (reg continue))
;
;   immediate-answer
;   (assign val (reg n))
;   (goto (reg continue))
;
;   fib-done)

; b)
(load "../regsim.scm")

(define (make-save inst machine stack pc)
  (let ((regname (stack-inst-reg-name inst)))
    (let ((reg (get-register machine regname)))
      (lambda ()
        (push stack (list regname (get-contents reg)))
        (advance-pc pc)))))

(define (make-restore inst machine stack pc)
  (let ((regname (stack-inst-reg-name inst)))
    (let ((reg (get-register machine regname)))
      (lambda ()
        (let ((popped (pop stack)))
          (if (eq? (car popped) regname)
              (begin
                (set-contents! reg (cadr popped))
                (advance-pc pc))
              (error "Invalid register name")))))))

; c)
; Todo
