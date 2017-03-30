(load "stream-process.scm")

(define (s-sqrt x tolerance)
  (stream-limit (sqrt-stream x) tolerance))

(define (stream-limit s epsilon)
  (let ((a (stream-ref s 0))
        (b (stream-ref s 1)))
    (if (< (abs (- a b)) epsilon)
      b
      (stream-limit (stream-cdr s) epsilon))))
