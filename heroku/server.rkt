#lang racket

(require racket/list
	 web-server/http
         web-server/servlet-env
         web-server/dispatch
	 json)





(define (response
	 #:code    [code/kw 200]
	 #:message [message/kw "OK"]
	 #:seconds [seconds/kw (current-seconds)]
	 #:mime    [mime/kw #f]
	 #:headers [headers/kw empty]
	 #:body    [body/kw empty])
  (define mime
    (cond ((string? mime/kw)
	   (string->bytes/utf-8 mime/kw))
          ((bytes? mime/kw)
           mime/kw)
	  (else
	   #f)))
  (define message
    (cond ((bytes? message/kw)
	   message/kw)
	  ((string? message/kw)
	   (string->bytes/utf-8 message/kw))
          (else
           #f)))
  (define body
    (cond ((string? body/kw)
	   (list (string->bytes/utf-8 body/kw)))
	  ((bytes? body/kw)
	   (list body/kw))
	  ((list? body/kw)
           body/kw)
	  (#t
	   body/kw)))
  (response/full
   code/kw
   message
   seconds/kw
   mime
   headers/kw
   body))
  



  
(define (get-courses req)
  (response #:body (jsexpr->string #hasheq((course1 . (1 2 3))))
	    #:mime "application/json"))


  
(define-values (go _)
  (dispatch-rules
   [("courses")  #:method "get" get-courses]
   [else ""]))



(define port (if (getenv "PORT")
                 (string->number (getenv "PORT"))
                 8080))


(serve/servlet go
               #:servlet-path "/"
               #:listen-ip #f
               #:port port
               #:servlet-regexp #rx""
               #:command-line? #t)



