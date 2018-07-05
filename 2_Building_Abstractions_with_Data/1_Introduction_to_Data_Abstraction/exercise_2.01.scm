(define numer car)
(define denom cdr)

(define (gcd a b)
  (if (= b 0)
	  a
	  (gcd b (remainder a b))))

(define (make-rat n d)
  (let ((g (abs (gcd n d))))
	(cons ((if (< (* n d) 0) - +) (abs (/ n g))) (abs (/ d g)))))


(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

(print-rat (make-rat 6 9))
(print-rat (make-rat -6 9))
(print-rat (make-rat 6 -9))
(print-rat (make-rat -6 -9))

