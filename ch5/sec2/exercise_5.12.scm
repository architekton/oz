(load "../regsim.scm")

(define (assemble controller-text machine)
  (extract-labels controller-text
                  (lambda (insts labels)
                    (set-analysis-info! insts labels machine)
                    (update-insts! insts labels machine)
                    insts)))


(define (make-new-machine)
  (let ((pc (make-register 'pc))
        (flag (make-register 'flag))
        (stack (make-stack))
        (the-instruction-sequence '())
        (analysis-info '()))
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
                ((instruction-execution-proc (car insts)))
                (execute)))))
      (define (dispatch message)
        (cond ((eq? message 'start)
               (set-contents! pc the-instruction-sequence)
               (execute))
              ((eq? message 'install-instruction-sequence)
               (lambda (seq) (set! the-instruction-sequence seq)))
              ((eq? message 'get-analysis-info)
               analysis-info)
              ((eq? message 'set-analysis-info)
               (lambda (info) (set! analysis-info info)))
              ((eq? message 'allocate-register) allocate-register)
              ((eq? message 'get-register) lookup-register)
              ((eq? message 'install-operations)
               (lambda (ops) (set! the-ops (append the-ops ops))))
              ((eq? message 'stack) stack)
              ((eq? message 'operations) the-ops)
              (else (error "Unknown request -- MACHINE" message))))
      dispatch)))

(define (get-analysis-info machine)
  (machine 'get-analysis-info))

(define (set-analysis-info! insts labels machine)
  (let ((insts (map (lambda (inst) (car inst)) insts)))
    ((machine 'set-analysis-info) (get-instructions insts))))

; a)
(define (get-instructions insts)
  (let ((instructions '()))
    (for-each
      (lambda (inst)
        (if (not (member (symbol->string (car inst)) instructions))
            (set! instructions (cons (symbol->string (car inst)) instructions))))
      insts)
    (sort instructions string<?)))

; b) Todo
; c) Todo
; d) Todo

(define expt-rec-machine
  (make-machine
    '(b res continue n)
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

(set-register-contents! expt-rec-machine 'b 2)
(set-register-contents! expt-rec-machine 'n 5)

(start expt-rec-machine)
(get-analysis-info expt-rec-machine)



