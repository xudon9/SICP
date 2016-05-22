(load "huffman.scm")
(load "2.67.scm")

(define (encode message tree)
  (if (null? message)
    '()
    (append (encode-symbol (car message) tree)
            (encode (cdr message) tree))))

(define (encode-symbol symbol tree)
  (if (leaf? tree)
      '()
      ;; TODO 为什么不能先用 let 把左右分支算出？？
      (cond ((member symbol (symbols (left-branch tree)))
             (cons 0 (encode-symbol symbol (left-branch tree))))
            ((member symbol (symbols (right-branch tree)))
             (cons 1 (encode-symbol symbol (right-branch tree))))
            (else (error "This is not included in set" symbol)))))

;;(display sample-message)
;;(newline)
;;(display (encode (decode sample-message sample-tree) sample-tree))
