; factorial
; (controller
;   (assign continue (label fact-done))
;
;   fact-loop
;   (test (op =) (reg n) (const 1))
;   (branch (label base-case))
;   (save continue)
;   (save n)
;   (assign n (op -) (reg n) (const 1))
;   (assign continue (label after-fact))
;   (goto (label fact-loop))
;
;   after-fact
;   (restore n)
;   (restore continue)
;   (assign val (op *) (reg n) (reg val))
;   (goto (reg continue))
;
;   base-case
;   (assign val (const 1))
;   (goto (reg continue))
;
;   fact-done)


; trace with Fact(3)

; 0.
; empty

; 1.
; fact-done 3

; 2.
; fact-done 3
; after-fact 2

; 3.
; fact-done 3

; 4.
; empty


; fibonacci
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
;   (restore continue)
;   (assign n (op -) (reg n) (const 2))
;   (save continue)
;   (assign continue (label afterfib-n-2))
;   (save val)
;   (goto (label fib-loop))
;
;   afterfib-n-2
;   (assign n (reg val))
;   (restore val)
;   (restore continue)
;   (assign val (op +) (reg val) (reg n))
;   (goto (reg continue))
;
;   immediate-answer
;   (assign val (reg n))
;   (goto (reg continue))
;
;   fib-done)


; trace with Fib(3)

; 0.
; empty

; 1.
; fib-done 3

; 2.
; fib-done 3
; afterfib-n-1 2

; 3.
; fib-done 3
; afterfib-n-1 1

; 4.
; fib-done 3
; afterfib-n-1 1
; afterfib-n-2 1

; 4
; fib-done 3

; 5.
; empty

