; add the contents of two registers and store the result in the first
(load "../regsim.scm")

(define (make-execution-procedure inst labels machine
                                  pc flag stack ops)
  (cond ((eq? (car inst) 'assign)
         (make-assign inst machine labels ops pc))
        ((eq? (car inst) 'test)
         (make-test inst machine labels ops flag pc))
        ((eq? (car inst) 'branch)
         (make-branch inst machine labels flag pc))
        ((eq? (car inst) 'goto)
         (make-goto inst machine labels pc))
        ((eq? (car inst) 'save)
         (make-save inst machine stack pc))
        ((eq? (car inst) 'restore)
         (make-restore inst machine stack pc))
        ((eq? (car inst) 'perform)
         (make-perform inst machine labels ops pc))
        ((eq? (car inst) 'add)
         (make-add inst machine labels ops pc))
        (else (error "Unknown instruction type -- ASSEMBLE"
                     inst))))

(define (make-add inst machine labels operations pc)
  (let ((target (get-register machine (add-reg-name inst)))
        (source (get-register machine (add-reg2-name inst))))
    (lambda ()
      (set-contents! target (+ (get-contents target)
                               (get-contents source)))
      (advance-pc pc))))

(define (add-reg-name add-instruction)
  (cadr add-instruction))

(define (add-reg2-name add-instruction)
  (caddr add-instruction))

(define test-machine
  (make-machine
    '(a b)
    (list)
    '(start
       (assign a (const 3))
       (assign b (const 4))
       (add a b))))

(start test-machine)
(get-register-contents test-machine 'a)

