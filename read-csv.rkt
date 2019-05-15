#lang racket

(require csv-reading)

(define make-food-csv-reader
  (make-csv-reader-maker
   '((separator-chars            #\;)
     (strip-leading-whitespace?  . #t)
     (strip-trailing-whitespace? . #t))))

(define next-row
  (make-food-csv-reader (open-input-file "A_vencer.csv")))

(next-row)
