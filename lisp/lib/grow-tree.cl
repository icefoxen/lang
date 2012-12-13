;; grow-tree.el
;; This function creates a tree data structure with numerical elements.
;; It is a binary tree -each node has no more than two branches.
;; It operates on the simple basis that if a new node is built with a value
;; higher than it's root, it is the right branch, otherwise it is the left
;; branch.  It can be used for text data as well, but that would require 
;; functions for alphabetical comparison.  But it can be sorted very easily,
;; akin to a binary-sort algorithm.
;; Simon Heath
;; 24/05/2002
(defun value (x) (first x))

(defun left-subtree (x) (first (rest x)))

(defun right-subtree (x) (first (rest (rest x))))

(defun make-tree (value left right)
   (list value left right))

(defun grow-tree (x tree)
   (cond
      ((null tree) (make-tree x nil nil))
      ((= x (value tree)) tree)  ;; if x = root value, do nothing
      ((< x (value tree))   ;; if x < root value, make a new subtree
            (make-tree (value tree) 
	               (grow-tree x (left-subtree tree))
		       (right-subtree tree)))
      (t (make-tree (value tree) 
                    (left-subtree tree) 
		    (grow-tree x (right-subtree tree))))
		    ))
