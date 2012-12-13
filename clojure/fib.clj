(defn fib [x]
   (if (< x 2) 
      1 
      (+ (fib (- x 1)) (fib (- x 2)))))

(print (fib 40))
(print "\n")
