(load "prelude.scm")

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
      (list empty-board)
      (filter (lambda (positions) (safe? k positions))
              (flatmap (lambda (rest-of-queens)
                         (map (lambda (new-row)
                                (adjoin-position new-row k rest-of-queens))
                              (enumerate-interval 1 board-size)))
                       (queen-cols (- k 1))))))
  (queen-cols board-size))

(define empty-board nil)

;; 检查第 k 列所放的位置和前面是否有冲突
(define (safe? k positions)
  ;; 检查目标: k 列 r 行
  ;; 迭代地检查剩余皇后(col列 row行)是否与目标冲突
  (define (check-each-position col pos-list k r)
    (if (null? pos-list)
      #t
      (let ((row (car pos-list)))
       (if (or (= (+ col row) (+ k r))
               (= (- col row) (- k r))
               (= row r))
         #f
         (check-each-position (- col 1) (cdr pos-list) k r)))))

  (check-each-position (- k 1) (cdr positions) k (car positions)))

(define (adjoin-position new-row new-col rest-of-queens)
  (cons new-row rest-of-queens))

(for-each (lambda (pos) (begin (display pos) (newline))) (queens 8))
