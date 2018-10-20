(load "../regsim.scm")

; (define (count-leaves tree)
;   (cond ((null? tree) 0)
;         ((not (pair? tree)) 1)
;         (else (+ (count-leaves (car tree))
;                  (count-leaves (cdr tree))))))

; (define (count-leaves tree)
;   (define (count-iter tree n)
;     (cond ((null? tree) n)
;           ((not (pair? tree)) (+ n 1))
;           (else
;             (count-iter (cdr tree) (count-iter (car tree) n))))))

(define count-leaves-machine
  (make-machine
    '(t continue res tmp)
    (list (list 'null? null?)
          (list 'pair? pair?)
          (list 'car car)
          (list 'cdr cdr)
          (list 'not not)
          (list '+ +))
    '((assign continue (label done))
      loop
      ; test for null tree return 0
      (test (op null?) (reg t))
      (branch (label base-1))
      ; test for not pair return 1
      (assign tmp (op pair?) (reg t))
      (test (op not) (reg tmp))
      (branch (label base-2))

      ; recurse
      (save continue)
      (save t)
      (assign continue (label rec-1))
      (assign t (op car) (reg t))
      (goto (label loop))

      rec-1
      (restore t)
      (assign t (op cdr) (reg t))
      (assign continue (label rec-2))
      (save res)
      (goto (label loop))

      rec-2
      (assign tmp (reg res))
      (restore res)
      (assign res (op +) (reg tmp) (reg res))
      (restore continue)
      (goto (reg continue))

      base-1
      (assign res (const 0))
      (goto (reg continue))

      base-2
      (assign res (const 1))
      (goto (reg continue))
      done)))

(define t '((1 . (2 . 3))))
(set-register-contents! count-leaves-machine 't t)
(start count-leaves-machine)
(get-register-contents count-leaves-machine 'res)


(define count-leaves-machine
  (make-machine
    '(t continue res tmp)
    (list (list 'null? null?)
          (list 'pair? pair?)
          (list 'car car)
          (list 'cdr cdr)
          (list 'not not)
          (list '+ +))
    '((assign continue (label done))
      (assign res (const 0))
      loop
      ; test for null tree return 0
      (test (op null?) (reg t))
      (branch (label base-1))
      ; test for not pair return 1
      (assign tmp (op pair?) (reg t))
      (test (op not) (reg tmp))
      (branch (label base-2))

      ; recurse
      (save continue)
      (save t)
      (assign t (op cdr) (reg t))
      (assign continue (label rec-1))
      (goto (label loop))

      rec-1
      (restore t)
      (restore continue)
      (assign t (op car) (reg t))
      (goto (label loop))

      base-1
      (goto (reg continue))

      base-2
      (assign res (op +) (reg res) (const 1))
      (goto (reg continue))
      done)))

(define t '((1 . (2 . 3))))
(set-register-contents! count-leaves-machine 't t)
(start count-leaves-machine)
(get-register-contents count-leaves-machine 'res)

