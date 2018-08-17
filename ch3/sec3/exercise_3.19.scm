; The idea here is to use two pointers, one iterates through the list one at a
; time, the other 2 nodes at a time. If the list contains a cycle they will
; meet. If it doesnt the one moving faster will reach the end before the slower
; one.
;
; Intuition:
; They are moving at relative speeds. The speed of the second node relative to
; the first node is +1. See this by subtracting 1 from the speed of both
; nodes. The slow node is actually stationary, hence, if there is a cycle they
; will meet.

(define (has-cycle? x)
    (define (iter s f)
      ; Only need to check fast reaches end first
      (cond ((null? f) #f)
            ((eq? s f) #t)
            (else (iter (cdr s) (cddr f)))))

    (iter (cdr x) (cddr x)))

; Taken from exercise 3.16
(define cycle (list 'a 'b 'c))
; Set the null terminating element to point to the begining of the list or any
; element for that matter, we could set the first link to point back to itself.
(set-cdr! (cddr cycle) cycle)

(has-cycle? cycle)


