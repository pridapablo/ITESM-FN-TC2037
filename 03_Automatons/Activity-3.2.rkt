#|
    Implementation of a Deterministic Finite Automaton (DFA).

    A function that will recieve the definition of a DFA and a string,
    and will return True if the string is accepted by the DFA
    (if it is in the language of the DFA), and False otherwise.

    A DFA is defined as a state machine

    Pablo Banzo Prida
    2023-03-30
|#

#lang racket

(require racket/trace)

(provide (all-defined-out))

; Declare the structure of a DFA
(struct dfa (trans-func initial accept))

(define (arithmetic-lexer strng)
  "Call the function that evaluates a DFA "
  )

; Define the function that evaluates a DFA
(define (evaluate-dfa a-dfa strng)
  " Evaluates a DFA"
  (let loop
    ([chars (string->list strng)]
     [state (dfa-initial a-dfa)])
    (cond
      ; Member returns #t if the state is in the list of accept states
      ; else returns the rest of the list after that index
      [(empty? chars) (member state (dfa-accept a-dfa))] ; If the final state is an accept state
      [else (loop (rest chars)
                  ; Apply the transition function to get the next state
                  ((dfa-trans-func a-dfa) state (first chars)))])))

; Transition function (use char-numeric?)
(define (delta-numbers state char)
  " Transition Function"
  " Initial state: start"
  " Accept states: int, float, exp"
  (cond
    ;'q0 is a symbol, not a string
    [(eq? state 'start) (cond
                          [(char-numeric? char) 'int]
                          [(eq? char #\+) 'sign]
                          [(eq? char #\-) 'sign]
                          [else 'inv])]
    [(eq? state 'sign) (cond
                         [(char-numeric? char) 'int]
                         [else 'inv])]
    [(eq? state 'int) (cond
                        [(char-numeric? char) 'int]
                        [(eq? char #\.) 'dot]
                        [(eq? char #\e) 'e]
                        [(eq? char #\E) 'e]
                        [else 'inv])]
    [(eq? state 'dot) (cond
                        [(char-numeric? char) 'float]
                        [else 'inv])]
    [(eq? state 'float) (cond
                          [(char-numeric? char) 'float]
                          [(eq? char #\e) 'e]
                          [(eq? char #\E) 'e]
                          [else 'inv])]
    [(eq? state 'e) (cond
                      [(char-numeric? char) 'exp]
                      [(eq? char #\+) 'e_sign]
                      [(eq? char #\-) 'e_sign]
                      [else 'inv])]
    [(eq? state 'e_sign) (cond
                           [(char-numeric? char) 'exp]
                           [else 'inv])]
    [(eq? state 'exp) (cond
                        [(char-numeric? char) 'exp]
                        [else 'inv])]
    [else 'inv]))

(displayln (delta-numbers 'q0 #\a))
(displayln (delta-numbers 'q3 #\a))
(displayln (delta-numbers 'q3 #\v))

; An automaton is a list of states, a list of accept states, a transition function,
; and an initial state
; '(delta-numbers 'q0 '(q1))
(define data (dfa delta-numbers 'start '(+)))
(dfa-initial data)

; Evaluate the following strings with the automaton
(evaluate-dfa data "ab")
(evaluate-dfa data "aab")