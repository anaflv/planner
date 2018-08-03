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

(define user-classes (string->jsexpr
                (with-input-from-file "ficha.json"
                  (lambda ()
                    (json-lines->json-array)))))

(define t
  (let ([tmp (map (lambda (x) (list (hash-ref x 'disciplina)
                                    (hash-ref x 'situacao)
                                    (hash-ref x 'codigo)
                                    (hash-ref x 'creditos)
                                    (hash-ref x 'periodo)
                                    (hash-ref x 'ano)
                                    (hash-ref x 'disciplina)
                                    (hash-ref x 'categoria)))
                  user-classes)])tmp))