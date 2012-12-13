(define (fact x cont)
   (if (< x 2)
      (cont 1)
      (fact (- x 1) 
            (lambda (newx) (cont (* x newx))))))

(define (fact2 x)
  (if (< x 2)
      1
      (* x (fact2 (- x 1)))))
