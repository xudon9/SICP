(define (make-monitored func)
  (let ((times 0))
   (lambda (param)
     (if (eqv? param 'how-many-calls?)
       times
       (begin (set! times (+ 1 times))
                (func param))))))
