(define (cont-frac n d k)
  (define (frac-iter input i)
    (if (<= i 0)
      input
      (frac-iter (/ (n i) (+ (d i) input))
                 (- i 1))))
  (frac-iter 0.0 k))

(define (tan-cf x k)
  (/ (cont-frac (lambda (i) (-(sqr x)))
                (lambda (i) (- (* 2 i) 1))
                k)
     (- x)
     )
  )

(define v 3.1416)

(tan v)
(tan-cf v 10000)
