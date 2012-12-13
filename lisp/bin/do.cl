;; do.el
;; Kay, the 'do' function is like the 'for' function in C-based languages.
;; It's just a neater way to do a counter-controlled loop.
;; Simon Heath
;; 22/05/2002
(do
   (
      (counter 10 (- counter 1))
   ;; A variable, a starting value, and an action to take.
   )
   ((zerop counter) t)      ;; Test, and result to be returned.
   (print "Hello world!"))  ;; Action.
   ;; Hunh.  That's a sorta odd structure.
