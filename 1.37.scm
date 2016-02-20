(define (cont-frac n d k)
  (define (frac-iter input i)
    (if (> i k)
      input
      (frac-iter (/ n (+ d input))
                 (+ i 1))))
  (frac-iter 0.0 1))

;;(define (cont-frac n d k)
;;  (if (<= k 0)
;;    .0
;;    (/ n (+ d (cont-frac n d (- k 1))))))
