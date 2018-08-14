#lang racket

(require web-server/servlet
         web-server/servlet-env)

(define (start req)
;  (response/xexpr
;   '(html (head (title "Racket Heroku App"))
;          (body (h1 "It works!")))))

  (response/json

(require json)
(string->jsexpr "{\"word\": \"a\", \"desc\": \"b\"}")
(bytes->jsexpr #"{\"word\": \"a\", \"desc\": \"b\"}")


(define port (if (getenv "PORT")
                 (string->number (getenv "PORT"))
                 8080))
(serve/servlet start
               #:servlet-path "/"
               #:listen-ip #f
               #:port port
               #:command-line? #t)