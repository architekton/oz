(load "../syntax.scm")
(load "../compiler.scm")

; a)
(define (spread-arguments operands-list)
  (if (null? operands-list)
      (empty-instruction-sequence)
      (let ((second-seq (compile (cadr operands-list)
                                 'arg2
                                 'next))
            (first-seq (compile (car operands-list)
                                'arg1
                                'next)))
        (preserving
          '(env)
          second-seq
          (preserving '(arg2)
                      first-seq
                      (make-instruction-sequence
                        '(arg2)
                        '()
                        '()))))))

(spread-arguments (list 1 2))


; b)
; c)
; d)
