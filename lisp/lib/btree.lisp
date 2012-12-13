;; Binary tree using strings as a search key.
;; Simon Heath
;; 21/12/2002

;; Get key entry
(defun keyentry (btree)
   (car btree)) 

;; Get left branch of tree
(defun left (btree) (cadr btree))

;; Get right branch of tree
(defun right (btree) (caddr btree))

;; Set up tree structure
(defun build-btree (record leftvalue rightvalue)
   (list record leftvalue rightvalue))

;; Binary tree search.  Return nil if key not found
(defun blookup (key btree)
   (if (null btree)
     nil
     (let 
        ((testkey (car (keyentry btree))))
	   (cond
	      ((string-equal key testkey) 
	         (cdr (keyentry btree)))
	      ((string-lessp key testkey) 
	         (blookup key (left btree)))
	      (t
	         (blookup key (right btree)))))))

;; Insert new keyed data into the tree and return a new tree.
(defun binsert (key value btree)
   (let
     ((record (if (atom value)   ; let the value be a list or single value
                  (list key value)
		  (cons key value))))
      (if (null btree)           ; create a new tree
          (build-btree record '() '())
	  (let 
	    ((testkey (car (keyentry btree))))
	     (cond
	        ((string-equal key testkey) ; replace old value by new
		 (build-btree record (left btree) (right btree)))
		((string-lessp key testkey) ; less, so look left
		 (build-btree 
		    (keyentry btree)
		    (binsert key value 
		       (left btree)) 
		    (right btree)))
	        (t                          ; greater, so look right
		 (build-btree 
		    (keyentry btree)
		    (left btree)
		    (binsert key value (right btree)))))))))
