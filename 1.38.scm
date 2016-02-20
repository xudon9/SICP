(define (cont-frac n d k)
  (define (frac-iter input i)
    (if (<= i 0)
      input
      (frac-iter (/ (n i) (+ (d i) input))
                 (- i 1))))
  (frac-iter 0.0 k))

(define (euler-expand n)
  (define (d i)
    (if (= (remainder i 3) 2)
      (* 2 (ceiling (/ i 3)))
      1))
  (+ 2
     (cont-frac (lambda (i) 1.0)
                d
                n)))


(euler-expand 100)
(exp 1)
