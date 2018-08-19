#lang racket
(require racket/file)

(require racket/trace
         json)

;dados de matérias
(require "classes.rkt")

(provide indices-notas-F)


(define notas '(1 2 0 0 3 2))



;retorna indices de notas que nao sao f
(define (indices-notas-F notas)
  (let loop ([i 0] [r '()] [l notas])
    (cond
      [(null? l) r]
      [(not (= 0 (car l)))
       (loop (add1 i)
             (append r (list i)) 
             (cdr l))]
      [else (loop (add1 i)
                  r
                  (cdr l))])))



;retorna lista de matérias que nao tem nota f
(define (remove-classes-grade-F c)
  (let loop ([i 0] [r '()] [g (indices-notas-F notas)] [c c])
    (trace loop)
    (cond
      [(null? c) r]
      [(null? g) r]
      [(not (equal? i (car g)))
           (loop (add1 i) r g (cdr c))]
      [else (loop (add1 i)
                  (append r (list (car c)))
                  (cdr g)
                  (cdr c))])))


(define (print-names c)
  (let loop ([c c] [r '()])
    (cond
      [(null? c) r]
      [else (loop (cdr c)
                  (append r (list
                             (hash-ref names
                                       (car c)
                                       (car c)))))])))




(trace indices-notas-F)
(trace remove-classes-grade-F)


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

(define (limparstring x) (regexp-replace* #rx"(-.. )" (file->string x)""))


(print-names filter-mandatory-specific)

