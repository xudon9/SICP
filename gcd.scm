(define (gcd a b)
  ;;  (display "Arg is: ")
  ;;  (display a)
  ;;  (display " ")
  ;;  (display b)
  ;;  (newline)
  (if (= b 0)
    a
    (gcd b (remainder a b))))

