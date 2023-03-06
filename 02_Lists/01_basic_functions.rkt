#|
Functions to work with lists recursively

Pablo Banzo Prida
|#

#lang racket

(require racket/trace)

(provide len lst len-tail sum-tail sqrt-list sqrt-list-optimized)
(define lst '(1 2 3 4 5 6))

; Recreate the "length" function.
; Returns the number of elements in a list
(define (len lst) 
    (if (empty? lst) ; returns #t when a list is empty
    ; Base case, return 0
        0
    ; Otherwise,
        (add1 (len (cdr lst))) ; O(N^2) space complexity because the function is called n*n times
    )
)
(trace len)

(define (len-tail lst)
    (trace-let loop 
        ([lst lst]
        [a 0])
        (if (empty? lst)
        ; Base case
            a
        ; Otherwise,
            (loop (cdr lst) (add1 a))
        )
    )
)

; Sum all elements of a list (tail implementation)
(define (sum-tail lst)
    (trace-let loop
        ([lst lst]
        [a 0])
        (if (empty? lst)
        ; Base case
            a
        ; Otherwise,
            (loop (cdr lst) (+ (car lst) a))
        )
    )
)

; Return a list of the items of the original list, squared
(define (sqrt-list lst)
    (let loop
        ([lst lst]
        [res '()])
    (if (empty? lst)
        res
        (loop (cdr lst) (append res (list(sqrt (car lst))))) ; N^2 runtime because append has to get to the last element of the list
    )
    )
)

; Alternate implementation with cons (but REVERSES THE LIST to get the same output)
(define (sqrt-list-optimized lst)
    (let loop
        ([lst lst]
        [res '()])
    (if (empty? lst)
        ; Invert the list so that it has the original order
        (reverse res)
        (loop (cdr lst) (cons (sqrt (car lst)) res))) ; N runtime because cons has to only access the first element
    )
)