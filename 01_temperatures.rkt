#|
Functions to convert between temprature units (Celsius & Fahrenheit)

Pablo Banzo Prida
2023-02-23
|#

#lang racket
(provide ; provide (similar to an export) all the functions defined in this file
    C->F
    F->C
)
; Note: the functions can be used in the terminal by calling the script with the -it flag, e.g. racket -it temperatures.rkt to use the functions in the terminal.
(define data 46.7); Give a name to a value. This is a variable, but due to best practices, it should be treated as a constant.

; Define a function. This function converts Celsius to Fahrenheit. "celsius" is the name of a parameter and C->F is the name of the function.
(define (C->F celsius)
    (- (* celsius (/ 9 5)) 32) ; The body of the function. This is the code that will be executed when the function is called. The value of the last expression is the value returned by the function.
)

; Define another function. This function converts Fahrenheit to Celsius. "fahrenheit" is the name of a parameter and F->C is the name of the function.
(define (F->C fahrenheit)
    (* (- fahrenheit 32) (/ 5 9.0)) ; The body of the function. This is the code that will be executed when the function is called. The value of the last expression is the value returned by the function.
)

; Call the function C->F with the value of the variable "data" as the argument. The result is displayed.
(display (C->F data)