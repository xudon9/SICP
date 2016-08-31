;;; 17-count-pairs.scm

(define (count-pairs x)
  (define (inner x memo-list)
    (if (and (pair? x)
             (false? (memq x memo-list)))
      (inner (car x)
             (inner (cdr x) (cons x memo-list)))
      memo-list))
  (length (inner x '())))

(define (take n xs)
  (let loop ((n n) (xs xs) (zs (list)))
   (if (or (zero? n) (null? xs))
     (reverse zs)
     (loop (- n 1) (cdr xs)
           (cons (car xs) zs)))))
