#lang racket


(require racket/trace)

;lista dummy de materias obrigatorias
(define cs '(101 102 103))

(define cs2 '("BIJ0207-15" "BIL0304-15" "BIK0102-15" "BCS0001-15" "BIS0005-15" "BIS0003-15" "BCJ0204-15" "BCL0306-15" "BCN0404-15" "BCN0402-15" "BCM0504-15" "BCJ0205-15" "BCL0307-15" "BCN0407-15" "BCM0505-15" "BCJ0203-15" "BCN0405-15" "BIN0406-15")
  

;lista dummy de materias cursadas
(define classes-taken '(103 104 105 106 102 107))





;lista dummy de notas
(define notas '(1 2 0 0 3 2))



;retorna indices de notas que nao sao f
(define (indices-notas-F notas)
  (let loop ([i 0] [r '()] [l notas])
    (cond
      [(null? l) r]
      [(not (= 0 (car l)))
       (loop (add1 i)
             (append r (list i)) 
             (cdr l))]
      [else (loop (add1 i)
                  r
                  (cdr l))])))


;retorna lista de matérias que nao tem nota f
(define (remove-classes-grade-F c)
  (let loop ([i 0] [r '()] [g (indices-notas-F notas)] [c c])
    (trace loop)
    (cond
      [(null? c) r]
      [(null? g) r]
      [(not (equal? i (car g)))
           (loop (add1 i) r g (cdr c))]
      [else (loop (add1 i)
                  (append r (list (car c)))
                  (cdr g)
                  (cdr c))])))



(trace indices-notas-F)
(trace remove-classes-grade-F)
(remove-classes-grade-F classes-taken)




;contar quantas matérias
; (apenas base, funçao incompleta)
(define (cc l)
  (let c ([n 0] [l l])
    (cond [(null? l) l]
          [(= n 0) 0]
          [else 1])))





;ver se primeiro esta na lista
;o: materias obrigatorias
(define (cc2? n)
  (let f ([n n] [o cs])
    (cond [(null? o) #f]
          [(= (car o) n) #t]
          [else (f n (cdr o))])))

