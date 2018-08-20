#lang racket
(require racket/file
         racket/trace
         "classes.rkt"
         json)

(provide filter-specific
         filter-bi
         filter-free
         filter-lim
         filter-to-do
         get-names)





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
(define (is-in-list n id)
  (let f ([n n] [o (hash-ref ch id null)])
    (cond [(null? o) #f]
          [(eq? (car o) n) #t]
          [(eq? (hash-ref old-curriculum (car o) "0") n) #t]
          [else (f n (cdr o))])))


;ver se matéria esta na lista de cursos limitados
;usando hash
(define (is-in-list-lim n id)
  (let f ([n n] [o (hash-ref chl id null)])
    (cond [(null? o) #f]
          [(eq? (car o) n) #t]
          [(eq? (hash-ref old-curriculum (car o) "0") n) #t]
          [else (f n (cdr o))])))



;nao esta na lista
(define (is-not-in-list n lis)
  (let f ([n n] [o lis])
    (cond [(null? o) #t]
         [(equal? (limpar-string (car o))
                 (limpar-string n))
                 #f]
          [else (f n (cdr o))])))

;ver se matéria esta na lista de cursos
(define (is-in-list-2 n id)
  (let f ([n n] [o (hash-ref ch id null)])
    (cond [(null? o) #f]
          [(eq? (car o) n) #t]
          [(equal? (limpar-string (car o))
                 (limpar-string n))
                 #t]
          [else (f n (cdr o))])))


;course hash
(define ch
  (hash
   1 bcc-17
   2 aero-2017
   3 ambiental-2017
   4 biomed-2017
   9 fisica-2015
   10 neuro-2015
   100 bct))



;course hash
(define chl
  (hash
   1 optional-bcc
   2 aero-lim
   3 ambiental-2017-lim
   9 fisica-2015-lim
   10 neuro-2015-lim
   100 bct))




(define mandatory-specific bcc-17)
  

;filtrar matérias obrigatórias bi
(define (filter-bi l id)
  (filter (lambda (x)
            (is-in-list-2 x id))
          l))



;filtrar matérias obrigatórias específicas
(define (filter-specific l id)
  (print id)
  (filter (lambda (x)
            (is-in-list-2 x id))
          l))


;filtrar matérias obrigatórias específicas
(define (filter-free l b s)
  (filter (lambda (x)
            (is-not-in-list x (append b s)))
          l))


;filtrar matérias obrigatórias específicas
(define (filter-lim l id)
  (print id)
  (filter (lambda (x)
            (is-in-list-lim x id))
          l))


;filtrar matérias obrigatórias específicas
(define (filter-to-do l id)
  (filter (lambda (x)
            (is-not-in-list  x l))
          (append bct (hash-ref ch id null))))



(append bct (hash-ref ch 1))


