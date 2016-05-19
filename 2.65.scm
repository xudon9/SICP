(load "2.63.scm")
(load "2.64.scm")

;; List should be in descending order.
(define (union-ordered-list s1 s2)
  (cond ((null? s1) s2)
        ((null? s2) s1)
        (else (let ((h1 (car s1)) (t1 (cdr s1))
                                  (h2 (car s2)) (t2 (cdr s2)))
                (cond ((< h1 h2) (cons h1 (union-ordered-list t1 s2)))
                      ((= h1 h2) (cons h1 (union-ordered-list t1 t2)))
                      ((> h1 h2) (cons h2 (union-ordered-list s1 t2))))))))

(define (intersection-ordered-list set1 set2)
  (if (or (null? set1) (null? set2))
    '()
    (let ((x1 (car set1)) (x2 (car set2)))
     (cond ((= x1 x2)
            (cons x1 (intersection-ordered-list (cdr set1) (cdr set2))))
           ((< x1 x2)
            (intersection-ordered-list (cdr set1) set2))
           ((> x1 x2)
            (intersection-ordered-list set1 (cdr set2)))))))

(define tree->list tree->list-1)

(define (union-set tree-a tree-b)
  (let ((list-a (tree->list tree-a))
        (list-b (tree->list tree-b)))
    (list->tree (union-ordered-list list-a list-b))))

(define (intersection-set tree-a tree-b)
  (let ((list-a (tree->list tree-a))
        (list-b (tree->list tree-b)))
    (list->tree (intersection-ordered-list list-a list-b))))

