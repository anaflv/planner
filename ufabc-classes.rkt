#lang racket
(require racket/file
         racket/trace
         json)


;dados de matérias
(require "classes.rkt")


(define (print-names c)
  (let loop ([c c] [r '()])
    (cond
      [(null? c) r]
      [else (loop (cdr c)
                  (append r (list
                             (hash-ref names
                                       (car c)
                                       (car c)))))])))


;pega ate o digito -
(define (limpar-string x)
  (regexp-replace* #rx"(-..)"
                   x ""))



;contar quantas matérias
(define (cc l)
  (let c ([n 0] [l l])
    (cond [(null? l) n]
          [else (c (add1 n) (cdr l))])))



;ver se matéria esta na lista de cursos
(define (is-in-list n course)
  (let f ([n n] [o course])
    (cond [(null? o) #f]
          [(eq? (car o) n) #t]
          [(eq? (hash-ref old-curriculum (car o) "0") n) #t]
          [else (f n (cdr o))])))



;ver se matéria esta na lista de cursos
(define (is-in-list-2 n course)
  (let f ([n n] [o course])
    (cond [(null? o) #f]
          [(eq? (car o) n) #t]
          [(equal? (limpar-string (car o))
                 (limpar-string n))
                 #t]
          [else (f n (cdr o))])))




(define mandatory-bi bct)
(define mandatory-specific bcc-17)
(define free-specific '(1))


;filtrar matérias obrigatórias bi
(define filter-bi
  (filter (lambda (x)
            (is-in-list x mandatory-bi))
          classes-taken-dummy))

;filtrar mmatérias obrigatórias específicas
(define filter-mandatory-specific
  (filter (lambda (x)
            (is-in-list x mandatory-bi))
          classes-taken-dummy))




;(print-names filter-mandatory-specific)


;filtrar mmatérias obrigatórias específicas
(define filter-mandatory-specific-2
  (filter (lambda (x)
            (is-in-list-2 x mandatory-bi))
          classes-taken-dummy))




;classes-taken-dummy
;filter-mandatory-specific
filter-mandatory-specific-2

(equal? (limpar-string "a-13") (limpar-string "a-23"))
(limpar-string "a-13")

