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



(define n
  (list "a" "b" "c"))


(define jhead
  (list (make-header #"Access-Control-Allow-Credentials"
                    #"true")
        (make-header #"Access-Control-Allow-Origin"
                    #"*")
        (make-header #"Access-Control-Allow-Headers"
                    #"*")))






(define (assoc/course a)
   (make-hash (list (cons 'codigo a))))


;criar lista json de associacoes
(define courses/result
  (let loop ([t n] [r '()])
    (cond [(null? t) r]
          [else (loop (cdr t)
                      (append r
                              (list (assoc/course
                                     (car t)))))])))



(jsexpr->string courses/result)




(define (get-user-bi a)
  (print (hash-ref a 'bi ""))
  (hash-ref a 'bi' ""))

(define (get-user-classes a)
  (print (hash-ref a 'classes ""))
  (hash-ref a 'classes ""))



(define (get-course-data req)
  (let ([data/bytes (request-post-data/raw req)])
    (let ([data (bytes->string/utf-8 data/bytes)])
      (let ([data/string (string->jsexpr data)])
        (get-user-bi data/string)
        (get-user-classes data/string)
        )))
  (response #:body (jsexpr->string courses/result)
	    #:mime "application/json"
            #:headers jhead))




(define (get-courses req)
  (print req)
  (response #:body (jsexpr->string courses/result)
	    #:mime "application/json"
            #:headers jhead))







(define database (hash 'a 1))


(define (symbolify x)
  (string->symbol (format "~a" x)))




(define (get-catalog-item req x)
      (response #:body (jsexpr->string courses/result)
                #:mime "application/json"
                #:headers jhead))



(define-values (go _)
  (dispatch-rules
   [("courses")  #:method "get" get-courses]
   [("courses" (string-arg)) #:method "post" get-catalog-item]
   [("courses")  #:method "post" get-course-data]
  ; [("courses2") get-courses]
   ;[else get-courses]
   ))



(define port (if (getenv "PORT")
                 (string->number (getenv "PORT"))
                 8080))




(serve/servlet go
               #:servlet-path "/"
               #:listen-ip #f
               #:port port
               #:servlet-regexp #rx""
               #:command-line? #t)



