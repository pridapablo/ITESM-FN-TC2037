#|
Functions to find the date of the day after a given date.

Pablo Banzo Prida
2023-02-27
|#

#lang racket

(provide leap? month-days next-day)

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
        [else 31]
    )
)

(define (next-day day month year)
    (if (= day (month-days month year))
        (if (= 12 month)
            (list 1 1 (add1 year)); I have to return a list because the function returns a list
            (list 1 (add1 month) year); add1 is a function that adds 1 to a number
        )
        (list (add1 day) month year)
    )
)
