;; adding-machine.cl
;; Simple, but interactive, program.
;; Simon Heath
;; 28/05/2002
(defun adding-machine ()
   (let ((sum 0)
         next)
      (loop
         (setq next (read))
         (cond
            ((numberp next) (incf sum next))
            ((eq '= next) (print sum) (return))
            (t (format t "~&~A ignored!~%" next))))
      (values))) 
