#!/usr/local/bin/clisp
(defun random-line (x)
   (if (stringp x)
      (let ((a ()))
         (with-open-file (str x)
            (do ((line (read-line str) (read-line str nil nil)))
   	        ((null line) 'EOF)
    	      (push line a)))
         (format t "~A~%" (nth (random (length a)) a)))
   	 ;; args to DO: (do ((varname varinitial (varincrement))
   	 ;;                  (varname2 var2initial (varincrement2)))
   	 ;;                     ((end-cond-1) val-to-return)
   	 ;;                 'val-to-return)
      (error "Not a string: ~A" x)))

(random-line "Namex.txt")
