(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
      result
      (iter (next a) (+ (term a) result))))
  (iter a 0))

(define (simpson-integral f a b n)
  ;; auxiliary constant and fuction
  (define h (/ (- b a) n))
  (define (y k) (f (+ a (* k h))))
  (define (term n)
    (+ (* 4 (y n))
       (* 2 (y (+ n 1)))))
  ;; Main method
  (* (/ h 3)
     (+ (y 0)
        (sum term 1 (lambda (x) (+ 2 x)) (- n 1))
        (y n))))
