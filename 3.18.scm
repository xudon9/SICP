;;; 18-loop.scm

;; (define (loop? lst)
;;   (let ((identity (cons '() '())))
;;    (define (iter remain-list)
;;      (cond ((null? remain-list)
;;             #f)
;;            ((eq? identity (car remain-list))
;;             #t)
;;            (else
;;              (set-car! remain-list identity)
;;              (iter (cdr remain-list)))))
;;    (iter lst)))

(define (loop? ls)
  (let ((mem '()))
   (define (iter xs)
     (cond ((null? xs) #f)
           ((memq (car xs) mem) #t)
           (else (set! mem (cons (car xs) mem))
                 (iter (cdr xs)))))
   (iter ls)))


(define (take n xs)
  (let loop ((n n) (xs xs) (zs (list)))
   (if (or (zero? n) (null? xs))
     (reverse zs)
     (loop (- n 1) (cdr xs)
           (cons (car xs) zs)))))

(define cycle '(0 1 2 3 4 5 6 7 8 9))
(set-cdr! (last-pair cycle) (cdddr cycle))
