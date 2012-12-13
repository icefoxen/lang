;; fib2.cl
;; Uses a stack and an iterative loop to list out the fibonacci sequence.
;; Simon Heath
;; 25/05/2002
(defun fib2 (x)
   (setq stack '(1 1))
   (cond
      ((integerp x) t)
      (t (return "The argument must be a number")))
      ;; That sanity-check is IMPORTANT!  If the argument isn't a number,
      ;; the zerop 7 lines down will ALWAYS return NIL!!!
   (loop
      (push (+ (car stack) (cadr stack)) stack)
      ;; grabs the first and second values of the stack, adds them, then pushes
      ;; the result.
      (setq x (1- x)) ; counter
      (cond
         ((zerop x) (return stack))
	 (t t))))
