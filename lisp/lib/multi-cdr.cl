;; Multi-cdr.el
;; Recursion and list-sorting goodness!
;; Enter a list and a number, and it'll 'rest' down to that number
;; and show you the list.  Wohoo!
;; This is fun.  ;-D
;; Simon Heath
;; 22/05/2002
(defun multi-cdr (x y)
   (cond
      ((eq y 1) x)  ;; If you've hit the atom you want, print it...
      (t (multi-cdr (rest x) (- y 1)))))
      ;; Otherwise, create a new instance with one less atom and
      ;; one less atom to go to.


