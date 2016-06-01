(load "arithmetic.scm")

(install-complex-package)
(install-polar-package)
(install-rational-package)
(install-rectangular-package)
(install-scheme-number-package)

(define (equ? x y)
    (apply-generic 'equ? x y))

(put 'equ? '(scheme-number scheme-number)
     (lambda (x y) (= x y)))
 (define (make-scheme-number n)
     ((get 'make 'scheme-number) n))

(put 'equ? '(rational rational)
     (lambda (x y)
       (and (= (number x) (number y))
            (= (denom x) (denom y)))))
(define number car) (define denom cdr)
(define (make-rat x y)
  ((get 'make 'rational) x y))

;;复数略
