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

(define e '("BIK0102-13"
  "BIR0004-13"
  "BCS0001-13"
  "BIL0304-13"
  "BIM0005-13"
  "BIN0003-13"
  "MCZC003-13"
  "BCJ0208-13"
  "BCL0306-13"
  "BCN0404-13"
  "BCL0307-13"
  "BCM0506-13"
  "BCM0505-13"
  "BCN0402-13"
  "BIQ0602-13"
  "BIR0603-13"
  "NHZ4033-09"
  "BCN0407-13"
  "BCJ0205-13"
  "ESTO002-13"
  "ESTO008-13"
  "MCTA009-13"
  "BCM0505-13"
  "BCN0405-13"
  "BIN0406-13"
  "ESTO005-13"
  "ESZI003-13"
  "BCL0308-13"
  "MCTA006-13"
  "MCTA018-13"
  "BIJ0207-15"
  "MCTA001-13"
  "MCTB009-13"
  "BCK0103-15"
  "BCM0504-15"
  "BCS0002-15"
  "ESZI027-17"
  "MCTA002-17"
  "BCK0104-15"
  "MCTA023-17"
  "MCTA033-15"))



;filtrar matérias obrigatórias bi
(define (filter-bi l)
  (filter (lambda (x)
            (is-in-list-2 x mandatory-bi))
          l))

(get-names (filter-bi e))



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







