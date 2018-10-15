(load "../regsim.scm")

(define (make-machine ops controller-text)
  (let ((machine (make-new-machine)))
    ((machine 'install-operations) ops)
    ((machine 'install-instruction-sequence)
     (assemble controller-text machine))
    machine))


(define (make-new-machine)
  (let ((pc (make-register 'pc))
        (flag (make-register 'flag))
        (stack (make-stack))
        (the-instruction-sequence '()))
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
              (begin (allocate-register name)
                     (lookup-register name)))))

      (define (execute)
        (let ((insts (get-contents pc)))
          (if (null? insts)
              'done
              (begin
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
              (else (error "Unknown request -- MACHINE" message))))
      dispatch)))

(define expt-rec-machine
  (make-machine
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


