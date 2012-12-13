;; Hmm... Actually, the do function can do rather more...
;; You can iterate multiple variables at the same time, and evaluate them
;; with the function of your choosing...
(do ((which 1 (1+ which))  ;; (var-name initial-value evaluation)
     (list '(foo bar baz qux) (rest list)))
    ((null list) 'done)  ;; Return condition (End-test result, as the book sez)
    (format t "~&Item ~D is ~S.~%" which (first list)))  ;; Action
