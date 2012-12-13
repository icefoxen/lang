;; Boolean function XOR - 
;; true + true = false, false + false = false,
;; true + false = true, false + true = true.
;; Simon Heath
;; 21/05/2002
(defun xor (x y)
   (cond
      ((and x y) nil)  ;; if x and y are true, return false.
      ((or x y) t)     ;; if x OR y are true, return true.
      (t nil)))        ;; otherwise, return false


