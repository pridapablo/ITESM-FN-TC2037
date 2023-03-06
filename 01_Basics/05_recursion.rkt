#|
Functions to practice recursion and tail recursion

Pablo Banzo Prida
2023-02-27
|#

#lang racket

; Library with functions to debug recursive calls
(require racket/trace)

(provide ! sum-digits tail-! tail-sum-digits tail-!-2 tail-sum-2)

; Compute the factorial of a positive integer
(define (! n)
  (if (zero? n)
    ; Base case
    1
    ; Recursive step
    (* n (! (sub1 n)))))

; Using Tail Recursion
(define (tail-! n)

  ; Define an intenal function that takes 2 arguments
  (define (loop n a)
    (if (zero? n)
      a
      (loop (sub1 n) (* n a))))

  (trace loop)

  ; Call the tail function
  ; The accumulator is initialized with the
  ; value for the base case
  (loop n 1))

; Another syntax using let to define a function and call it
(define (tail-!-2 n)
  ; Use trace-let instead of let to debug the calls
  ;(trace-let loop
  (let loop
    ([n n]
     [a 1])
    (if (zero? n)
      a
      (loop (sub1 n) (* n a)))))

; Function to add all the digits in an integer number
(define (sum-digits num)
  (if (zero? num)
    0
    (+ (remainder num 10)
       (sum-digits (quotient num 10)))))

; Sum the digits in a positive integer,
; using tail recursion
;; Using Tail Recursion for Factorial taking two arguments
; f(0,a) -> a
; f(n,a) -> f(n-1, n*a)
(define (tail-sum-digits num)

  (define (loop num res)
    (if (zero? num) ; base case
      res
      (loop (quotient num 10)
            (+ res (remainder num 10)))))

  (trace loop)

  (loop num 0))

; Alternative syntax using a named let
(define (tail-sum-2 num)
  (let loop
    ([num num]
     [res 0])
    (if (zero? num)
      res
      (loop (quotient num 10)
            (+ res (remainder num 10))))))


; Debug by printing all the function calls
(trace !)
(trace sum-digits)