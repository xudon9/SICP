(load "inf-stream.scm")
(load "3.55.scm")

;; (define (stream-map proc s)
;;   (if (stream-null? s)
;;       the-empty-stream
;;       (cons-stream (proc (stream-car s))
;;                    (stream-map proc (stream-cdr s)))))


(define (sqrt-improve guess x)
  (average guess (/ x guess)))

(define (pi-summands n)
  (cons-stream
   (/ 1.0 n)
   (stream-map - (pi-summands (+ n 2)))))

(define pi-stream
  (scale-stream
   (partial-sums (pi-summands 1)) 4))

(define (euler-transform s)
  (let ((s0 (stream-ref s 0))    ; Sₙ₋₁
        (s1 (stream-ref s 1))    ; Sₙ
        (s2 (stream-ref s 2))    ; Sₙ₊₁
        (square (lambda (x) (* x x))))
    (cons-stream (- s2 (/ (square (- s2 s1))
                          (+ s0 (* -2 s1) s2)))
     (euler-transform (stream-cdr s)))))

(define (make-tableau transform s)
  (cons-stream s (make-tableau transform (transform s))))

(define (accelerated-sequence transform s)
  (stream-map stream-car (make-tableau transform s)))
