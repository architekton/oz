; Normal version

; (define (queens board-size)
;   (define (queen-cols k)
;   (if (= k 0)
;       (list empty-board)
;       (filter
;         (lambda (positions) (safe? k positions))
;         (flatmap
;           (lambda (rest-of-queens)
;             (map (lambda (new-row)
;                    (adjoin-position new-row k rest-of-queens))
;                  (enumerate-interval 1 board-size)))
;           (queen-cols (- k 1))))))
;   (queen-cols board-size))

; Louis's version

; (define (queens board-size)
;   (define (queen-cols k)  
;   (if (= k 0)
;       (list empty-board)
;       (filter
;         (lambda (positions) (safe? k positions))
;         (flatmap
;           (lambda (new-row)
;             (map (lambda (rest-of-queens)
;                    (adjoin-position new-row k rest-of-queens))
;                  (queen-cols (- k 1))))
;           (enumerate-interval 1 board-size)))))
;   (queen-cols board-size))

; TODO
