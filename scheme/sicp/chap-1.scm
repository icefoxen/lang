(define (abs x)
  (cond ((> x 0) x)
        ((< x 0) (- x))
        ((= x 0) 0)))

(define (abs2 x)
  (if (< x 0)
      (- x)
      x))

(define (do-sqrt x)
  (define (sqrt-iter guess x)
    (if (good-enough? guess x)
        guess
        (sqrt-iter (improve guess x) x)))
  
  (define (improve guess x)
    (average guess (/ x guess)))
  
  (define (average x y)
    (/ (+ x y) 2))
  
  (define (good-enough? guess x)
    (< (abs (- (* guess guess) x)) 0.0000001))
  
  (sqrt-iter (/ x 3.0) x))