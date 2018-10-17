(load "../regsim.scm")

(define (make-new-machine)
  (let ((pc (make-register 'pc))
        (flag (make-register 'flag))
        (stack (make-stack))
        (the-instruction-sequence '())
        (execution-count 0)
        (trace-toggle #f))
    (let ((the-ops
            (list (list 'initialize-stack
                        (lambda () (stack 'initialize)))
                  ;;**next for monitored stack (as in section 5.2.4)
                  ;;  -- comment out if not wanted
                  (list 'print-stack-statistics
                        (lambda () (stack 'print-statistics)))))
          (register-table
            (list (list 'pc pc) (list 'flag flag))))
      (define (allocate-register name)
        (if (assoc name register-table)
            (error "Multiply defined register: " name)
            (set! register-table
              (cons (list name (make-register name))
                    register-table)))
        'register-allocated)
      (define (lookup-register name)
        (let ((val (assoc name register-table)))
          (if val
              (cadr val)
              (error "Unknown register:" name))))
      (define (execute)
        (let ((insts (get-contents pc)))
          (if (null? insts)
              'done
              (begin
                (set! execution-count (+ 1 execution-count))
                (if trace-toggle
                    (begin (newline)
                           (display (caar insts))))
                ((instruction-execution-proc (car insts)))
                (execute)))))
      (define (dispatch message)
        (cond ((eq? message 'start)
               (set-contents! pc the-instruction-sequence)
               (execute))
              ((eq? message 'install-instruction-sequence)
               (lambda (seq) (set! the-instruction-sequence seq)))
              ((eq? message 'allocate-register) allocate-register)
              ((eq? message 'get-register) lookup-register)
              ((eq? message 'install-operations)
               (lambda (ops) (set! the-ops (append the-ops ops))))
              ((eq? message 'stack) stack)
              ((eq? message 'operations) the-ops)
              ((eq? message 'reset-count) (set! execution-count 0))
              ((eq? message 'get-count) execution-count)
              ((eq? message 'trace-on) (set! trace-toggle #t))
              ((eq? message 'trace-off) (set! trace-toggle #f))
              (else (error "Unknown request -- MACHINE" message))))
      dispatch)))

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

(fact-machine 'trace-on)
(set-register-contents! fact-machine 'n 6)
(start fact-machine)
(get-register-contents fact-machine 'val)

;(fact-machine 'get-count)
;(fact-machine 'reset-count)
;(fact-machine 'get-count)
