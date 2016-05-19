(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right) (list entry left right))

(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((= x (entry set)) #t)
        ((< x (entry set))
         (element-of-set? x (left-branch set)))
        ((> x (entry set))
         (element-of-set? x (right-branch set)))))

;; 把 x 加到 set 中
(define (adjoin-set x set)
  (cond ((null? set) (make-tree x '() '()))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree (entry set)
                    (adjoin-set x (left-branch set))
                    (right-branch set)))
        ((> x (entry set))
         (make-tree (entry set) (left-branch set)
                    (adjoin-set x (right-branch set))))))

(define (list->tree xs)
  (fold-left (lambda (tree ele) (adjoin-set ele tree)) '() xs))

(define (display-tree tree)
  (define (node->string prefix node)
    (cond ((null? node) "(nil)\n")
          ((and (null? (left-branch node)) (null? (right-branch node)))
           (string-append (number->string (entry node)) "\n"))
          (else
            (string-append (number->string (entry node))
                           "\n"
                           prefix
                           "|-- "
                           (node->string (string-append prefix "|   ") (left-branch node))
                           prefix
                           "\\-- "
                           (node->string (string-append prefix "    ") (right-branch node))))))
  (display (node->string "" tree)))

(display-tree (list->tree (list 1)))
