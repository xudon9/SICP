(load "tree-set.scm")
(load "2.64.scm")

(define (display-tree tree)
  (define (display-node prefix node)
    (if (null? node)
      "(nil)\n"
      (let ((left  (left-branch  node))
            (right (right-branch node))
            (num   (entry        node)))
        (if (and (null? left) (null? right))
          (string-append (number->string num) "\n")
          (string-append (number->string num)
                         "\n"
                         prefix
                         "|--- "
                         (display-node (string-append prefix "|    ") left)
                         prefix
                         "\\--- "
                         (display-node (string-append prefix "     ") right)
                         )
          )
        )
      )
    )
  (display (display-node "" tree))
  )
