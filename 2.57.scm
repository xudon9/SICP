(load "2.56.scm")

(define (augend s)
  (let ((tail (cddr s)))
   (if (pair? tail)
     (cons '+ tail)
     tail)))
(define (multiplicand p)
  (let ((tail (cddr p)))
   (if (pair? tail)
     (cons '* tail)
     tail)))

(define (augend s)
  (if (> (length s) 3)
    (cons '+ (cddr s))
    (cddr s)))
(define (multiplicand s)
  (if (> (length s) 3)
    (cons '* (cddr s))
    (cddr s)))



(deriv '(* x y (+ x 3)) 'x)
