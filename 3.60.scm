(load "3.59.scm")

;;; 厉害了这个解法
(define (mul-series s1 s2)
  (cons-stream (* (stream-car s1)
                  (stream-car s2))
               (add-streams (scale-stream (stream-cdr s1)
                                          (stream-car s2))
                            (mul-series s1 (stream-cdr s2)))))

(define cos-square+sin-square
  (add-streams (mul-series cosine-series cosine-series)
               (mul-series sine-series sine-series)))
