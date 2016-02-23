(define nil '())
(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence) (accumulate op initial (cdr sequence)))))

(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y))
              nil
              sequence))

(define (count-leaves tree)
  (accumulate +
              0
              (map (lambda (t)
                     (if (pair? t)
                       (count-leaves t)
                       1))
                   tree)))

(count-leaves (list 2 3 (list 4 (list 14 9) 5) 1))
