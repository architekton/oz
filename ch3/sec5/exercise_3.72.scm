(load "streams.scm")

(define (merge s1 s2 weight)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
          (let ((s1car (stream-car s1))
                (s2car (stream-car s2)))
            (cond ((< (weight s1car) (weight s2car))
                   (cons-stream s1car (merge (stream-cdr s1) s2 weight)))
                  ((> (weight s1car) (weight s2car))
                   (cons-stream s2car (merge s1 (stream-cdr s2) weight)))
                  (else
                    (cons-stream s1car
                                 (merge (stream-cdr s1)
                                        (stream-cdr s2)
                                        weight))))))))

(define (weighted-pairs s t weight)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (merge
      (stream-map (lambda (x) (list (stream-car s) x))
                  (stream-cdr t))
      (weighted-pairs (stream-cdr s) (stream-cdr t) weight) weight)))

(define (cube a)
  (* a a a))

(define (weight p)
  (+ (cube (car p)) (cube (cadr p))))

(define s (weighted-pairs integers integers weight))

(define (r-numbers s)
  (define (iter pprev prev s)
    (let ((curr (stream-car s)))
      (if (and (= (weight pprev) (weight pprev))
               (= (weight prev) (weight curr)))

          (cons-stream pprev (iter prev curr (stream-cdr s)))
          (iter prev curr (stream-cdr s)))))
  (iter (stream-car s) (stream-car (stream-cdr s)) (stream-cdr (stream-cdr s))))

(display-stream (r-numbers s))

; Todo fix the hang
