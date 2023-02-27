#|
Formulas for geometric properties

Pablo Banzo Prida
2023-02-23
|#

#lang racket
(provide (all-defined-out)); export the area function 

; define a function to calculate the area of a circle. It takes one argument: radius
(define (circle-area radius) 
    (* pi radius radius)
)

; define a function to calculate the perimeter of a circle. It takes one argument: radius
(define (circle-perimeter radius) 
    (* 2 pi radius)
    ; (* (2 pi) radius) would return an error because parenthesis are not allowed if a function is not called
)

; define a function to calculate the area of a triangle. It takes two arguments: base and height
(define (triangle-area base height) 
    (/ (* base height) 2)
)

; define a function to calculate the perimeter of a triangle. It takes three arguments: side1, side2 and side3
(define (triangle-perimeter side1 side2 side3) 
    (+ side1 side2 side3)
)

(displayln (circle-area 2)) ; display the area of a circle with radius 2