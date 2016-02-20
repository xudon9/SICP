
(define (product term a next b)
  (define (iter a result)
    (if (> a b)
      result
      (iter (next a) (* (term a) result))))
  (iter a 1.0))

(define (calc-pi n)
  (define last-even (* 2 (floor (/ n 2))))
  (define last-odd (- last-even 1))
  (define (term n)
    (square (/ (+ n 1) n)))
  (define (next n) (+ 2 n))
  ;; Main
  (* 4
     (/ 2 last-even)
     (product term 3 next last-odd))
)
