(load "stream-process.scm")

(define (ln-2-summands n)
  (cons-stream (/ 1.0 n)
               (stream-map - (ln-2-summands (+ n 1)))))

(define ln-2-stream (partial-sums (ln-2-summands 1)))

(define acc-ln-2 (accelerated-sequence euler-transform ln-2-stream))
