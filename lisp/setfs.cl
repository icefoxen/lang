(setf *print-circle* t)


(defstruct myfile
  :name
  :sets)

(defun myfile-compare (a b)
  (string< (myfile-name a) (myfile-name b)))


(defstruct fileset
  :name 
  :files)

(defun fileset-compare (a b)
  (string< (fileset-name a) (fileset-name b)))

(setf a (vector 0 1 2 3 4 5 6 7 8 9))
(setf s1 (make-fileset :name "Foo" :files #()))
(setf s2 (make-fileset :name "Bar" :files #()))

(setf f1 (make-myfile :name "File1" :sets #()))
(setf f2 (make-myfile :name "File2" :sets #()))

(defun binary-search (itm array)
  (flet ((binary-search-helper (startbound endbound)
    ;(format t "Start ~A, end ~A~%" startbound endbound)
    (if (= startbound endbound)
      (= (aref array startbound) itm)
      (let* ((middle-index 
               (+ startbound (truncate (/ (- endbound startbound) 2))))
             (item-in-middle (aref array middle-index)))
        (cond 
          ((= item-in-middle itm) 
           t)
          ((> item-in-middle itm) 
           (binary-search-helper startbound middle-index))
          ((< item-in-middle itm) 
           (binary-search-helper (1+ middle-index) endbound)))))))

    (if (= 0 (array-total-size array))
      nil
      (binary-search-helper 0 (1- (array-total-size array))))))


(defun file-has-set (file set)
  (binary-search set (myfile-sets file)))

(defun set-has-file (set file)
  (binary-search file (fileset-files set)))

; Optimization: Insert items in-place instead of append-sort
(defun insert-file (file set)
  (let ((new-array (concatenate 'vector (fileset-files set) (vector file))))
    (sort new-array #'myfile-compare)
    (setf (fileset-files set) new-array)))

(defun insert-set (set file)
  (let ((new-array (concatenate 'vector (myfile-sets file) (vector set))))
    (sort new-array #'fileset-compare)
    (setf (myfile-sets file) new-array)))


; ...Lisp apparently abhors a loop.  -_-
; Or at least, its print routine does.
(defun add-file-to-set (file set)
  (if (not (file-has-set file set))
    (progn
      (insert-file file set)
      (insert-set set file))))


