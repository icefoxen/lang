;; fib.el
;; should give you number in the fibonacci sequence entered.
;; eg. (fib 5) gives you the 5th number in the seq.
;; Simon Heath
;; 22/05/2002
(defun fib (x)
   (cond
   ((listp x) nil)  ;; Is it a list?  It shouldn't be...
   ((not (numberp x)) nil) ;; Better be a number, too!
   ;; Everything sane?  Good, let's get on with it.
   ((eq (x 0)) x)    ;; Base case 1...
   ((eq (x 1)) x)    ;; Base case 2...
   (t (+ (fib (- x 1)) (fib (- x 2))))))




