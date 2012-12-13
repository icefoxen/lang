;; Kay, this tests if something is an atom or a list,
;; and if it ain't, returns the thing.
;; Simon Heath
;; 21/05/2002
(defun test (x)
   (cond
      ((numberp x) 'number)   ;; If it's a number, return 'number'
      ((atom x) 'atom)        ;; If it's an atom, return 'atom'
      (t x)))                 ;; otherwise, return it.


