(define (find-variable variable ctenv)
  (define (iter-frames cnt ctenv)
    (if (null? ctenv)
        'not-found
        (let ((position (find-in-frame (car ctenv))))
          (if position
              (list cnt position)
              (iter-frames (+ cnt 1) (cdr ctenv))))))

  (define (find-in-frame frame)
    (define (iter cnt frame)
      (cond ((null? frame) #f)
            ((eq? (car frame) variable) cnt)
            (else (iter (+ cnt 1) (cdr frame)))))
    (iter 0 frame))

  (iter-frames 0 ctenv))

(find-variable 'c '((y z) (a b c d e) (x y)))
(find-variable 'x '((y z) (a b c d e) (x y)))
(find-variable 'w '((y z) (a b c d e) (x y)))
