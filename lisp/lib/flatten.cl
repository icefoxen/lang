;; flatten.el
;; more recursion, yay!
;; I might be getting the hang of this.
;; This flattens a list.
;; Simon Heath
;; 22/05/2002
(defun flatten (x)
   (cond
      ((flat x) x)  ;; if it's already flat, no worries.  Otherwise...
      (t (cons (first x) (flatten (rest x))))))  
      ;; grab the first atom, hang on to it while you flatten the rest
      ;; of the list, then stick it on.

      


