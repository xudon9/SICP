;; 牛顿法:
;; 若 g(x) 可导，则 g(x) = 0 的是以下函数 f 的 fixed-point:
;;          f(x) = x - g(x)/g'(x)
(load "search.scm")
(define dx 1e-5)

(define (deriv g)
  (lambda (x) (/ (- (g (+ x dx)) (g x)) dx)))

(define (newton-transform g)
  (lambda (x) (- x (/ (g x) ((deriv g) x)))))

(define (mein-sqrt x)
  (newtons-method
    (lambda (y) (- (sqr y) x)) 1.0))

(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

(sqrt 63)
(mein-sqrt 63)
