(load "arithmetic.scm")

(install-complex-package)
(install-polar-package)
(install-rational-package)
(install-rectangular-package)
(install-scheme-number-package)

(define (=zero? x)
  (apply-generic '=zero? x))

(put '=zero? '(scheme-number)
     (lambda (val) (= val 0)))
(define (make-scheme-number n)
  ((get 'make 'scheme-number) n))

(put '=zero? '(rational)
     (lambda (val)
       (= (number val) 0)))
(define number car) (define denom cdr)
(define (make-rat x y)
  ((get 'make 'rational) x y))

;;复数略
