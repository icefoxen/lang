(defun get-elapsed-time (x)
   (- (get-universal-time) x))
(loop
(let ((start-time (get-universal-time)) (attention-span 5))
   (loop
      (let ((elapsed-time (get-elapsed-time start-time)))
         (cond 
	   ((> attention-span elapsed-time) 
             (format t "Time is: ~A~%" elapsed-time))
	   ((< attention-span elapsed-time)
             (format t "Attention span exceeded: ~A~%" elapsed-time)
             (return t)))))))
