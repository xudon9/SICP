(load "huffman.scm")

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge pairs)
  (if (<= (length pairs) 1)
    (car pairs) ;; 如果 pairs 为空表则崩溃（但是这不可能……）
    (let ((first (car pairs))
          (second (cadr pairs))
          (rest (cddr pairs)))
      (successive-merge (adjoin-set (make-code-tree first second) rest)))))
