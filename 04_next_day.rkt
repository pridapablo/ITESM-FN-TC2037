#|
Functions to find the date of the day after a given date.

Pablo Banzo Prida
2023-02-27
|#

#lang racket

(provide leap? month-days)

(define (leap? year); a leap year is a year divisible by 4, but not by 100, unless it is divisible by 400
    (
        and (= 0 (remainder year 4))
        (
            or (not (= 0 (remainder year 100)))
        )
            (
                =  0 (remainder year 400)
            )
    )) ; we can omit the if statement, because the result of the last expression is the result of the function

(define (month-days month year)
    (case month ; a quick way to do this is with a case statement
        [(4 6 9 11) 30]
        [(2) (if (leap? year) 29 28)]
        [(else) 31]
    )
)
