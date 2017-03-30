;; This is the function given by Louis Reasoner.
(define (sqrt-stream x)
  (cons-stream 1.0
               (stream-map (lambda (guess)
                             (sqrt-improve guess x))
                           (sqrt-stream x))))
;; It is less effitient even `delay' is implemented with `memo'.
;; Since it invoked a new function call...
