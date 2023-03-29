#|
Recursive definitions of languages without using map

Pablo Banzo Prida
2023-27-03
|#

#lang racket

;;; Run over the list of strings and apply the rules to each one
(define (derive-string strng rules)
  (let loop
    ([rules rules]
     [res '()])
    (cond
      [(empty? rules) (reverse res)]
      [else (loop (cdr rules) (cons (format (car rules) strng) res))])))

;;; Derive sting with map
(define (_derive-string-map strng rules)
  (map (lambda (rule) (format rule strng)) rules))


(define (_derive-rules strngs rules)
  (let loop
    ([strngs strngs]
     [res '()])
    (cond
      [(empty? strngs) (reverse res)]
      [else (loop (cdr strngs) (cons (derive-string (car strngs) rules) res))])))