;; returns t if the first arg is an element of the second arg (which
;; has to be a list)
;; Simon Heath
;; 22/05/2002
(defun elementp (x lst)
   (cond
      ((null lst) nil)
      ((eq (first lst) x) t)
      (t (elementp x (rest lst )))))


