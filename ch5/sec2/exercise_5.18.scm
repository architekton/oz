(load "../regsim.scm")

(define (make-instruction text)
  (cons text (cons '() '())))

(define (instruction-text inst)
  (car inst))

(define (instruction-execution-proc inst)
  (cadr inst))

(define (instruction-labels inst)
  (cddr inst))

(define (set-instruction-execution-proc! inst proc)
  (set-car! (cdr inst) proc))

(define (set-instruction-labels! inst labels)
  (set-cdr! (cdr inst) labels))


(define (extract-labels text receive)
  (if (null? text)
      (receive '() '())
      (extract-labels
        (cdr text)
        (lambda (insts labels)
          (let ((next-inst (car text)))
            (if (symbol? next-inst)
                (begin
                  (if (not (null? insts))
                      (set-instruction-labels!
                        (car insts)
                        (cons next-inst (instruction-labels (car insts)))))
                  (receive insts
                           (cons (make-label-entry next-inst
                                                   insts)
                                 labels)))
                (receive (cons (make-instruction next-inst)
                               insts)
                         labels)))))))

; 5.18
(define (make-register name)
  (let ((contents '*unassigned*)
        (trace #f)
        (rname name))
    (define (dispatch message)
      (cond ((eq? message 'get) contents)
            ((eq? message 'trace-on)
             (set! trace #t))
            ((eq? message 'trace-off)
             (set! trace #f))
            ((eq? message 'set)
             (lambda (value)
               (if trace
                   (begin
                     (newline)
                     (display "Name: ")
                     (display rname)
                     (display " Old: ")
                     (display contents)
                     (display " New: ")
                     (display value)))
               (set! contents value)))
            (else
              (error "Unknown request -- REGISTER" message))))
    dispatch))

(define (register-trace-on machine register-name)
  ((get-register machine register-name) 'trace-on))

(define (register-trace-off machine register-name)
  ((get-register machine register-name) 'trace-off))

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
                    (begin
                      (for-each (lambda (label)
                                  (newline)
                                  (display "Label: ")
                                  (display label))
                                (instruction-labels (car insts)))
                      (newline)
                      (display (instruction-text (car insts)))))
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

; Enable trace on result register
(register-trace-on fact-machine 'val)

(set-register-contents! fact-machine 'n 6)
(start fact-machine)

; Name: val Old: *unassigned* New: 1
; Name: val Old: 1 New: 2
; Name: val Old: 2 New: 6
; Name: val Old: 6 New: 24
; Name: val Old: 24 New: 120
; Name: val Old: 120 New: 720

(get-register-contents fact-machine 'val)
