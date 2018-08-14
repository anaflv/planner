#lang racket

(require web-server/servlet
         web-server/servlet-env)

(define (start req)
  (response/xexpr
   '(html (head (title "Racket Heroku App"))
          (body (h1 "It works!")))))

(serve/servlet start #:servlet-path "/")

