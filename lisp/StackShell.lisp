#!/usr/local/bin/clisp
;#!/lisp.run -norc --quiet -M sysinterp.lim
;; StackShell.lisp
;; A stack-based shell.
;; 'Tis a bit odd to work with, and rather un-featureful,
;; But it is VERY simple to program.
;; Lexers are a pain to program.
;; Simon Heath
;; 25/1/2002


; Package and constant setup

(defpackage :APP)
(in-package :APP)
(use-package :CL-USER)

(defconstant *version* 0.1)

(defparameter *stack* ())

(defparameter *funcs* ())
; I'd LIKE to make this a hash-table.  But there are problems with that,
; starting with the fact that (gethash) compares values with #'eql and has no
; :TEST keyword, moving on to the fact that my program takes input data as
; strings, and generally spiralling out from there.
; So we'll use an assoc list instead.  Since assoc DOES have a :TEST keyword.


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; HELPER FUNCTIONS

; These functions make other functions work

(defun remove-comment (str)
   "Removes a one-line comment from a line, starting with ;"
   (if (search ";" str)
      (let ((c (search ";" str)))
         (subseq str 0 c))
      str))


(defun string-split (str seq &optional lst)
   "Splits arg0 into a list, delimited by arg1"
   (if (search seq str)
      (let* ((c (search seq str))
             (initial (subseq str 0 c))
	     (final (subseq str (+ 1 c))))
         (string-split final seq (cons initial lst)))
      (cons str lst)))

(defun getprompt ()
   "Returns the command-line prompt complete with escape sequences."
   (let ((str (system::getenv "PROMPT")))
      (if str
	 str
         "--> ")))    ;; If no PROMPT var, return default prompt


(defun add-func (name func)
   "Add an entry to the function assoc list"
   (setf *funcs*
      (cons (list name func) *funcs*)))

(defun get-func (func)
   "Gets a function from the function assoc list"
   (cadr (assoc func *funcs* :test #'equal)))

(defun get-keys (alist)
   "A bit of magic that returns a list of keys in an assoc tree"
    (mapcar #'car alist))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; STACK MANIPULATION FUNCTIONS

; They're probably all horribly non-functional, but...

(defun dup ()
   (let ((a (pop *stack*)))
      (push a *stack*)
      (push a *stack*)))

(add-func "dup" #'dup)


; Mustn't redefine primatives!!!
(defun pop2 ()
   (pop *stack*))

(add-func "pop" #'pop2)


(defun swap ()
   (let* ((a (pop *stack*))
          (b (pop *stack*)))
      (push a *stack*)
      (push b *stack*)))

(add-func "swap" #'swap)


;; Gotta be a better way to do this, but I dun wanna bother
(defun rot ()
   (if (<= 3 (list-length *stack*))
      (let* ((fst (pop *stack*))
            (sec (pop *stack*))
	    (thd (pop *stack*)))
         (push fst *stack*)
	 (push thd *stack*)
	 (push sec *stack*))))

(add-func "rot" #'rot)


(defun over ()
   (swap)
   (dup)
   (rot))

(add-func "over" #'over)


(defun clear ()
   (setf *stack* ()))

(add-func "clear" #'clear)


(defun depth ()
   (push (list-length *stack*) *stack*))

(add-func "depth" #'depth)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; USER FUNCTIONS

; Features, basically.


;; Mathematical operators
;; Gah... the string-to-number functions are all screwy.
(defun add ()
   (push (+ (parse-integer (pop *stack*)) 
            (parse-integer (pop *stack*))) *stack*))

(add-func "add" #'add)


(defun sub ()
   (push (- (pop *stack*) (pop *stack*)) *stack*))

(add-func "sub" #'sub)


(defun mul ()
   (push (* (pop *stack*) (pop *stack*)) *stack*))

(add-func "mul" #'mul)


(defun div ()
   (push (/ (pop *stack*) (pop *stack*)) *stack*))

(add-func "div" #'div)


(defun mod2 ()
   (push (mod (pop *stack*) (pop *stack*)) *stack*))

(add-func "mod" #'mod2)


(defun eq2 ()
   (push (equal (pop *stack*) (pop *stack*)) *stack*))

(add-func "eq" #'eq2)


(defun var ()
   "Binds new environment variable"
   (swap)
   (system::setenv (pop *stack*) (pop *stack*)))

(add-func "var" #'var)


(defun join ()
   "Joins two items on the stack"
   (push
      (concatenate 'string 
         (string (pop *stack*)) 
	 " " 
	 (string (pop *stack*)))
      *stack*))

(add-func "join" #'join)


;; A macro could probably do this better...  But at least this works
(defun ex ()
   "Executes a program with the stack as arguments"
   (let ((proglist (list 'system::execute (pop *stack*))))
      (dolist (x *stack*)
         (setf proglist (append proglist (list x))))
      (eval proglist))
   (clear))

(add-func "ex" #'ex)

(defun help ()
   "Prints the help message"
   (format t "This is StackShell version ~A.
The commands are based on Forth and Postscript.  Command are:
~A
Anything else is treated as data and pushed onto the stack.  There are only
two data types: strings and integers.
To force something to be data, prefix it with a \\.  For instance, typing
\\pop will push \"pop\" onto the stack.
Comments start with a semicolon (;) and continue till the end of the line.
To create an environment variable, enter it's name, the value, and the \"var\"
command."
      *version*
      (get-keys *funcs*)))

(add-func "help" #'help)


(defun exit2 ()
   (system::exit))

(add-func "exit" #'exit2)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SYSTEM FUNCTIONS

; The user never touches these.

;; Lexer --splits a string into a list of strings and seperates
;; the comments
(defun parse-input (str)
   (reverse (string-split (remove-comment str) " ")))


;; Evaluates the stack given to it
(defun eval-stack (stk)
   (dolist (item stk)
      (cond 
         ;; If item is a number, push it as such.
	 
         ;; If item is a literal, chop off the \ and push it.
         ((char-equal #\\ (char item 0))
	  (push (string-left-trim "\\" item) *stack*))

	 ;; If item is a function, execute it.
         ((get-func item)
          (funcall (get-func item)))

	 ;; If all else fails, it's a value, so push it.
	 (t (push item *stack*)))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MAINLOOP

; Executes the program.

(format t "Stackshell version ~A~%" *version*)
(loop
   (format t "Stack: ~A~%~A" *stack* (getprompt))
   (eval-stack (parse-input (read-line))))
