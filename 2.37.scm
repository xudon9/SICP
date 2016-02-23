(load "2.36.scm")

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda (mi) (dot-product mi v)) m))

(define (transpose mat)
  (accumulate-n
    cons nil mat))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
   (map
     (lambda (m-i)
       (map (lambda (col-i) (dot-product m-i col-i)) cols))
     m)))

(define vec (list 1 2 2 3))
(define mat-1 (list (list 1 2 3 4)
                     (list 4 5 6 6)
                     (list 6 7 8 9)))
(define mat-2 (list (list 1 2)
                    (list 3 4)
                    (list 5 6)
                    (list 7 8)))
(matrix-*-matrix mat-1 mat-2)
