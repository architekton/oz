; (define (encode message tree)
;   (if (null? message)
;       '()
;       (append (encode-symbol (car message) tree)
;               (encode (cdr message) tree))))
;
; (define (encode-symbol symbol tree)
;   (cond ((leaf? tree)'())
;         ((element-of-set? symbol (symbols (right-branch tree)))
;          (cons 1 (encode-symbol symbol (right-branch tree))))
;         ((element-of-set? symbol (symbols (left-branch tree)))
;          (cons 0 (encode-symbol symbol (left-branch tree))))
;         (else
;           (error "Symbol not found -- ENCODE-SYMBOL"))))
;


; element-of-set through the symbols set takes O(n) time. If this is performed
; for every node in order to find the smallest element, the result is O(n^2)
