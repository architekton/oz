; Below are the diagrams for the following method designed as a register
; machine.
;
; (define (factorial n)
;   (define (iter product counter)
;     (if (> counter n)
;         product
;         (iter (* counter product)
;               (+ counter 1))))
;   (iter 1 1))

; Initialize product and counter to 1(didn't draw the initialisation). Also
; assume that the shape of the boxes are respectfully as described in the book.
; The arrow passing the add and mult line is a loopback arror, so assume that
; the arrows come back from the top. (to keep things neat)
;
;                                        .---.
;                                        | n |
;                                        '---'
;                                          |
;                                          v
;      .---------.       .---------.     .---.
;      | product | .-----| counter |---->| > |
;      '---------' |     '---------'     '---'
;           |      |          |
;           |      |          |
;           .------'          |
;           v                 v
;       .------.           .-----.
;       | mult |           | add |
;       '------'           '-----'
;           |                 |
; ----------|------------------------------>
;           |                 |
;           v                 v
;      .---------.       .---------.
;      | product |       | counter |
;      '---------'       '---------'
;
;



;         start
;           |
;           |
;           v
;    .------------.
;    | product<-1 |
;    '------------'
;           |
;           |
;           v
;    .------------.
;    | counter<-1 |
;    '------------'
;           |
;           |
;           v
;         .---.     no    .--------.
; .------>| > |---------->| addbtn |
; |       '---'           '--------'
; |         |                  |
; |         | yes              |
; |         v                  v
; |       done            .---------.
; '-----------------------| multbtn |
;                         '---------'
;
;
