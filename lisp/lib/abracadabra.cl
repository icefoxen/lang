;; Abracadabra.el
;; Recursive silliness.
;; Simon Heath
;; 22/05/2002
(defun abracadabra (x)
   (print x)
   (cond
      ((null (rest x)) nil)
      (t (abracadabra (rest x)))))


