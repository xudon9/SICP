(define nil '())

(define (/= x y) (not (= x y)))

(define (enumerate-interval low high)
  (if (> low high)
    nil
    (cons low (enumerate-interval (+ low 1) high))))

(define (++ x) (+ x 1))
(define (-- x) (- x 1))

;; proc 把 seq 里的元素映射成列表，然后连接这些列表
(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(define accumulate fold-right)
