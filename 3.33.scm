(load "constraint.scm")

;; Averager
(define (averager a b c)
  (let ((sum (make-connector))
        (d (make-connector)))
    (adder a b sum)
    (multiplier sum d c)
    (constant (/ 1 2) d)
    'ok))

;; Test code
;; (define a (make-connector))
;; (define b (make-connector))
;; (define c (make-connector))
;; (averager a b c)
;; (set-value! a 2 'user)
;; (set-value! b 4 'user)
;; (get-value c)

(define (test-averager)
  (begin
    (define a (make-connector))
    (define b (make-connector))
    (define c (make-connector))
    (averager a b c)
    (set-value! a 2 'user)
    (set-value! b 4 'user)
    (get-value c)))
