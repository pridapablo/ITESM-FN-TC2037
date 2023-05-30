#lang racket

(require racket/trace)

(provide (all-defined-out))

(define (d7 lst)
  (let loop ([lst lst] [acc '()])
    (cond
      [(empty? lst)
      (reverse acc)]
      [else (loop (rest lst) (cons (/ (first lst) 7.0) acc))])))

(d7 '(7 3 56 74))
