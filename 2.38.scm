(define nil '())
(define (fold-right op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (fold-right op initial (cdr sequence)))))

(define (map p sequence)
  (fold-right (lambda (x y)
                (cons (p x) y))
              nil
              sequence))

(define (append seq1 seq2)
  (fold-right cons seq2 seq1))

(define (length sequence)
  (fold-right (lambda (x y) (+ 1 y)) 0 sequence))
