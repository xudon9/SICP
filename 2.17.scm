(define (last-pair items)
  (let ((tail (cdr items)))
   (if (null? tail)
     items
     (last-pair tail))))

(define x (list 1 2 3 4))
(last-pair x)
