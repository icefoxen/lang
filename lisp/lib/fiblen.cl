;; fiblen.el
;; This should give you the number of recursion calls needed to
;; calculate the fibonacci number.
;; Simon Heath
;; 22/05/2002
(defun fiblen (x)
   (cond
   ((listp x) nil)  ;; Is it a list?  It shouldn't be...
   ((not (numberp x)) nil) ;; Better be a number, too!
   ;; Everything sane?  Good, let's get on with it.
   ((eq (x 0)) x)    ;; Base case 1...
   ((eq (x 1)) x)    ;; Base case 2...
   (t (+ 1 (+ (fiblen (- x 1)) (fiblen (- x 2)))))))
   ;; Kay.  I THINK this'll do the trick.




