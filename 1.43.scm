(load "1.42.scm")

(define (repeated f n)
  (if ( <= n 0 )
    (lambda (x) x)
    (compose f (repeated f (- n 1)))))
;;    (lambda (x) (f ((repeated f (- n 1)) x)))))

((repeated sqr 2) 5)
