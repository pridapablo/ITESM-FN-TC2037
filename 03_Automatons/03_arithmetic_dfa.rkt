#|
Implementation of a Deterministic Finite Automaton (DFA)

A function will receive the definition of a DFA and a string,
and return whether the string belongs in the language

A DFA is defined as a state machine, with 3 elements:
- Transition function
- Initial state
- List of acceptable states

The DFA in this file is used to identify valid arithmetic expressions

Examples:
> (evaluate-dfa (dfa delta-arithmetic 'start '(int float exp)) "-234.56")
'(float exp)

> (arithmetic-lexer "45.3 - +34 / none")
'(var spa)

Pablo Banzo Prida
& Gabriel Rodriguez de los Reyes
2023-03-30
|#

#lang racket

(require racket/trace)

(provide (all-defined-out))

; Declare the structure that describes a DFA
(struct dfa (func initial accept))

(define (arithmetic-lexer strng)
  " Call the function to validate using a specific DFA "
  (evaluate-dfa (dfa delta-arithmetic 'start '(int float exp var spa paren comment)) strng))

(define (evaluate-dfa dfa-to-evaluate strng)
  " This function will verify if a string is acceptable by a DFA "
  (let loop
    ; Convert the string into a list of characters
    ([chars (string->list strng)]
     ; Get the initial state of the DFA
     [state (dfa-initial dfa-to-evaluate)]
     ; The return list with all tokens found
     [tokens '()]
     ; Buffer to store the current token's characters
     [token-buffer '()])
    (cond
      ; When the list of chars if over, check if the final state is acceptable
      [(empty? chars)
       (if (member state (dfa-accept dfa-to-evaluate))
           (reverse (cons (cons (list->string (reverse token-buffer)) state) tokens))
           'inv)]

      [else
       (let-values
           ; Apply the transition function to get the new state or not when a token is found
           ; We recieve the new-state and a flag to indicate if a token was found (new-state found)
           ([(new-state found) ((dfa-func dfa-to-evaluate) state (car chars))])
         (loop (cdr chars)
               new-state
               (cond
                 ; If a token was found, add it to the list along with its string representation
                 [found (cons (cons (list->string (reverse token-buffer)) found) tokens)]
                 ; If not, keep the same list
                 [else tokens])
               (cond
                 ; If a token was found, clear the token-buffer
                 [found '()]
                 ; If not, add the current character to the token-buffer
                 [else (cons (car chars) token-buffer)])))])))

(define (char-operator? char)
  " Identify caracters that represent arithmetic operators "
  (member char '(#\+ #\- #\* #\= #\^ #\/)))

(define (delta-arithmetic state char)
  " Transition function to validate numbers
  Initial state: start
  Accept states: int float exp "
  (case state
    ['start (cond
              [(char-numeric? char) (values 'int #f)]
              [(or (eq? char #\+) (eq? char #\-)) (values 'sign #f)]
              [(char-alphabetic? char)(values 'var #f)]
              [(eq? char #\_)(values 'var #f)]
              [(eq? (char->integer char) 40) (values 'paren #f)]
              ; [(eq? (char->integer char) 41) (values 'paren #f)]
              [(eq? char #\;) (values 'comment #f)]
              [else (values 'inv #f )])]
    ['sign (cond
             [(char-numeric? char) (values 'int #f)]
             [(eq? (char->integer char) 40) (values 'paren #f)]
             ;  [(eq? (char->integer char) 41) (values 'paren #f)]
             [(eq? char #\;) (values 'comment #f)]
             [else 'inv #f])]
    ['int (cond
            [(char-numeric? char) (values 'int #f)]
            [(eq? char #\.) (values 'dot #f)]
            [(or (eq? char #\e) (eq? char #\E))  (values 'e #f)]
            [(char-operator? char) (values 'op 'int)]
            [(eq? char #\space) (values 'spa 'int)]
            [(eq? (char->integer char) 40) (values 'paren 'int)]
            [(eq? (char->integer char) 41) (values 'paren 'int)]
            [(eq? char #\;) (values 'comment #f)]
            [else (values 'inv #f )])]
    ['dot (cond
            [(char-numeric? char)  (values 'float #f)]
            [else (values 'inv #f )])]
    ['float (cond
              [(char-numeric? char) (values 'float #f)]
              [(or (eq? char #\e) (eq? char #\E)) (values 'e #f)]
              [(char-operator? char) (values 'op 'float )]
              [(eq? char #\space) (values 'spa 'float)]
              [(eq? (char->integer char) 40) (values 'paren #f)]
              [(eq? (char->integer char) 41) (values 'paren #f)]
              [(eq? char #\;) (values 'comment #f)]
              [else (values 'inv #f )])]
    ['e (cond
          [(char-numeric? char) (values 'exp #f)]
          [(or (eq? char #\+) (eq? char #\-)) (values 'e_sign #f)]
          [else (values 'inv #f )])]
    ['e_sign (cond
               [(char-numeric? char) (values 'exp #f)]
               [else (values 'inv #f )])]
    ['exp (cond
            [(char-numeric? char) (values 'exp #f)]
            [(char-operator? char) (values 'op 'exp)]
            [(eq? char #\space) (values 'spa 'exp)]
            [(eq? (char->integer char) 40) (values 'paren #f)]
            [(eq? (char->integer char) 41) (values 'paren #f)]
            [(eq? char #\;) (values 'comment #f)]
            [else (values 'inv #f )])]
    ['var (cond
            [(char-alphabetic? char) (values 'var #f)]
            [(char-numeric? char) (values 'var #f)]
            [(eq? char #\_) (values 'var #f)]
            [(char-operator? char) (values 'op 'var)]
            [(eq? char #\space) (values 'spa 'var)]
            [(eq? (char->integer char) 40) (values 'paren #f)]
            [(eq? (char->integer char) 41) (values 'paren #f)]
            [(eq? char #\;) (values 'comment #f)]
            [else (values 'inv #f )])]
    ['op (cond
           [(char-numeric? char)(values 'int 'op)]
           [(or (eq? char #\+) (eq? char #\-))(values 'sign 'op)]
           [(char-alphabetic? char)(values 'var 'op)]
           [(eq? char #\_)(values 'var 'op)]
           [(eq? char #\space)(values 'op_spa 'op)]
           [(eq? (char->integer char) 40) (values 'paren 'paren)]
           [(eq? (char->integer char) 41) (values 'paren 'paren)]
           [(eq? char #\;) (values 'comment #f)]
           [else (values 'inv #f )])]
    ['spa (cond
            [(char-operator? char) (values 'op #f)]
            [(eq? char #\space) (values 'spa #f)]
            [(eq? (char->integer char) 40) (values 'paren #f)]
            [(eq? (char->integer char) 41) (values 'paren #f)]
            [(eq? char #\;) (values 'comment #f)]
            [else (values 'inv #f )])]
    ['op_spa (cond
               [(char-numeric? char) (values 'int #f )]
               [(or (eq? char #\+) (eq? char #\-)) (values 'sign #f )]
               [(char-alphabetic? char) (values 'var #f )]
               [(eq? char #\_) (values 'var #f )]
               [(eq? char #\space) (values 'op_spa #f )]
               [(eq? (char->integer char) 40) (values 'paren #f)]
               ;  [(eq? (char->integer char) 41) (values 'paren #f)]
               [(eq? char #\;) (values 'comment #f)]
               [else (values 'inv #f )])]
    ['paren (cond
              [(char-numeric? char) (values 'int 'paren)]
              [(or (eq? char #\+) (eq? char #\-)) (values 'sign 'paren)]
              [(char-alphabetic? char) (values 'var 'paren)]
              [(eq? char #\_)(values 'var 'paren)]
              [(eq? char #\space) (values 'spa 'paren)]
              [(eq? (char->integer char) 40) (values 'paren 'paren)]
              [(eq? (char->integer char) 41) (values 'paren 'paren)]
              [(eq? char #\;) (values 'comment #f)]
              [else (values 'inv #f )])]
    ['comment (cond
                [(eq? char #\newline) (values 'start 'comment)]
                [else (values 'comment #f )])]))


; Tests
; Use the lexer to validate a string

(arithmetic-lexer "(3 + 6)-2 ;Hola como estas \n1 + 2 * 3 + 4")
;  ; Numerical types
"Single digit"
(arithmetic-lexer "2") ; '(("2" int)))
"Multi digit int"
(arithmetic-lexer "261") ; '(("261" int))
"Negative int"
(arithmetic-lexer "-63") ; '(("-63" int))
"Single float"
(arithmetic-lexer "5.23") ; '(("5.23" float))
"Negative float"
(arithmetic-lexer "-5.23") ; '(("-5.23" float))
"Incorrect float"
; (arithmetic-lexer ".23") ; #f
; (arithmetic-lexer "2.2.3") ; #f
"Exponent int"
(arithmetic-lexer "4e8") ; '(("4e8" exp))
"Exponent float"
(arithmetic-lexer "4.51e8") ; '(("4.51e8" exp))
"Negative exponent float"
(arithmetic-lexer "-4.51e8") ; '(("-4.51e8" exp))

;  ; Variables
"Single variable"
(arithmetic-lexer "data") ; '(("data" var))
(arithmetic-lexer "data34") ; '(("data34" var))
"Incorrect variable"
; (arithmetic-lexer "34data") ; #f
"Binary operation ints"
(arithmetic-lexer "2+1") ; '(("2" int) ("+" op) ("1" int))
"Invalid expression"
; (arithmetic-lexer "/1") ; #f
; (arithmetic-lexer "6 + 4 *+ 1") ; #f
"Float and int"
(arithmetic-lexer "5.2+3") ; '(("5.2" float) ("+" op) ("3" int))
"Binary operation floats"
(arithmetic-lexer "5.2+3.7") ; '(("5.2" float) ("+" op) ("3.7" float))

;  ; Operations with variables
"Binary operation variables"
(arithmetic-lexer "one+two") ; '(("one" var) ("+" op) ("two" var))
"Mixed variables numbers"
(arithmetic-lexer "one+two/45.2") ; '(("one" var) ("+" op) ("two" var) ("/" op) ("45.2" float))

;  ; Spaces between operators
"Binary operation with spaces"
(arithmetic-lexer "2 + 1") ; '(("2" int) ("+" op) ("1" int))
"Multiple operators with spaces"
(arithmetic-lexer "6 = 2 + 1") ; '(("6" int) ("=" op) ("2" int) ("+" op) ("1" int))
"Mixed variables numbers spaces"
(arithmetic-lexer "one + two / 45.2") ; '(("one" var) ("+" op) ("two" var) ("/" op) ("45.2" float))
"Multiple operators"
(arithmetic-lexer "97 /6 = 2 + 1")
; '(("97" int) ("/" op) ("6" int) ("=" op) ("2" int) ("+" op) ("1" int))
"Multiple float operators with spaces"
(arithmetic-lexer "7.4 ^3 = 2.0 * 1")
; '(("7.4" float) ("^" op) ("3" int) ("=" op) ("2.0" float) ("*" op) ("1" int))

;  ; Parentheses
"Open and close"
(arithmetic-lexer "()") ; '(("(" par_open) (")" par_close))
"Open space close"
(arithmetic-lexer "( )") ; '(("(" par_open) (")" par_close))
"Open int close"
(arithmetic-lexer "(45)") ; '(("(" par_open) ("45" int) (")" par_close))
"Open space int space close"
; (arithmetic-lexer "( 45 )") ; '(("(" par_open) ("45" int) (")" par_close))
"Open expression close"
(arithmetic-lexer "(4 + 5)") ; '(("(" par_open) ("4" int) ("+" op) ("5" int) (")" par_close))
"Open expression close"
(arithmetic-lexer "(4 + 5) * (6 - 3)")
; '(("(" par_open) ("4" int) ("+" op) ("5" int) (")" par_close) ("*" op)
; ("(" par_open) ("6" int) ("-" op) ("3" int) (")" par_close))

;  ; Comments
"Variable and comment"
(arithmetic-lexer "3; this is all") ; '(("3" int) ("; this is all" comment))
"Expression and comment"
(arithmetic-lexer "3+5 ; this is all") ; '(("3" int) ("+" op) ("5" int) ("; this is all" comment))
"Complete expression 1"
(arithmetic-lexer "area = 3.1415 * raduis ^2 ; area of a circle")
; '(("area" var) ("=" op) ("3.1415" float) ("*" op) ("raduis" var) ("^" op) ("2" int)
; ("; area of a circle" comment))
"Complete expression 2"
(arithmetic-lexer "result = -34.6e10 * previous / 2.0 ; made up formula")
; '(("result" var) ("=" op) ("-34.6e10" exp) ("*" op) ("previous" var) ("/" op)
; ("2.0" float) ("; made up formula" comment))
"Complete expression 3"
(arithmetic-lexer "cel = (far - 32) * 5 / 9.0 ; temperature conversion") ; '(("cel" var) ("=" op)
; ("(" par_open) ("far" var) ("-" op) ("32" int) (")" par_close)
; ("*" op) ("5" int) ("/" op) ("9.0" float) ("; temperature conversion" comment))

;  ; Extreme cases of spaces before or after the expression
"Spaces before"
; (arithmetic-lexer "  2 + 1") ; '(("2" int) ("+" op) ("1" int))
"Spaces before and after"
; (arithmetic-lexer "  2 + 1 ") ; '(("2" int) ("+" op) ("1" int))
