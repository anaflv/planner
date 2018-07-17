#lang racket

(require json)

(define (json-lines->json-array #:head [head #f])
  (let loop ([num 0]
             [json-array '()]
             [record (read-json (current-input-port))])
    (if (or (eof-object? record)
            (and head (>= num head)))
        (jsexpr->string json-array)
        (loop (add1 num) (cons record json-array)
              (read-json (current-input-port))))))

(define tweets (string->jsexpr
                (with-input-from-file "ficha.json" (λ () (json-lines->json-array)))))

(define t
  (let ([tmp (map (λ (x) (list (hash-ref x 'disciplina) (hash-ref x 'situacao)
                               (hash-ref x 'categoria))) tweets)])tmp))