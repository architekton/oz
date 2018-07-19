(define (expmod base exp m)
  (cond ((= exp 0) 1)
		((even? exp)
		 (remainder (square (expmod base (/ exp 2) m))
					m))
		(else
		  (remainder (* base (expmod base (- exp 1) m))
					 m))))        

(define (carmichael-test n)
  (define (try-it a)
	(if (< a n)
		(if (= (expmod a n n) a)
			(try-it (+ a 1))
			#f)
		#t))

  (try-it 1))

(carmichael-test 17)
; #t

(carmichael-test 21)
; #f

; Taken from the footnote in the book, Carmichael numbers
(carmichael-test 561)
(carmichael-test 1105)
(carmichael-test 1729)
(carmichael-test 2465)
(carmichael-test 2821)
(carmichael-test 6601)


