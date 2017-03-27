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

;; 成功了
;; </del>下面这两个还是有点问题。。</del>
(define cosine-series
  (cons-stream 1 (scale-stream (integrate-series sine-series) -1)))

(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))
