(import (rnrs))

(define (fib x)
   (if (< x 2) 1 (+ (fib (- x 1)) (fib (- x 2)))))

(define (main args)
  (display (fib 40))
(newline))
(main #f)
