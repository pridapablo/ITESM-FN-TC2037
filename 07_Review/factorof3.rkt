#lang racket

(require racket/trace)

(provide (all-defined-out))

(define (factorOf3 lst)
  (let loop ([lst lst]
             [acc '()])
  (cond 
   [(empty? lst) (reverse acc)]
   [(= (remainder (first lst) 3) 0) (loop (rest lst) (cons (first lst) acc))]
   [else (loop (rest lst) acc)])))

(factorOf3 '(9 4 5 2))
