#|
Functions to practice recursion

Pablo Banzo Prida
2023-02-27
|#

#lang racket

(provide ! sum-digits)

;;; Factorial
(define (! n)
  (if (= n 0)
    1
      (* n (! (sub1 n))) ; Factorial of the previous number
  )
)

;;; Sum the digits of a number
(define (sum-digits n)
  (if (< n 10) ; If the number is only one digit (base case)
    n
    (+ (remainder n 10) (sum-digits (quotient n 10)))
  )
)