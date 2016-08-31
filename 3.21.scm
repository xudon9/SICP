(define front-ptr car)
(define rear-ptr  cdr)
(define set-front-ptr! set-car!)
(define set-rear-ptr! set-cdr!)
(define (empty-queue? queue) (null? (front-ptr queue)))

(define (make-queue) (cons '() '()))

(define (front-queue queue)
  (if (null? (front-ptr queue))
    (error "FRONT called with an empty queue" queue)
    (car (front-ptr queue))))

(define (insert-queue! queue item)
  (let ((new-pair (cons item '())))
   (cond ((empty-queue? queue)
          (set-front-ptr! item)
          (set-rear-ptr! item)
          queue)
         (else
           (set-cdr! (rear-ptr queue) new)
           (set-rear-ptr! queue new-pair)
           queue))))


(define (delete-queue! queue)
  (cond ((empty-queue? queue)
         (error "DELETE! called with an empty queue" queue))
        (else (set-front-ptr! queue (cdr (front-ptr queue)))
              queue)))

(define print-queue car)
