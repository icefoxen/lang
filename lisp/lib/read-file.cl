(defun read-file (x)
   (cond ((stringp x)
            (with-open-file (s x)
               (do ((line (read-line s) (read-line s nil 'eof)))
                   ((eq line 'eof) '-+*EOF*+-)
                 (format t "~&~A~%" line))))
         (t 
	    (format t "*** - file name must be a string"))))
