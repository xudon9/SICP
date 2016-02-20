(load "1.43.scm")

(define dx 0.01)

(define (smooth func)
  (lambda (x)
    (/ (+ (func (- x dx))
          (func x)
          (func (+ x dx)))
       3
       )
    )
  )

(define (n-fold-smooth func n)
  ((repeated smooth n) func)
  )

((n-fold-smooth sin 30) 2)
