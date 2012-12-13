;; Add-list.cl
;; Just adds up all the elements of a list
;; Simon Heath
;; 27/05/2002
(defun add-list (list)
   (cond
      ((= 1 (length list)) (first list))
      (t (+ (first list) (add-list (rest list))))))
