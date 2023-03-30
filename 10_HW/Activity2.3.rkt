#|
Program that prints the lyrics of the song "El Pollito Pio"

Pablo Banzo Prida
2023-27-03
|#

#lang racket

;;; Define the top and bottom parts of each line of the song as two lists
(define top '("un Pollito Pio"
              "una Gallina Coo"
              "un Gallo Corocó"
              "un Pavo Glú Glú Glú"
              "una Paloma Ruu"
              "un Gato Miao"
              "un Perro Guau Guau"
              "una Cabra Mee"
              "un Cordero Bee"
              "una Vaca Moo"
              "un Toro Muu"))

(define bottom '(
                 " Y el Pollito Pio"
                 " Y la Gallina Coo"
                 " Y el Gallo Corocó"
                 " Y el Pavo Glú Glú Glú"
                 " Y la Paloma Ruu"
                 " Y el Gato Miao"
                 " Y el Perro Guau Guau"
                 " Y la Cabra Mee"
                 " Y el Cordero Bee"
                 " Y la Vaca Moo"
                 " Y el Toro Muu"
                 ))

#| Define a helper function print-n-items which takes a list and a number n as input,
and returns a string that contains the first n elements of the list (in reverse order) |#
(define (print-n-items lst n)
  (cond
    [(empty? lst) ""] ; If the list is empty, return an empty string
    [(= n 0) ""] ; If n is 0, return an empty string
    ; Otherwise, return a string that contains the first element of the list, and the recursive call
    [else (string-append (print-n-items (rest lst) (sub1 n)) (first lst) "\n")]))

;;; Function print-n-items-tail takes the same arguments as print-n-items, but it is tail recursive
(define (print-n-items-tail lst n)
  (let loop [(lst lst) ; List
             (n n) ; Number of elements to print
             (acc "")] ; Accumulator to store the elements of the list (tail)
    (cond
      [(empty? lst) acc] ; If the list is empty, return the accumulator
      [(= n 0) acc] ; If n is 0, return the accumulator
      ; Otherwise, make a tail recursive call
      [else (loop (rest lst) (sub1 n) (string-append (first lst) "\n" acc))])))

#| Define a function pollito-lyrics that takes two lists of lyrics and an iterator initialized as 0
as input, and returns a string that contains the lyrics of the song "El Pollito Pio" |#
(define (pollito-lyrics topLyrics bottomLyrics c)
  (let loop
    ([top topLyrics] ; First list
     [bottom bottomLyrics] ; Second list
     [count c]) ; Counter to print the first n elements of the second list
    (cond
      [(or (empty? top) (empty? bottom))
       ; If one of the lists is empty, print the last part of the song (base case)
       "En la radio hay un Tractor\n Y el Tractor: Bruum\n Y el Pollito: oh oh!\n"]
      ; If the lists are not empty, make a recursive call (explained in the recursive case)
      [else (string-append  "En la radio hay " (first top) "\n" (print-n-items bottom count) (loop (rest top) bottom (add1 count)) )])))

;;; Function pollito-lyrics-tail takes the same arguments as pollito-lyrics, but it is tail recursive
(define (pollito-lyrics-tail topLyrics bottomLyrics c)
  (let loop
    ([top topLyrics]
     [bottom bottomLyrics]
     [count c]
     [acc ""]) ; Accumulator to store the lyrics (tail)
    (cond
      ; Same base case but appending the end of the song to the accumulator
      [(or (empty? top) (empty? bottom)) (string-append acc "En la radio hay un Tractor\n Y el Tractor: Bruum\n Y el Pollito: oh oh!\n")]
      ; Reorder the recursive call to make it tail recursive (store the lyrics in the accumulator)
      [else (loop (rest top) bottom (add1 count) (string-append acc "En la radio hay " (first top) "\n" (print-n-items-tail bottom count))) ])))


; Print the lyrics of the song "El Pollito Pio"
; Tail recursive version
(display "Tail recursive version:\n" )
(display (pollito-lyrics-tail top bottom 1))

; Non tail recursive version
(display "\n\n\nNon tail recursive version:\n")
(display (pollito-lyrics top bottom 1))
