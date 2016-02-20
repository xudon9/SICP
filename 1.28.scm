;; 费马小定理: 若 n 为质数, 则对任意 a < n, 有 a^n % n == a
;;
;; Miller-Rabin 测试：若 n 为质数, 则对任意 a < n, 有 a^(n01) % n == 1
(define (square x) (* x x))

;; 求 base^n mod m

;; 挑选一个小于 n 的随机数进行费马测试 (检验是否为质数)
(define (fermat-test n)
  ;;
  (define (expmod base n m)
    (cond ((= n 0) 1)
          (and (= n))
          ((even? n)
           (remainder
             (square (expmod base (/ n 2) m))
             m))
          (else
            (remainder
              (* base (expmod base (- n 1) m))
              m)))
    ;;
    (define (try-it a)
      (= (expmod a (- n 1) n) 1))
    (try-it (+ (random (- n 1)) 1)))

;; 对整数 n 进行 times 次费马测试
(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

;; 求最小因数
(define (smallest-divisor n)
  (find-divisor n 2))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n) (fast-prime? n 1000))

(define (start-prime-test n start-time)
  (if (prime? n)
    (report-prime (- (runtime) start-time))))

(define (time-prime-test n)
  (start-prime-test n (runtime)))

(define (report-prime elapsed-time)
  (display " *** cost time: ")
  (display elapsed-time))

