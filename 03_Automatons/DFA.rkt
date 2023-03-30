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

; Transition function
(define (transition-even-a-b state char)
  " Transition Function"
  " Initial state: q0"
  " Accept states: q1"
  (cond
    ;'q0 is a symbol, not a string
    [(eq? state 'q0) (cond
                       [(eq? char #\a) 'q2]
                       [(eq? char #\b) 'q1]
                       [else 'inv])]
    [(eq? state 'q1) (cond
                       [(eq? char #\a) 'q1]
                       [(eq? char #\b) 'q1]
                       [else 'inv])]
    [(eq? state 'q2) (cond
                       [(eq? char #\a) 'q3]
                       [(eq? char #\b) 'inv]
                       [else 'inv])]
    [(eq? state 'q3) (cond
                       [(eq? char #\a) 'q2]
                       [(eq? char #\b) 'q1]
                       [else 'inv])]
    [else 'inv]))

(displayln (transition-even-a-b 'q0 #\a))
(displayln (transition-even-a-b 'q3 #\a))
(displayln (transition-even-a-b 'q3 #\v))

; An automaton is a list of states, a list of accept states, a transition function,
; and an initial state
; '(transition-even-a-b 'q0 '(q1))
(struct dfa (trans-func initial accept))
(define data (dfa transition-even-a-b 'q0 '(q1)))
(dfa-initial data)