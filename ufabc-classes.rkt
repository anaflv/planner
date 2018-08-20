#lang racket
(require racket/file
         racket/trace
         json)

(provide filter-specific
         filter-bi
         filter-free
         get-names)



;dados de matérias
(require "classes.rkt")


(define (get-names c)
  (let loop ([c c] [r '()])
    (cond
      [(null? c) r]
      [else (loop (cdr c)
                  (append r (list
                             (hash-ref names
                                       (car c)
                                       (car c)))))])))


;pegar codigo da materia (sem ano)
(define (limpar-string x)
  (regexp-replace* #rx"(-..)"
                   x ""))



;contar quantas matérias
(define (cc l)
  (let c ([n 0] [l l])
    (cond [(null? l) n]
          [else (c (add1 n) (cdr l))])))



;ver se matéria esta na lista de cursos
;usando hash
(define (is-in-list n course)
  (let f ([n n] [o course])
    (cond [(null? o) #f]
          [(eq? (car o) n) #t]
          [(eq? (hash-ref old-curriculum (car o) "0") n) #t]
          [else (f n (cdr o))])))



;nao esta na lista
(define (is-not-in-list n course)
  (let f ([n n] [o course])
    (cond [(null? o) #t]
          [(eq? (car o) n) #f]
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
(define free '(1))



;filtrar matérias obrigatórias bi
(define (filter-bi l)
  (filter (lambda (x)
            (is-in-list-2 x mandatory-bi))
          l))


;filtrar matérias obrigatórias específicas
(define (filter-specific l)
  (filter (lambda (x)
            (is-in-list-2 x mandatory-specific))
          l))


;filtrar matérias obrigatórias específicas
(define (filter-free l b s)
  (filter (lambda (x)
            (is-not-in-list x (append b s)))
          l))







