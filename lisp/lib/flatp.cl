;; flatp.el
;; tests whether or not a list is flat.
;; This recursion will take some getting used to.
;; Simon Heath
;; 22/05/2002
(defun flatp (x)
   (cond
      ((null x) t)  ;; if the list is nil, it's flat.
      ((atom x) nil) ;; If it's an atom, it's not a list.  Invalid.
      ((and (atom (first x)) (flatp (rest x))) t)
      ;; ahh, the beef.  If the first of x is an atom, AND the rest of
      ;; it is flat, then it's true!  Hmm...
      (t nil)))  ;; Catch-all




