;; size.el
;; Returns the size of a list.
;; Only works right on flat lists.
;; ...Theres a primative 'length' that already does this.  Ah well, who cares?
;; Simon Heath
;; 22/05/2002
(defun size (x)
   (cond
      ((atom x) (print "Please enter a flat list")))
   (do
      ((length 0 (+ length 1))
      (part-x x (rest part-x)))
      ;; Variables set, now we do the condition
      ((null part-x) length)))
      ;; No operation; it happens as part of the variable operations.
