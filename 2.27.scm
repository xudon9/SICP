(define nil '())

(define (deep-reverse items)
  (define (reverse-iter dest src)
    (cond ((null? src) dest)
          ((not (pair? src)) src)
          (else (reverse-iter (cons (deep-reverse (car src)) dest)
                              (cdr src)))))
  (reverse-iter '() items))

(deep-reverse (list 1 2 3 4))
(deep-reverse '())

