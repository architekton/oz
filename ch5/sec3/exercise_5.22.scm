(load "../regsim.scm")

; (define (append l1 l2)
;   (if (null? l1)
;       l2
;       (cons (car l1) (append (cdr l1) l2))))
;
; (append (list 1 2 3) (list 4 5 6))
;


(define append-machine
  (make-machine
    '(continue l1 l2)
    (list (list 'null? null?)
          (list 'car car)
          (list 'cdr cdr)
          (list 'cons cons))
    '((assign continue (label done))
      loop
      ; test for null list
      (test (op null?) (reg l1))
      (branch (label base-1))

      ; recurse
      (save continue)
      (save l1)
      (assign continue (label rec-1))
      (assign l1 (op cdr) (reg l1))
      (goto (label loop))

      rec-1
      (restore l1)
      (restore continue)
      (assign l1 (op car) (reg l1))
      (assign l2 (op cons) (reg l1) (reg l2))
      (goto (reg continue))

      base-1
      (goto (reg continue))

      done)))

(define l1 (list 1 2 3))
(define l2 (list 4 5 6))
(set-register-contents! append-machine 'l1 l1)
(set-register-contents! append-machine 'l2 l2)
(start append-machine)
(get-register-contents append-machine 'l2)

; (define (append! l1 l2)
;   (if (null? (cdr l1))
;       (set-cdr! l1 l2)
;       (append! (cdr l1) l2)))
;
; (define l1 (list 1 2 3))
; (define l2 (list 4 5 6))
;
; (append! l1 l2)
; l1

(define append!-machine
  (make-machine
    '(continue l1 l2 tmp)
    (list (list 'null? null?)
          (list 'cdr cdr)
          (list 'set-cdr! set-cdr!))
    '((assign continue (label done))
      loop
      ; test for cdr null
      (assign tmp (op cdr) (reg l1))
      (test (op null?) (reg tmp))
      (branch (label base-1))

      ; rec
      (save continue)
      (save l1)
      (assign l1 (op cdr) (reg l1))
      (assign continue (label rec-1))
      (goto (label loop))

      rec-1
      (restore l1)
      (restore continue)
      (goto (reg continue))

      base-1
      (perform (op set-cdr!) (reg l1) (reg l2))
      (goto (reg continue))

      done)))

(define l1 (list 1 2 3))
(define l2 (list 4 5 6))
(set-register-contents! append!-machine 'l1 l1)
(set-register-contents! append!-machine 'l2 l2)
(start append!-machine)
(get-register-contents append!-machine 'l1)

