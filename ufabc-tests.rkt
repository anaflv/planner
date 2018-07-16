#lang racket


(require rackunit "ufabc-classes.rkt")

(require rackunit/text-ui)

(define failed-classes-tests
  (test-suite
   "Test Failed classes"
    (check-equal? (indices-notas-F '(1 4 0 0 2 1 -1 0)) '(0 1 4 5 6))
    (check-equal? (indices-notas-F '(4 0 1 -1 1 3)) '(0 2 3 4 5))
    (check-equal? (indices-notas-F '(0 4 1 2 5 0 1 2 3 3 3 0))
                  '(1 2 3 4 6 7 8 9 10))
    ))


(run-tests failed-classes-tests)
