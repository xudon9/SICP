(load "prime.scm")

(define (filtered-accumulate combiner null-val term a next b predicate)
  (define (filter-iter acc n)
    (if (> n b)
      acc
      (if (predicate (term n))
        (filter-iter (combiner acc (term n))
                     (next n))
        (filter-iter acc (next n)))))
  (filter-iter null-val a))

(define (prime-sum a b)
  (filtered-accumulate (lambda (x y) (+ x y))
                       0
                       (lambda (x) x)
                       a
                       (lambda (x) (+ x 1))
                       b
                       prime?))
