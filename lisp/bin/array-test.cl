;; Array-test.cl
;; Just messes with arrays a little.
;; Simon Heath
;; 27/05/2002
(setq array1 (make-array '(4 5)))
(dotimes (a 4)
   (dotimes (b 5)
      (setf (aref array1 a b) (list a b))))

(format t "~2%Array 'array1' created.  Values:~%~A~2%" array1)
