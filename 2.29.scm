(define (make-mobile left right)
  (list left right))

;; @structure is either weight or mobile
(define (make-branch len structure)
  (list len structure))

;; (a)
(define left-branch car)
(define right-branch cadr)
(define branch-length car)
(define branch-structure cadr)

;; (b)
(define (branch-weight branch)
  (let ((structure (branch-structure branch)))
   (if (pair? structure)
     (total-weight structure)
     structure)))

(define (total-weight mobile)
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))

;; (c)
(define (branch-balanced? branch)
  (let ((structure (branch-structure branch)))
   (if (pair? structure)
     (balanced? structure)
     true)))

(define (balanced? mobile)
  (let ((l (left-branch mobile))
        (r (right-branch mobile)))
  (and (branch-balanced? l)
       (branch-balanced? r)
       (= (* (branch-length l) (branch-weight l))
          (* (branch-length r) (branch-weight r))))))
;; (d)
;; That's easy

;; Test code
(define object
  (make-mobile (make-branch 0.5 22.0)
               (make-branch 1
                            (make-mobile (make-branch 6 5)
                                         (make-branch 5 6)))))
(total-weight object)
(balanced? object)
