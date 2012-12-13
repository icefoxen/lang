;; Uses elementp to test if a list is a set.
;; A set never has two of the same atom in it.
;; Simon Heath
;; 22/05/2002
(defun setp (lst)
   (cond
      ((null lst) t)   ;; Have you cdr'd the list down to nothing?
      ((elementp (first lst) (rest lst) nil)
      ;; Does a copy of the first atom exist in the rest of the list?
      (t (setp (rest lst)))))
      ;; Well then, chop off the first atom and recurse.


