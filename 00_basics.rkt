#|
First exercice to practice the syntax of Racket

Pablo Banzo Prida
2023-02-23
|#

#lang racket ;Indicate the language to use to parse the file

(displayln "Hello World"); Display a message in the console, alternative to "display"

(print (-(* 3 6) (/ 4 2))); Syntax for arithmetic operations

; if statement is a ternary operator
(if (#t 5 7)
; there is no else statement per se
(if (#f 5 7)))