#lang racket

(require racket/trace)

(provide (all-defined-out))

(define (cubed lst)
  (let loop 
    ([lst lst]
    [acc '()])
     (cond
     [(empty? lst) (reverse acc)]
      [else (loop (rest lst) (cons (* (first lst) (first lst) (first lst) ) acc ) )])))

(cubed '(2 4 5 2))
