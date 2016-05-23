(define (make-leaf symbol weight) (list 'leaf symbol weight))
(define (leaf? object) (eq? (car object) 'leaf))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

;; 合并左右子树
(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

;; 提取左右子树
(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))

;; 若给定叶节点，返回编码的字符
;; 若给定其他节点，返回其子树的字符列表
(define (symbols tree)
  (if (leaf? tree)
    (list (symbol-leaf tree))
    (caddr tree)))

;; 若给定叶节点，返回字符权重
;; 若给定其他节点，返回其子树的权重之和
(define (weight tree)
  (if (leaf? tree)
    (weight-leaf tree)
    (cadddr tree)))

;; 把 bits 按 tree 解码
(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
      '()
      (let ((next-branch
              (choose-branch (car bits) current-branch)))
        (if (leaf? next-branch)
          (cons (symbol-leaf next-branch) (decode-1 (cdr bits) tree))
          (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))

(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit: CHOOSE-BRANCH" bit))))

;; x 是树(包括单个叶节点)，set 是树(包括单个叶节点)按权升序排列的列表
;; 此函数把 x 插入到 set 的适当位置，保持按权升序排列的性质
(define (adjoin-set x set)
  (cond ((null? set)
         (list x))
        ((< (weight x) (weight (car set)))
         (cons x set))
        (else
          (cons (car set) (adjoin-set x (cdr set))))))

;; 把的表转换为按权升序排列的叶子
;; 例如: '((A 4) (B 8) (D 3) (E 1)) ~~>
;;          ((leaf e 1) (leaf d 3) (leaf a 4) (leaf b 8))
(define (make-leaf-set pairs)
  (if (null? pairs)
    '()
    (let ((pair (car pairs)))
     (adjoin-set (make-leaf (car pair)   ; symbol
                            (cadr pair)) ; frequency
                 (make-leaf-set (cdr pairs))))))
