;; Network as in Chap 6 of On Lisp

#|
(defstruct node contents yes no)
(defvar *nodes* (make-hash-table))

;; Wrapper function for make-node
(defun defnode (name conts &optional yes no)
   (setf (gethash name *nodes*)
      (make-node :contents conts
                 :yes yes
		 :no no)))

;; Traverser for nodes
;; Asks the question in the node; if response is yes, recurse and go to
;; node-yes.  Else, go to node-no
(defun run-node (name)
   (let ((n (gethash name *nodes*)))
     (cond ((node-yes n)
              (format t "~A~%>> " (node-contents n))
	      (case (read)
	         (yes (run-node (node-yes n)))
		 (t (run-node (node-no n)))))
           (t (node-contents n)))))


;; To run, eval (run-node 'people)
|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Previous code could be written in any language.  Typical imperitive way of
;; doing things.  Now we write it as a closure, with data and functions 
;; combined.

(defvar *nodes* nil)

(defun defnode (&rest args)
   (push args *nodes*)
   args)

(defun compile-net (root)
   (let ((node (assoc root *nodes*)))
      (if (null node)
          nil
	  (let ((conts (second node))
	        (yes (third node))
		(no (fourth node)))
             (if yes
	        (let ((yes-fn (compile-net yes))
		      (no-fn (compile-net no)))
		   #'(lambda ()
		       (format t "~A~%>> " conts)
		       (funcall (if (eq (read) 'yes)
		                     yes-fn
				     no-fn))))
                 #'(lambda () conts)))))) 

;; To run, exec (funcall (gethash 'people *nodes*))


;; Simple network/tree(?!) for playing Twenty Questions
(defnode 'people "Is this person a man?" 'male 'female)
(defnode 'male "Is he living?" 'liveman 'deadman)
(defnode 'deadman "Was he an American?" 'us 'them)
(defnode 'us "Is he on a coin?" 'coin 'cidence)
(defnode 'coin "Is the coin a penny?" 'penny 'coins)
(defnode 'penny 'lincoln)
