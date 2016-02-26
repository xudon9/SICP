(load "2.33.scm")
(load "prime.scm")

(define (enumerate-interval low high)
  (if (> low high)
    nil
    (cons low (enumerate-interval (+ low 1) high))))

;; proc 把 seq 里的元素映射成列表，然后连接这些列表
(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
  (let ((fst (car pair))
        (snd (cadr pair)))
    (list fst snd (+ fst snd))))

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum? (flatmap (lambda (i)
                                     (map (lambda (j) (list i j))
                                          (enumerate-interval 1 (- i 1))))
                                   (enumerate-interval 1 n)))))

;;(prime-sum-pairs 10)
