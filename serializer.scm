(define (make-serializer)
  (let ((mutex (make-mutex)))
    (lambda (p)
      (define (serialized-p . args)
	(mutex 'acquire)
	(let ((val (apply p args)))
	  (mutex 'release)
	  val))
      serialized-p)))

;;(define (make-mutex)
;;  (let ((cell (list false)))
;;    (define (the-mutex m)
;;      (cond ((eq? m 'acquire)
;;(if (test-and-set! cell)


		 
