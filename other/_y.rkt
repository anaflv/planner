#lang racket

(require json)



;(jsexpr->string #hasheq((a . 2)))

(define (symbolify x)
  (string->symbol (format "~a" x)))


(define database2 (make-hasheq))
(hash-set! database2 (symbolify "codigo") 1)

(define l2 (list  database2))

l2


(define assns (list (cons 'k1 "v1")
                    (cons 'k2 "v2")))

(make-hash assns)

(jsexpr->string (make-hash assns))

(define hlist
(list (make-hash(list (cons 'k1 "v1")))
      (make-hash(list (cons 'k1 "v1")))))



(define n
  (list "a" "b" "c"))


(define (assoc/course a)
   (make-hash (list (cons 'codigo a))))


;criar lista json de associacoes
(define x
  (let loop ([t n] [r '()])
    (cond [(null? t) r]
          [else (loop (cdr t)
                      (append r
                              (list (assoc/course
                                     (car t)))))])))

(jsexpr->string x)



