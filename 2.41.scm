(load "2.40.scm")

(define (unique-triples n)
  (flatmap (lambda (i)
             (map (lambda (p) (cons i p))
                  (unique-pairs (- i 1))))
           (enumerate-interval 3 n)))

;;(unique-triples 5)
