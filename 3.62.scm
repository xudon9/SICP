(load "3.61.scm")

;; Both are okay.

 (define (div-series s1 s2)
   (let ((c (stream-car s2)))
     (if (zero? c)
         (error "DIV-SERIES -- s2inator constant term must be non-zero" )
         (mul-series s1
                     (scale-stream (invert-unit-series (scale-stream s2 (/ 1 c)))
                      (/ 1 c))))))
#|
(define (div-series s1 s2)
  (let ((c (stream-car s2)))
    (if (zero? c)
        (error "constant term of s2 can't be 0!")
        (scale-stream (mul-series s1 (invert-unit-series (scale-stream s2 (/ 1 c))))
                      (/ 1 c)))))
|#

(define tan-series (div-series sine-series cosine-series))
