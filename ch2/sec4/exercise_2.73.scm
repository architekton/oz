(define (variable? x) (symbol? x))
(define (=number? expr num) (and (number? expr) (= expr num)))
(define (same-variable? v1 v2) (and (variable? v1) (variable? v2) (eq? v1 v2)))

; a) there is no further breakdown of the data

; b) c)
(define (install-differentiation-package)
  ; internal procedures

  ; Constructors
  (define (make-sum a1 a2)
    (cond ((=number? a1 0) a2)
          ((=number? a2 0) a1)
          ((and (number? a1) (number? a2)) (+ a1 a2))
          (else (list '+ a1 a2))))

  (define (make-product m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
          ((=number? m1 1) m2)
          ((=number? m2 1) m1)
          ((and (number? m1) (number? m2)) (* m1 m2))
          (else (list '* m1 m2))))

  (define (make-expronentiation b e)
    (cond ((=number? e 0) 1)
          ((=number? e 1) b)
          ((=number? b 1) 1)
          ((and (number? b) (number? e)) (exp b e))
          (else (list '** b e))))

  ; Selectors
  (define (addend s) (cadr s))
  (define (augend s) (caddr s))

  (define (multiplier p) (cadr p))
  (define (multiplicand p) (caddr p))

  (define (base e) (cadr e))
  (define (expronent e) (caddr e))

  ; deriv
  (define (sum-deriv)
    (make-sum (deriv (addend expr) var)
              (deriv (augend expr) var)))
  (define (prod-deriv)
    (make-sum
      (make-product (multiplier expr)
                    (deriv (multiplicand expr) var))
      (make-product (deriv (multiplier expr) var)
                    (multiplicand expr))))

  (define (expr-deriv)
    (make-product
      (make-product
        (expronent expr)
        (make-expronentiation (base expr) (make-sum (expronent expr) -1)))
      (deriv (base expr) var)))

  ; interface to the rest of the system

  (put 'deriv '+ sum-deriv)
  (put 'deriv '* sum-deriv)
  (put 'deriv '** sum-deriv))

(define (deriv expr var)
  (cond ((number? expr) 0)
        ((variable? expr) (if (same-variable? expr var) 1 0))
        (else ((get 'deriv (operator expr)) (operands expr)
                                            var))))

(define (operator expr) (car expr))
(define (operands expr) (cdr expr))


(install-differentiation-package)

; d)
; Change the order of arguments in the put statement to be consistent with the
; ones in the get statement

; TODO come back to this when I do tables in chapter 3 and test
