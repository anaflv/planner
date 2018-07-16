#lang racket


(define out (open-output-file "1.csv" #:mode 'binary  #:exists 'replace))

;base para funcao de escrever arquivo csv
(display "2,7,8" out)


(close-output-port out)