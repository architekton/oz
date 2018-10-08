; (data-paths
;   (registers
;     ((name product)
;      (buttons
;        ((name product<-1) (source (constant 1)))
;        ((name product<-mult) (source (operation mult)))))
;     ((name count)
;      (buttons
;        ((name count<-1) (source (constant 1)))
;        ((name count<-add) (source (operation add)))))
;     ((name n)))
;   (operations
;     ((name mult) (inputs (register product) (register count)))
;     ((name add) (inputs (register count)))
;     ((name >) (inputs (register count) (register n)))))
;
;
; (controller
;   (assign product (constant 1))
;   (assign count (constant 1))
;   (test-b
;     (test (op >) (reg count) (reg n))
;     (branch (label fact-done))
;     (assign product (op mult) (reg count) (reg product))
;     (assign count (op add) (reg count) (constant 1))
;     (goto (label test-b)))
;   fact-done)
