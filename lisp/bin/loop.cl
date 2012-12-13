;; Whew, back on more familiar ground, ne?
;; Iterative functions.
;; I believe that what makes loops easier for me to understand is that
;; loops have a counter seperate from the operation.  Recursive functions
;; have the counter depend on PART of the operation.
;; Simon Heath
;; 22/05/2002
(setq counter 10)
(loop
   (print "Hello World!")
   (setq counter (- counter 1))
   (cond
      ((zerop counter) (return t))
      (t t)))
