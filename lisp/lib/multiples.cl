;; Gives a list of multiples of any number, up to the second arg.
;; Simon Heath
;; 22/05/2002
(defun multiples (num top)
   (cond
      ((= top num) (list num))
      (t (cons max (multiples num (- top num))))))
      ;; This is just the same as 'evens.el', you just substitute
      ;; 'num' for the 2.


