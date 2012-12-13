;; This is part of an example for making packages.
;; Simon Heath
;; 28/05/2002
(defpackage util2 
   (:export init func1 func2)
   (:use common-lisp))
(in-package util2)

(defun init () 'util2-init)
(defun func1 () 'util2-func1)
(defun func2 () 'util2-func2)
