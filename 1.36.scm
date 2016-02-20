(load "search.scm")
(fixed-point (lambda (x) (/ (log 1000) (log x))) 2)
