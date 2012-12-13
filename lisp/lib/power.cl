;; Intro to recursion.
;; accepts two args, x and n.  Performs x^n.
;; Simon Heath
;; 21/05/2002
(defun power (x n)
   (cond
      ((zerop n) 1)  ;; Anything^0 = 1
      (t (* x (power x (- n 1))))
      ;; Otherwise, it's equal to x^(n-1)  Eventually, n will run down to 0.


