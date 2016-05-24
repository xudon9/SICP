(load "deriv.scm")
;; 给数据加标签
(define (attach-tag type-tag x y)
    (list type-tag x y))
(define (type-tag datum)
  (if (pair? datum) (car datum)
    (error "Bad tagged datum: TYPE-TAG" datum)))
(define (contents datum)
  (if (pair? datum)
    (cdr datum)
    (error "Bad tagged datum: CONTENTS" datum)))

;; Operation table
(define *op-table* (make-hash-table))
(define (put op type proc)
  (hash-table/put! *op-table* (list op type) proc))
(define (get op type)
  (hash-table/get *op-table* (list op type) #f))

;; Definiation of `deriv`
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get 'deriv (operator exp)) (operands exp) var))))
(define operator car)
(define operands cdr)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (install-sum-package)
  ;;; internal procedures
  (define (addend s) (car s))
  (define (augend s) (cadr s))

  (define (make-sum x y)
    (cond ((=number? x 0) y)
          ((=number? y 0) x)
          ((and (number? x) (number? y)) (+ x y))
          (else (attach-tag '+ x y))))
  ;;; interface to the rest of the system
  (put 'addend '+ addend)
  (put 'augend '+ augend)
  (put 'make-sum '+ make-sum)

  (put 'deriv '+
       (lambda (exp var)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var))))
'done)


(define (make-sum x y)
    ((get 'make-sum '+) x y))
(define (addend sum)
    ((get 'addend '+) (contents sum)))
(define (augend sum)
    ((get 'augend '+) (contents sum)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (install-product-package)
  ;;; internal procedures
  (define (multiplier p) (car p))
  (define (multiplicand p) (cadr p))

  (define (make-product x y)
    (cond ((or (=number? x 0) (=number? y 0)) 0)
          ((=number? x 1) y)
          ((=number? y 1) x)
          ((and (number? x) (number? y)) (* x y))
          (else (attach-tag '* x y))))
  ;;; interface to the rest of the system
  (put 'multiplier '* multiplier)
  (put 'multiplicand '* multiplicand)
  (put 'make-product '* make-product)

  (put 'deriv '*
       (lambda (exp var)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (deriv (multiplier exp) var)
                         (multiplicand exp)))))

  'done)

(define (make-product x y)
    ((get 'make-product '*) x y))
(define (multiplier product)
    ((get 'multiplier '*) (contents product)))
(define (multiplicand product)
    ((get 'multiplicand '*) (contents product)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (install-exp-package)
  ;;; internal procedures
  (define base car)
  (define exponent cadr)

  (define (make-exp base n)
    (cond ((=number? base 0) 0)
          ((=number? n 0) 1)
          ((=number? n 1) base)
          (else (attach-tag '** base n))))
  ;;; interface to the rest of the system
  (put 'base '** base)
  (put 'exponent '** exponent)
  (put 'make-exp '** make-exp)
  (put 'deriv '**
       (lambda (exp var)
         (let ((n (exponent exp))
               (u (base exp)))
           (make-product
             (make-product
               n
               (deriv u var))
             (make-exp u (- n 1))))))
  'done)

(define (make-exponentiation base n)
    ((get 'make-exponentiation '**) base n))
(define (base exp)
    ((get 'base '**) (contents exp)))
(define (exponent exp)
    ((get 'exponent '**) (contents exp)))

;;(install-sum-package)
;;(install-product-package)
;;(install-exp-package)

;;(deriv '(** x 9) 'x)
