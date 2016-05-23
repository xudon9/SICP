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
      (let* ((l-branch (left-branch tree))
             (r-branch (right-branch tree))
             (l-symbols (symbols l-branch))
             (r-symbols (symbols r-branch)))
       (cond ((member symbol l-symbols)
              (cons 0 (encode-symbol symbol l-branch)))
             ((member symbol r-symbols)
              (cons 1 (encode-symbol symbol r-branch)))
             (else (error "This is not included in set" symbol))))))


;;(display sample-message)
;;(newline)
;;(display (encode (decode sample-message sample-tree) sample-tree))
