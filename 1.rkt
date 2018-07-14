#lang racket

;lista dummy de materias obrigatorias
(define cs '(101 102 103))



;contar quantas matérias
; (apenas base, funçao incompleta)
(define (cc l)
  (let c ([n 0] [l l])
    (cond [(null? l) l]
          [(= n 0) 0]
          [else 1])))




;ver se primeiro esta na lista
;o: materias obrigatorias
(define (cc2? n)
  (let f ([n n] [o cs])
    (cond [(null? o) #f]
          [(= (car o) n) #t]
          [else (f n (cdr o))])))