(define (my-reverse items)
  (define (reverse-iter dest src)
    (if (null? src)
      dest
      (reverse-iter (cons (car src) dest)
                    (cdr src))))
  (reverse-iter '() items))

(my-reverse (list 1 2 3 4))
(my-reverse '())
