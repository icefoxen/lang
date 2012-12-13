;; adding-machine2.cl
;; Fancier; redirects input and output streams.
;; Cool.
;; Simon Heath
;; 28/05/2002
(defun adding-machine2 (&optional (in-stream *standard-input*)
                                  (out-stream *standard-output*))
   (let ((sum 0)
         next)
      (loop
         (setq next (read in-stream))
	 (cond
	    ((numberp next) (incf sum next))
	    ((eq '= next) (print sum out-stream) (return))
	    (t (format out-stream "~&~A ignored!~%" next))))
      (values)))
