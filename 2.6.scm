(define zero  (lambda (f) (lambda (x) x)))
(define one   (lambda (f) (lambda (x) (f x))))
(define two   (lambda (f) (lambda (x) (f (f x)))))
(define three (lambda (f) (lambda (x) (f (f (f x))))))

;; Increase by one
(define (inc n)
  (lambda (f)
    (lambda (x)
      (f ((n f) x)))))

;; Addition of Church numerals
(define (add n1 n2)
  (lambda (f)
    (lambda (x)
      ((n1 f) ((n2 f) x)))))

;; To human readable number
(define (to-digit n)
  ((n (lambda (x) (+ x 1))) 0))

