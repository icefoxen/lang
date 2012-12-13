;; check-sys.cl
;; One of those demo-programs.
;; I need the practice.
;; Simon Heath
;; 29/05/2002
(defvar *checks* (make-array 100 :adjustable t :fill-pointer 0)
   "A vector of checks.")

(defconstant +first-check-number+ 100 "The number of the first check.")

(defvar *next-check-number* +first-check-number+ 
   "The number of the next check.")

(defvar *payees* (make-hash-table :test #'equal) 
   "Payees with checks paid to each")

(defstruct check number date amount payee memo)

(defun current-date-string ()
   "Returns the current date as a string"
   (multiple-value-bind (sec min hr day mon yr dow dst-p tz)
                        (get-decoded-time)
      (declare (ignore sec min hr dow dst-p tz))
      (format nil "~A-~A-~A" yr mon day)))

(defun write-check (amount payee memo)
   "Writes the next check in the sequence"
   (let ((new-check (make-check :number *next-check-number*
                                :date (current-date-string)
				:amount amount
				:payee payee
				:memo memo)))
   (incf *next-check-number*)
   (vector-push-extend new-check *checks*)
   (push new-check (gethash payee *payees*))
   new-check))

(defun get-check (number)
   "Returns a check given it's number, or NIL if no such check."
   (when 
      (and
         (<= +first-check-number+ number)
	 (< number *next-check-number*))
      (aref *checks* (- number +first-check-number+))))

(defun void-check (number)
   "Voids a check and returns T.  Returns NIL if no such check."
   (let ((check (get-check number)))
   (when check
      (setf (gethash (check-payee check) *payees*)
            (delete check (gethash (check-payee check) *payees*)))
      (setf (aref *checks* (- number +first-check-number+)) nil)
      t)))

(defun list-checks (payee)
   "Lists all of the checks written to the payee."
   (gethash payee *payees*))

(defun list-all-checks ()
   "List all checks written"
   (coerce *checks* 'list))

;; (defun sum-checks
;;    (let (( total 0 ))
;;       (map nil #'(lambda (check)
;;                     (when check
;;         	       (incf total (check-amount check))))
;;                  *checks*)
;;        total))

(defun list-payees ()
   "Lists all payees."
   (let ((payees ()))
      (maphash #'(lambda (key value)
                    (declare (ignore value))
		    (push key payees))
		 *payees*)
      payees))

(defmacro def-i/o (writer-name reader-name (&rest vars))
   (let ((file-name (gensym))
         (var (gensym))
	 (stream (gensym)))
      `(progn
         (defun ,writer-name (,file-name)
	    (with-open-file (,stream ,file-name
	                     :direction :output :if-exists :supersede)
            (dolist (,var (list ,@vars))
	       (declare (special ,@vars))
	       (print ,var ,stream))))
	  (defun ,reader-name (,file-name)
	     (with-open-file (,stream ,file-name
	                      :direction :input :if-does-not-exist :error)
                (dolist (,var ',vars)
		   (set ,var (read ,stream)))))
	  t))) 
