(define (square x) (* x x))


(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n ((lambda (n) (+ n (if (= n 2) 1 2)))
                               test-divisor))))
  )

;; 求最小因数
(define (smallest-divisor n)
  (find-divisor n 2))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n) (= (smallest-divisor n) n))

(define (start-prime-test n start-time)
  (if (prime? n)
    (report-prime (- (runtime) start-time))
    (report-prime (- start-time (runtime)))))

(define (time-prime-test n)
  (start-prime-test n (runtime)))

(define (report-prime elapsed-time)
  (display " *** cost time: ")
  (display elapsed-time)
  "Done!"
)
