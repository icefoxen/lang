(define factorial (lambda (n) (if (= n 0) 1
                                    (* n (factorial (- n 1))))))
(display "Enter a number to factorize ")
(display (factorial (read)))
