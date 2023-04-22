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
  (with-handlers ([exn? (lambda (exn) #f)]) ; Catch exceptions (#f means the string is not valid)
    (evaluate-dfa (dfa delta-arithmetic 'start '(int float exp var spa paren comment)) strng)))


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
           (values 'inv #f))] ; the final state is not acceptable

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
                 ; If a token was found, clear the buffer and add the current character (if not space)
                 [found
                  (cond
                    [(eq? (car chars) #\space) '()]
                    [else (list (car chars))])]

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
             [else (values 'inv #f )])]
    ['int (cond
            [(char-numeric? char) (values 'int #f)]
            [(eq? char #\.) (values 'dot #f)]
            [(or (eq? char #\e) (eq? char #\E))  (values 'e #f)]
            [(char-operator? char) (values 'op 'int)]
            [(eq? char #\space) (values 'spa 'int)]
            [(eq? (char->integer char) 40) (values 'paren 'int)]
            [(eq? (char->integer char) 41) (values 'paren 'int)]
            [(eq? char #\;) (values 'comment 'int)]
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
              [(eq? char #\;) (values 'comment 'float)]
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

"Open space int space close"
; (arithmetic-lexer "( 45 )") ; '(("(" par_open) ("45" int) (")" par_close))

