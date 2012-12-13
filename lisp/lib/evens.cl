;; kay, now we're working with sets.  a set is a list of numbers
;; that is flat and has no repetitions.
;; This function prints out all even numbers up to it's argument.
;; Simon Heath
;; 22/05/2002
(defun evens (x)
   (cond
      ((= x 2) '(2))
      (t (cons x (evens (- max 2))))))


