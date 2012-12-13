#!/usr/local/bin/clisp
;; This defines a set of functions that build a telephone directory.
;; Input and output, donchaknow.
;; Simon Heath
;; 22/05/2002
(defun init ()
   (format t "~2%Telephone index being initialized")
   (setq tel-index nil))
   ;; ~2% means to skip two lines

(defun add ()
   (format t "~2%New entry; enter name then number~%")
   (setq tel-index (append tel-index (cons (read) (cons (read) nil)))))

(defun build ()
   (add)
   (cond
      ((y-or-n-p "Any more?") (build))
      (t t)))

(init)
(build)
(format t "~%~A" tel-index)
