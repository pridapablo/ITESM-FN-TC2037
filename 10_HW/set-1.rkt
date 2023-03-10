#|
Homework set #1

Pablo Banzo Prida
Gabriel Rodriguez de los Reyes
|#

#lang racket
(provide (all-defined-out)); export all functions

;;; 1. The fahrenheit-to-celsius function receives a temperature value in Fahrenheit degrees as an input and converts it to its equivalent Celsius degrees using the following formula: C = (F - 32) * 5/9
(define (fahrenheit-to-celsius fahrenheit)
    (* (- fahrenheit 32) (/ 5 9.0))) ; using 9.0 instead of 9 to avoid integer division and get a float result

;;; 2. The sign function takes an integer n as input. It returns -1 if n is negative, 1 if n is positive and greater than zero, or 0 if n equals zero.
(define (sign n)
    (cond
        [(< n 0) -1] ; if n is negative return -1
        [(> n 0) 1] ; if n is positive and greater than 0 return 1
        [else 0])) ; if n equals 0 return 0 (we don't check the condition for efficiency)

;;; 3. The roots function returns the root that solves a quadratic equation from its three coefficients a, b, and c, which are received as inputs. The general formula should be used to solve the quadratic equation.

;;; 4.  Body Mass Index (BMI) is used to determine whether a person's weight-to-height ratio is adequate. BMI is calculated using the formula: BMI = weight / height^2.
;;;;;;  Here, weight is in kilograms and height is in meters. We can classify different ranges of BMI based on the following table:
;;;;;; BMI Range     Description
;;;;;; BMI < 20      underweight
;;;;;; 20≤BMI<25     normal
;;;;;; 25≤BMI<30     obese1
;;;;;; 30≤BMI<40     obese2
;;;;;; 40 ≤ BMI      obese3
;;;;;; The bmi function receives two inputs: weight and height. It should returns a symbol representing the corresponding BMI description calculated from those inputs.
(define (bmi weight height)
    (let ([bmi (/ weight (expt height 2))])
        (cond ; list of conditions to check bmi ranges
            [(< bmi 20) 'underweight]
            [(< bmi 25) 'normal]
            [(< bmi 30) 'obese1]
            [(< bmi 40) 'obese2]
            [else 'obese3])))

;;; 5. The factorial function takes a positive integer n as input and returns the corresponding factorial, which is mathematically defined as follows:
;;;;;; n! = 1 si n = 0
;;;;;; n! = n * (n-1)! if n > 0

(define (factorial n)
  ; Use trace-let instead of let to debug the calls
  (let loop
    ([n n] 
     [a 1]) ; a is the accumulator and is initialized to 1
    (if (zero? n) ; if n = 0 we return the accumulator
      a
      (loop (sub1 n) (* n a))))) ; otherwise call the function again for the next factorial (downwards) and multiply the accumulator by n

;;; 6. The duplicate function takes a list lst as input and returns a new list where each element of lst is duplicated.
(define (duplicate lst)
    (let loop
        ([lst lst] ; list to duplicate
        [res '()]) ; resulting list
        (if (empty? lst) ; if the list is empty return the resulting list
        (reverse res) ; we reverse the resulting list because we are adding elements to the beginning of the list (for efficiency)
        (loop (cdr lst) (cons (car lst) (cons (car lst) res)))))) ; otherwise add the first element of the list to the new list two times and call the function again with the rest of the list (excluding the first element)

;;; 7. The pow function takes two inputs: a number a and a positive integer b. It returns the result of raising a to the power of b.
(define (pow a b)
    (let loop
        ([b b] ; exponent
        [a a] ; base
        [res 1]) ; (initialized to 1)
        (if (zero? b) ; if b = 0 return the accumulator, since a^0 = 1
        res 
        (loop (sub1 b) a (* a res))))) ; otherwise call the function again with the next exponent (downwards) and multiply the accumulator by 

;;; 8. The fib function takes a positive integer n as input and returns the corresponding element of the Fibonacci sequence, which is mathematically defined as follows:
;;;;;; fib(n) = n si n ≤ 1
;;;;;; fib(n) = fib(n-1) + fib(n-2) si n > 1
(define (fib n)
    (let loop
        ([n n]
        [a 0]
        [b 1])
        (if (zero? n)
        a
        (loop (sub1 n) b (+ a b)))))

;;; 9: The enlist function takes a list lst as input. It places every top-level element of lst inside another list and returns the resulting list.
(define (enlist lst)
    (let loop
        ([lst lst]
        [res '()])
        (if (empty? lst)
        (reverse res)
        (loop (cdr lst) (cons (list (car lst)) res)))))

;;; 10. The positives function takes a list of numbers lst as input and returns a new list containing only the positive numbers of lst.
(define (positives lst)
    (let loop
        ([lst lst]
        [res '()])
        (if (empty? lst)
        (reverse res)
        (if (> (car lst) 0)
            (loop (cdr lst) (cons (car lst) res))
            (loop (cdr lst) res)))))

;;; 11. The add-list function returns the sum of the numbers contained in the list passed as input, or 0 if it is empty.
(define (add-list lst)
    (let loop
        ([lst lst]
        [res 0])
        (if (empty? lst)
        res
        (loop (cdr lst) (+ (car lst) res)))))

;;; 12. The invert-pairs function takes as input a list whose content are two-element lists. It returns a new list with each pair inverted.
(define (invert-pairs lst)
    (let loop
        ([lst lst]
        [res '()])
        (if (empty? lst)
        (reverse res)
        (loop (cdr lst) (cons (list (cadr (car lst)) (car (car lst))) res)))))

;;; !13. The list-of-symbols? function takes a list lst as input. It returns true if all elements (possibly zero) contained in lst are symbols, or false otherwise.
(define (list-of-symbols? lst)
    (if (empty? lst)
        #t
        (if (symbol? (car lst))
            (list-of-symbols? (cdr lst))
            #f)))

;;; !14: The swapper function takes three inputs: two values a and b, and a list lst. It returns a new list in which each occurrence of a in lst is exchanged for b, and vice versa. Any other element of lst remains the same. It can be assumed that there are no nested lists in lst.
(define(swapper a b lst)
    (cond
        [(null? lst) '()]
        [(equal? (car lst) a) (cons b (swapper a b (cdr lst)))]
        [(equal? (car lst) b) (cons a (swapper a b (cdr lst)))]
        [else (cons (car lst) (swapper a b (cdr lst)))])
)

;;; !15. The dot-product function takes two inputs: the lists a and b. It returns the result of performing the dot product of a by b. The dot product is an algebraic operation that takes two sequences of numbers of equal length and returns a single number obtained by multiplying the elements in the same position and then adding those products. Its formula is:
;;;;;; a · b = a1 * b1 + a2 * b2 + ... + an * bn
(define (dot-product a b)
    ;;; (dot-product '(1 2 3) '(4 5 6)) => 32
    (if (empty? a) ;;; if a is empty
        0 ;;; return 0
        (+ (* (car a) (car b)) (dot-product (cdr a) (cdr b))))) ;;; else return the sum of the product of the first elements of a and b, and the dot-product of the rest of a and b (recursion))

(define (dot-product-tail a b) ;;; tail recursive version of dot-product
    (let loop
     ([a a]
     [b b]
     [res 0])
        (if (empty? a)
            res
            (loop (cdr a) (cdr b) (+ res (* (car a) (car b)))))))

;;; !16. The average function receives a list of numbers lst as input. It returns the arithmetic mean of the elements contained in lst, or 0 if lst is empty. The arithmetic mean is defined as:
;;;;;; μ = 1/n * ∑x_i
(define (average lst)
  (if (null? lst)
  0
  (/ (sum lst) (length lst))))


(define (sum lst)
    (if (null? lst)
        0
        (+ (car lst) (sum (cdr lst)))))

;;; 17. The standard-deviation function receives a list of numbers lst as input. It returns the standard deviation of the population of the elements contained in lst, or 0 if lst is empty. The standard deviation of the population (σ) is defined as:
;;;;;; σ = √(1/n * ∑(x_i - μ)^2)

;;; 18. The replic function takes two inputs: a list lst and an integer n, where n ≥ 0. It returns a new list that replicates each element contained in lst n times.

;;; 19. The expand function takes a list lst as input. It returns a list where the first element of lst appears once, the second element appears twice, the third element appears three times, and so on.
(define (expand lst)
    (let loop
        ([lst lst]
        [res '()]
        [n 1])
        (if (empty? lst)
        (reverse res)
        (loop (cdr lst) (append (replicate (car lst) n) res) (+ n 1)))))

;;; 20. The binary function receives an integer n as input (n ≥ 0). If n is equal to zero, it returns an empty list. If n is greater than zero, it returns a list with a sequence of ones and zeros equivalent to the binary representation of n.