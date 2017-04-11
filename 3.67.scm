(load "stream-process.scm")

; I didn't quite get it, though. :-(
(define (pairs s t)
  (define (top ts tt)
    (cons-stream
      (list (stream-car ts) (stream-car tt))
      (interleave
        (stream-map (lambda (x) (list (stream-car ts) x))
                    (stream-cdr tt))
        (pairs (stream-cdr ts) (stream-cdr tt)))))

  (define (below bs bt)
    (cons-stream
      (list (stream-car bs) (stream-car bt))
      (interleave
        (stream-map (lambda (x) (list (stream-car bt) x))
                    (stream-cdr bs))
        (pairs (stream-cdr bs) (stream-cdr bt)))))
  (interleave (top s t)
              (below (stream-cdr s) t)))
