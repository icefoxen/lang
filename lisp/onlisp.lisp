;; Not the simplest way to do it, but 'tis tail-recursive at least.
(defun group (source n)
   (if (zerop n) (error "Zero length"))
   (labels ((rec (source acc)  ;; Like letrec...
               (let ((rest (nthcdr n source)))
	          (if (consp rest)
		      (rec rest (cons (subseq source 0 n) acc))
		      (nreverse (cons source acc))))))
      (if source 
         (rec source nil) 
         nil)))
