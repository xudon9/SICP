(load "2.69.scm")
(load "2.68.scm")

(define lrc-tree (generate-huffman-tree
                   '((A 1) (GET 2) (SHA 3) (WAH 1)
                           (BOOM 1) (JOB 2) (NA 16) (YIP 9))))

(define lyric '(Get a job
                    Sha na na na na na na na na
                    Get a job
                    Sha na na na na na na na na
                    Wah yip yip yip yip yip yip yip yip yip
                    Sha boom))

(define code (encode lyric lrc-tree))

(display (decode code lrc-tree))
(length code)
