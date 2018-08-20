#lang racket

(require racket/list
	 web-server/http
         web-server/servlet-env
         web-server/dispatch
	 json)

(require "../courses-json.rkt" )
(require "../ufabc-classes.rkt")




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



(define jhead
  (list (make-header #"Access-Control-Allow-Credentials"
                    #"true")
        (make-header #"Access-Control-Allow-Origin"
                    #"*")
        (make-header #"Access-Control-Allow-Headers"
                    #"*")))



(define (get-user-bi a)
  (print (hash-ref a 'bi ""))
  (hash-ref a 'bi' ""))



(define (get-user-classes a)
  (define usr-classes-hash
    (string->jsexpr
           (hash-ref a 'classes "")))
  (define c (make-course-list
             usr-classes-hash))
  (define specific (filter-specific c))
  (define mandatory (filter-bi c))
  (define free (filter-free c mandatory specific))

  

  (make-hash (list
              (cons 'especificas
                    (course/hash (get-names specific)))
              (cons 'obrigatorias
                    (course/hash (get-names mandatory)))
              (cons 'livres
                    (course/hash (get-names free))))))



(define (get-course-data req)
  (let ([data/bytes (request-post-data/raw req)])
    (let ([data (bytes->jsexpr data/bytes)])
      (print (jsexpr->string (get-user-classes data)))
      (response #:body  (jsexpr->string (get-user-classes data))
                #:mime "application/json"
                #:headers jhead))))


(define (get-courses req)
  (print req)
  (response #:body (jsexpr->string courses/result)
	    #:mime "application/json"
            #:headers jhead))



(define (symbolify x)
  (string->symbol (format "~a" x)))


(define (get-catalog-item req x)
      (response #:body (jsexpr->string courses/result)
                #:mime "application/json"
                #:headers jhead))


(define (not-allowed req)
  (response #:code 405
	    #:message "Method Not Allowed"))

(define (not-found req)
  (response #:code 404
	    #:message "Not Found"))

(define (bad-request)
  (response #:code 400
            #:message "Bad Request"))

(define (internal-server-error)
  (response #:code 500
            #:message "Internal Server Error"))


(define-values (go _)
  (dispatch-rules
   [("courses")  #:method "get" get-courses]
   [("courses")  #:method "post" get-course-data]
   [else not-found]
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



