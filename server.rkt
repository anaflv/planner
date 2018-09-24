#lang racket

(require racket/list
	 web-server/http
         web-server/servlet-env
         web-server/dispatch
	 json)

(require "../courses-json.rkt"
         "../ufabc-classes.rkt")



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
  (hash-ref a 'bi ""))

(define (get-user-post-bi a)
  (hash-ref a 'postBi ""))


(define (get-user-classes a id)
  (define usr-classes-hash
    (string->jsexpr
           (hash-ref a 'classes "")))
  (define c (make-course-list
             usr-classes-hash))
  (define to-do
    (filter-to-do c id))
  (define limited
    (filter-lim c id))
  (define specific
    (filter-specific c id))
  (define mandatory
    (filter-bi c 100))
  (define free (filter-free c mandatory specific))
  (make-hash (list
              (cons 'especificas
                    (course/hash (get-names specific)))
              (cons 'obrigatorias
                    (course/hash (get-names mandatory)))
              (cons 'limitadas
                    (course/hash (get-names limited)))
              (cons 'todo
                    (course/hash (get-names to-do)))
              (cons 'livres
                    (course/hash (get-names free))))))







(define (get-course-data req)
  (let ([data/bytes (request-post-data/raw req)])
    (let ([data (bytes->jsexpr data/bytes)])
      (define post-bi (get-user-post-bi data))
      (response #:body  (jsexpr->string (get-user-classes data post-bi))
                #:mime "application/json"
                #:headers jhead))))




(define (symbolify x)
  (string->symbol (format "~a" x)))




(define (not-allowed req)
  (response #:code 405
	    #:message "Method Not Allowed"))

(define (not-found req)
  (response #:code 404
	    #:message "Not Found"))


(define-values (go _)
  (dispatch-rules
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


