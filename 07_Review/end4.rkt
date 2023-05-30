#lang racket

(provide (all-defined-out))

; Recibo una lista y solo regreso los términos que terminan en cuatro (nota: usar mod 10)
(define (end4 lst)
    (let loop
        ([lst lst]
        [acc '()])
    (cond
    [(empty? lst) (reverse acc)]
    [(eq? 4 (remainder (first lst) 10) ) (loop (rest lst) (cons (first lst) acc ))]
    [else (loop (rest lst) acc )]
    )))

(end4 '(9 4 5 3 26 24))
