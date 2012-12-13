; Use with MIT/GNU scheme
(declare (usual-integrations))

(define (fib x)
   (if (< x 2) 1 (+ (fib (- x 1)) (fib (- x 2)))))

(runtime)
(fib 40)
(runtime)
