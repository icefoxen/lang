;; REP-loop.cl
;; Read-eval-print loop.  Awsome.
;; Simon Heath
;; 28/05/2002
(loop
   (terpri)
   (princ "READY-> ")
   (print (eval (read))))
