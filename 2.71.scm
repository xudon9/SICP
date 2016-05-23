(load "huffman.scm")
(load "2.69.scm")
(load "2.68.scm")

(define code-tree (generate-huffman-tree '((A 1) (B 2) (C 4) (D 8) (E 16))))

(encode '(a) code-tree)
(encode '(b) code-tree)
(encode '(c) code-tree)
(encode '(d) code-tree)
(encode '(e) code-tree)
