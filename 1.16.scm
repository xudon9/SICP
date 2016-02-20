(define (square x) (* x x))

(define (fast-iter base n k)
    (if (even? n)
        (fast-iter (square base) (/ n 2) k)
        (if (= n 1)
            (* base k)
            (fast-iter (square base) (/ (- n 1) 2) (* base k)))))

(define (fast-expt base n) (fast-iter base n 1))
