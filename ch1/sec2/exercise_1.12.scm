(define (pascal r c) 
  (if (or (= c 1) (= c r)) 
      1 
      (+ (pascal (- r 1) (- c 1)) (pascal (- r 1) c)))) 

; Go down the middle of the triangle
(pascal 1 1) 
(pascal 3 2) 
(pascal 5 3) 
(pascal 7 4)
(pascal 9 5)
