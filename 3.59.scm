(load "3.54.scm") ;; mul-streams

(define inverted-series (stream-map / ones integers))
(define tail-series
  (cons-stream 1
                (stream-map *
                            inverted-series
                            tail-series)))
(define exp-series
  (cons-stream 1 tail-series))

;; (a)
(define (integrate-series poly-stream)
  (stream-map *
              (stream-map / ones integers)
              poly-stream))


;; (b)
(define exp-series
  (cons-stream 1 (integrate-series exp-series)))

;; 下面这两个还是有点问题。。
(define cosine-series
  (cons-stream 1 (integrate-series sine-series)))

(define sine-series
  (cons 0 (scale-stream (integrate-series cosine-series)
                        -1)))
