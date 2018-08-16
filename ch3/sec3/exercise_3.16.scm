(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

(define three (list 'a 'b 'c))
three
(count-pairs three)

(define a (cons 'a 'b)) ; 1
(define b (cons 'c 'd)) ; 1
(set-car! a b)
a ; now 2
(define four (cons a b)) ; 4
four
(count-pairs four)

(define a (list 'a))
(define b (cons a a))
(define seven (cons b b))
seven
(count-pairs seven)

(define cycle (list 'a 'b 'c))
; Set the null terminating element to point to the begining of the list or any
; element for that matter, we could set the first link to point back to itself.
(set-cdr! (cddr cycle) cycle)
(count-pairs cycle)

; Diagrams
; 3
;          .---.---.       .---.---.      .---.---.
; three--->| * | * |------>| * | * |----->| * | / |
;          '---'---'       '---'---'      '---'---'
;            |               |              |
;            |               |              |
;            v               v              v
;          .---.           .---.          .---.
;          | a |           | b |          | c |
;          '---'           '---'          '---'
; 4
; There are easier diagrams than the following
;
;              1               1
;          .---.---.       .---.---.
; four---->| * | * |------>| * | * |
;          '---'---'       '---'---'
;            |               |   |
;            |               |   |  .---.
;            |               |   '->| b |
;            |           2   v      '---'
;            |             .---.---.
;            '------------>| * | * |
;                          '---'---'
;                            |   |
;                            |   |
;                            |   |
;                      .---. |   |  .---.
;                      | c |<'   '->| d |
;                      '---'        '---'
;
; 7
;           .---.---.
; seven---->| * | * |   2 * (2 * 1 + 1) + 1 = 7
;           '---'---'
;             |   |
;             |   |
;             v   v
;           .---.---.
;           | * | * |  2 * 1 + 1 = 3
;           '---'---'
;             |   |
;             |   |
;             v   v
;           .---.---.
;           | * | / |  1
;           '---'---'
;             |
;             |
;             v
;           .---.
;           | a |
;           '---'
; cycle
;
;            .---------------------------------.
;            |                                 |
;            v                                 |
;          .---.---.      .---.---.      .---.---.
; cycle--->| * | * |----->| * | * |----->| * | / |
;          '---'---'      '---'---'      '---'---'
;            |              |              |
;            |              |              |
;            v              v              v
;          .---.          .---.          .---.
;          | a |          | b |          | c |
;          '---'          '---'          '---'

