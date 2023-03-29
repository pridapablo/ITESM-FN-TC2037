#|
Program that prints the lyrics of the song "El Pollito Pio"

Pablo Banzo Prida
2023-27-03


En la radio hay un Pollito Pio
  Y el Pollito Pio
En la radio hay una Gallina Coo
  Y la Gallina Coo
  Y el Pollito Pio
En la radio hay un Gallo Corocó
  ...
En la radio hay un Pavo Glú Glú Glú
  ...
En la radio hay una Paloma Ruu
  ...
En la radio hay un Gato Miao
  ...
En la radio hay un Perro Guau Guau
  ...
En la radio hay una Cabra Mee
  ...
En la radio hay un Cordero Bee
  ...
En la radio hay una Vaca Moo
  ...
En la radio hay un Toro Muu
  ...
En la radio hay un Tractor
  Y el Tractor: Bruum
  Y el Pollito: oh oh!
|#

#lang racket

;;; Function pollito-lyrics
;;; Base case: if the list is empty, return "En la radio hay un Tractor, Y el Tractor: Bruum, Y el Pollito: oh oh!"
;;; Recursive case: if the list is not empty, append the first element of the list to "En la radio hay"

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
                 "el Pollito Pio"
                 "la Gallina Coo"
                 "el Gallo Corocó"
                 "el Pavo Glú Glú Glú"
                 "la Paloma Ruu"
                 "el Gato Miao"
                 "el Perro Guau Guau"
                 "la Cabra Mee"
                 "el Cordero Bee"
                 "la Vaca Moo"
                 "el Toro Muu"
                 ))

(define (pollito-lyrics topLyrics bottomLyrics)
  (let loop
    ([top topLyrics]
     [bottom bottomLyrics])
    (cond
      [(null? top) "En la radio hay un Tractor\n Y el Tractor: Bruum,\n Y el Pollito: oh oh!\n"]
      [else (string-append "En la radio hay "(car top)",\n Y " (car bottom)"\n" (loop (cdr top) (cdr bottom)))])))



; Print the lyrics of the song "El Pollito Pio"
(display (pollito-lyrics top bottom))
