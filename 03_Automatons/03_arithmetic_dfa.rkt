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
  (member char '(#\+ #\- #\* #\= #\^)))

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


; Use the lexer to validate a string

(arithmetic-lexer "(3 + 6)-2 ;Hola como estas \n1 + 2 * 3 + 4")

; V1 Tests
(arithmetic-lexer "2") ;'(int)
(arithmetic-lexer "261") ;'(int)
(arithmetic-lexer "2+1") ;'(int op int)
(arithmetic-lexer "2 + 1") ;'(int op int)
(arithmetic-lexer "6 = 2 + 1") ;'(int op int op int)
; (arithmetic-lexer "97 /6 = 2 + 1") ;'(int op int op int op int)
; (arithmetic-lexer " 2 + 1 ") ; '(int op int)

; V2 Tests
(arithmetic-lexer "2") ; '(("2" int)) "Single digit"
(arithmetic-lexer "261") ; '(("261" int)) "Multi digit int"
(arithmetic-lexer "5.23") ; '(("5.23" float)) "Single float"
(arithmetic-lexer "2+1") ; '(("2" int) ("+" op) ("1" int)) "Binary operation ints"
(arithmetic-lexer "5.2+3") ; '(("5.2" float) ("+" op) ("3" int)) "Float and int"
(arithmetic-lexer "5.2+3.7") ; '(("5.2" float) ("+" op) ("3.7" float)) "Binary operation floats"
(arithmetic-lexer "2 + 1") ; '(("2" int) ("+" op) ("1" int)) "Binary operation with spaces"
(arithmetic-lexer "6 = 2 + 1") ; '(("6" int) ("=" op) ("2" int) ("+" op) ("1" int)) "Multiple operators with spaces"
(arithmetic-lexer "97 /6 = 2 + 1") ; '(("97" int) ("/" op) ("6" int) ("=" op) ("2" int) ("+" op) ("1" int)) "Multiple operators"
(arithmetic-lexer "7.4 ^3 = 2.0 * 1") ; '(("7.4" float) ("^" op) ("3" int) ("=" op) ("2.0" float) ("*" op) ("1" int)) "Multiple float operators with spaces"
(arithmetic-lexer "  2 + 1") ; '(("2" int) ("+" op) ("1" int)) "Spaces before"
(arithmetic-lexer "  2 + 1 ") ; '(("2" int) ("+" op) ("1" int)) "Spaces before and after"


; V3 Tests
(arithmetic-lexer ".23") ; #f "Incorrect float"
(arithmetic-lexer "2.2.3") ; #f "Incorrect float"
(arithmetic-lexer "data") ; '(("data" var)) "Single variable"
(arithmetic-lexer "data34") ; '(("data34" var)) "Single variable"
(arithmetic-lexer "34data") ; #f "Incorrect variable"
(arithmetic-lexer "one+two") ; '(("one" var) ("+" op) ("two" var)) "Binary operation variables"
(arithmetic-lexer "3; this is all") ; '(("3" int) ("; this is all" comment)) "Variable and comment"
(arithmetic-lexer "3+5 ; this is all") ; '(("3" int) ("+" op) ("5" int) ("; this is all" comment)) "Expression and comment")

; V4 Tests

;  ; Numerical types
;  (check-equal? (arithmetic-lexer "2") '(("2" int)) "Single digit")
;  (check-equal? (arithmetic-lexer "261") '(("261" int)) "Multi digit int")
;  (check-equal? (arithmetic-lexer "-63") '(("-63" int)) "Negative int")
;  (check-equal? (arithmetic-lexer "5.23") '(("5.23" float)) "Single float")
;  (check-equal? (arithmetic-lexer "-5.23") '(("-5.23" float)) "Negative float")
;  (check-equal? (arithmetic-lexer ".23") #f "Incorrect float")
;  (check-equal? (arithmetic-lexer "2.2.3") #f "Incorrect float")
;  (check-equal? (arithmetic-lexer "4e8") '(("4e8" exp)) "Exponent int")
;  (check-equal? (arithmetic-lexer "4.51e8") '(("4.51e8" exp)) "Exponent float")
;  (check-equal? (arithmetic-lexer "-4.51e8") '(("-4.51e8" exp)) "Negative exponent float")

;  ; Variables
;  (check-equal? (arithmetic-lexer "data") '(("data" var)) "Single variable")
;  (check-equal? (arithmetic-lexer "data34") '(("data34" var)) "Single variable")
;  (check-equal? (arithmetic-lexer "34data") #f "Incorrect variable")

;  (check-equal? (arithmetic-lexer "2+1") '(("2" int) ("+" op) ("1" int)) "Binary operation ints")
;  (check-equal? (arithmetic-lexer "/1") #f "Invalid expression")
;  (check-equal? (arithmetic-lexer "6 + 4 *+ 1") #f "Invalid expression")
;  (check-equal? (arithmetic-lexer "5.2+3") '(("5.2" float) ("+" op) ("3" int)) "Float and int")
;  (check-equal? (arithmetic-lexer "5.2+3.7") '(("5.2" float) ("+" op) ("3.7" float)) "Binary operation floats")

;  ; Operations with variables
;  (check-equal? (arithmetic-lexer "one+two") '(("one" var) ("+" op) ("two" var)) "Binary operation variables")
;  (check-equal? (arithmetic-lexer "one+two/45.2") '(("one" var) ("+" op) ("two" var) ("/" op) ("45.2" float)) "Mixed variables numbers")

;  ; Spaces between operators
;  (check-equal? (arithmetic-lexer "2 + 1") '(("2" int) ("+" op) ("1" int)) "Binary operation with spaces")
;  (check-equal? (arithmetic-lexer "6 = 2 + 1") '(("6" int) ("=" op) ("2" int) ("+" op) ("1" int)) "Multiple operators with spaces")
;  (check-equal? (arithmetic-lexer "one + two / 45.2") '(("one" var) ("+" op) ("two" var) ("/" op) ("45.2" float)) "Mixed variables numbers spaces")
;  (check-equal? (arithmetic-lexer "97 /6 = 2 + 1") '(("97" int) ("/" op) ("6" int) ("=" op) ("2" int) ("+" op) ("1" int)) "Multiple operators")
;  (check-equal? (arithmetic-lexer "7.4 ^3 = 2.0 * 1") '(("7.4" float) ("^" op) ("3" int) ("=" op) ("2.0" float) ("*" op) ("1" int)) "Multiple float operators with spaces")

;  ; Parentheses
;  ;(check-equal? (arithmetic-lexer "()") '(("(" par_open) (")" par_close)) "Open and close")
;  ;(check-equal? (arithmetic-lexer "( )") '(("(" par_open) (")" par_close)) "Open space close")
;  (check-equal? (arithmetic-lexer "(45)") '(("(" par_open) ("45" int) (")" par_close)) "Open int close")
;  (check-equal? (arithmetic-lexer "( 45 )") '(("(" par_open) ("45" int) (")" par_close)) "Open space int space close")
;  (check-equal? (arithmetic-lexer "(4 + 5)") '(("(" par_open) ("4" int) ("+" op) ("5" int) (")" par_close)) "Open expression close")
;  (check-equal? (arithmetic-lexer "(4 + 5) * (6 - 3)") '(("(" par_open) ("4" int) ("+" op) ("5" int) (")" par_close) ("*" op) ("(" par_open) ("6" int) ("-" op) ("3" int) (")" par_close)) "Open expression close")

;  ; Comments
;  (check-equal? (arithmetic-lexer "3// this is all") '(("3" int) ("// this is all" comment)) "Variable and comment")
;  (check-equal? (arithmetic-lexer "3+5 // this is all") '(("3" int) ("+" op) ("5" int) ("// this is all" comment)) "Expression and comment")
;  (check-equal? (arithmetic-lexer "area = 3.1415 * raduis ^2 // area of a circle") '(("area" var) ("=" op) ("3.1415" float) ("*" op) ("raduis" var) ("^" op) ("2" int) ("// area of a circle" comment)) "Complete expression 1")
;  (check-equal? (arithmetic-lexer "result = -34.6e10 * previous / 2.0 // made up formula") '(("result" var) ("=" op) ("-34.6e10" exp) ("*" op) ("previous" var) ("/" op) ("2.0" float) ("// made up formula" comment)) "Complete expression 2")
;  (check-equal? (arithmetic-lexer "cel = (far - 32) * 5 / 9.0 // temperature conversion") '(("cel" var) ("=" op) ("(" par_open) ("far" var) ("-" op) ("32" int) (")" par_close) ("*" op) ("5" int) ("/" op) ("9.0" float) ("// temperature conversion" comment)) "Complete expression 3")

;  ; Extreme cases of spaces before or after the expression
;  (check-equal? (arithmetic-lexer "  2 + 1") '(("2" int) ("+" op) ("1" int)) "Spaces before")
;  (check-equal? (arithmetic-lexer "  2 + 1 ") '(("2" int) ("+" op) ("1" int)) "Spaces before and after")
