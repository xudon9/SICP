;;(define (accumulate combiner null-value term a next b)
;;  (if (> a b)
;;    null-value
;;    (combiner (accumulate combiner
;;                          null-value
;;                          term
;;                          (next a)
;;                          next
;;                          b)
;;              (term a))))

(define (accumulate combiner null-value term a next b)
  (define (acc-iter acc n)
    (if (> n b)
      acc
      (acc-iter (combiner acc (term n))
                (next n))))
  (acc-iter null-value a))

(define (next n) (+ 1 n))
(define (combiner x y) (* x y))
(define (id x) x)
