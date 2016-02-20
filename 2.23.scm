(define (forEach proc items)
  (if (null? items)
    true
    (let ((tmp (proc (car items)))
          (tail (cdr items)))
      (forEach proc tail))))
