; (define (sqrt x)
;   (define (good-enough? guess)
;     (< (abs (- (square guess) x)) 0.001))
;   (define (improve guess)
;     (average guess (/ x guess)))
;   (define (sqrt-iter guess)
;     (if (good-enough? guess)
;         guess
;         (sqrt-iter (improve guess))))
;   (sqrt-iter 1.0))

; assuming both exist as primitives
(controller
  (assign x (op read))
  (assign guess (const 1.0))

  test-a
  (test (op good-enough?) (reg guess) (reg x))
  (branch (label done))
  (assign t (op improve) (reg guess) (reg x))
  (assign guess (reg t))
  (goto test-a)
  done

  (perform (op print) (reg guess)))

; expanding improve
(controller
  (assign x (op read))
  (assign guess (const 1.0))

  test-a
  (test (op good-enough?) (reg guess) (reg x))
  (branch (label done))
  (assign d (op /) (reg x) (reg guess))
  (assign avg (op average) (reg guess) (reg d))
  (assign guess (reg avg))
  (goto test-a)
  done

  (perform (op print) (reg guess)))

; expanding good-enough?
(controller
  (assign x (op read))
  (assign guess (const 1.0))

  test-a
  (assign sq (op *) (reg guess) (reg guess))
  (assign diff (op -) (reg sq) (reg x))
  (assign ab (op abs) (reg diff))

  (test (op <) (reg ab) (const 0.001))
  (branch (label done))
  (assign d (op /) (reg x) (reg guess))
  (assign avg (op average) (reg guess) (reg d))
  (assign guess (reg avg))
  (goto test-a)
  done

  (perform (op print) (reg guess)))

; expand the rest
(controller
  (assign x (op read))
  (assign guess (const 1.0))

  test-a
  (assign sq (op *) (reg guess) (reg guess))
  (assign diff (op -) (reg sq) (reg x))
  (test (op <) (reg diff) (const 0))
  (branch test-neg)
  (assign ab (reg diff))
  (goto skip-neg)
  test-neg
  (assign ab (op *) (reg diff) (const -1))
  skip-neg

  (test (op <) (reg ab) (const 0.001))
  (branch (label done))
  (assign d (op /) (reg x) (reg guess))
  (assign s (op +) (reg d) (reg guess))
  (assign avg (op /) (reg s) (const 2))
  (assign guess (reg avg))
  (goto test-a)
  done

  (perform (op print) (reg guess)))
