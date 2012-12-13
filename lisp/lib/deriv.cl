(defun deriv (var expr)
   (if (atom expr)
      (if (eq expr var)
         1
	 0)
      (let ((operator (first expr))
            (arg1 (second expr))
	    (arg2 (third expr)))
         (cond  ;; Could be CASE instead
	    ((eq operator '+) (deriv-add var arg1 arg2))
	    ((eq operator '*) (deriv-mult var arg1 arg2))
	    ((eq operator '/) (deriv-div var arg1 arg2))
	    ((eq operator 'expt) (deriv-expt var arg1 arg2))
	    (t (error "Unknown operator: ~A" operator))))))

(defun deriv-add (var arg1 arg2)
   (list '+ (deriv var arg1) arg2))

(defun deriv-mult (var arg1 arg2)
   (list '+
      (list '* arg2 (deriv var arg1))
      (list '* arg1 (deriv var arg2))))

(defun deriv-div (var arg1 arg2)
   (list '/
      (list '-
         (list '* arg2 (deriv var arg1))
	 (list '* arg1 (deriv var arg2)))
      (list 'expt arg2 2)))

(defun deriv-expt (var arg1 arg2)
   (list '*
      (list '* arg2 (list 'expt arg1 (list '- arg2 1)))
      (deriv var arg1)))
