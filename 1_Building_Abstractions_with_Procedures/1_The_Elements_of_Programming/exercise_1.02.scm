; Transform: 
; (5 + 4 + (2 - (3 - (6 + 4/5))) / 3(6 - 2)(2 - 7))
; into prefix notation.
;
; (74 / 5) / (-60) = -37 / 150
;

(/ (+ 5 4
	  (- 2
		 (- 3
			(+ 6
			   (/ 4 5)))))
   (* 3
	  (- 6 2)
	  (- 2 7)))
