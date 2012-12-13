;; Simple ABC interperater.  from a book called "The Art of Lisp Programming".
;; Well, let's get started.
;; Simon Heath
;; 21/12/2002

;; Load a library for a binary tree --we use it for the symbol table.
(load "btree.lisp")

;; Get the top of a stack --helper function
(defun tos (stk)
   (if (null stk)
       nil
       (car stk)))

;; Flag to control debugging print statements
(setq *mybugs* nil)

;; continuation flag/variable
(setq mysave nil)

;; Symbol table
;; The symbol table is a searchable data structure that assigns a number to
;; each valid symbol.  In this case we're using a binary tree.
(setq *keytable* nil)

;; setup any initial requirements
(defun initialize ()
  (setq *myerrors* nil)) ; error-detected flag

;; if a complete structure is avaliable, execute it.
(defun execute (analyzed-list)
   (cond 
      (*myerrors* t)
      ((null analyzed-list) nil)
      (t
         (if *mybugs*             ; custom!  p142
	    (progn
	       (print "EXECUTE")  ; if needed, print what was evaluated
	       (princ analyzed-list)))
	 (terpri)
	 (eval analyzed-list)     ; then evaluate it
	 t)))                     ; return true

;; input string is scanned
;; Algebraic functions are removed and analyzed to reduce complexity of the
;; token list.
;; Lexical analysis of the list is then completed.
(defun analyze (input-string)
   (cond 
      (*myerrors* t)
      ((string-equal input-string "quit") nil) ; Interperater is finished
      (t
         (syntax 
	    (reduce-token-list
	       (scanner input-string))))))

;; This is just the read-translate-eval loop.
;; All symbols are delimited by a space.
;; A nil return from execute finishes the execution
(defun ABC ()
   (initialize)
   (princ "This is the ABC Interperater")
   (loop
      (setq *myerrors* nil)
      (terpri)
      (print "ABC> ")
      (if 
         (not
            (execute
	       (analyze
	          (read-line))))
         (return "End of ABC Interperater"))))

;; Define simpler tree lookup functions specific to the interperater.
;; We already know the only tree we're gonna be using is the symbol table,
;; so...
(defun insert (key value)
   (setq *keytable* (binsert key value *keytable*)))
(defun lookup (key)
   (blookup key *keytable*))
;; Build the keytable.
(insert "]" 37)
(insert "/" '(56 truncate))
(insert "+" '(55 +))
(insert ")" 57)
(insert "(" 54)
(insert "*" '(56 *))
(insert "," 30)
(insert "-" '(55 -))
(insert "->" 33)
(insert "put" 6)
(insert "=" '(53 =))
(insert ";" 32)
(insert ":" 31)
(insert "<" '(53 <))
(insert "if" 3)
(insert "else" 1)
(insert ">" '(53 >))
(insert "in" 4)
(insert "keys" 5)
(insert "to" 9)
(insert "select" 8)
(insert "[" 36)
(insert "write" 11)
(insert "while" 10)
(insert "{}" '(38 nil))  ; ???

;; Now we build the tokenizer and scanner
;; This extracts tokens delimited by a space.
(defun scanner (instring)
   (let*
      ((spacestring 
         (make-sequence '(vector character) 10 :initial-element #\space))
       (outlist nil)
       (pos2 (position #\space instring))
       (pos1 0)
       (stringend (length instring))
       (newstring spacestring))
      (loop
         (if (not pos2)  ; if no more spaces...
	    (setq pos2 stringend))
	 (setq newstring (subseq instring pos1 pos2)) ; get token
	 (cond ; Check to see if the string represents an integer...
	    ((digit-char-p (char newstring 0))
	     (push ; use 50 as the token value for an integer
	        (list '50 (parse-integer newstring)) 
		outlist))
             ; Find any keytable values
	     ((lookup newstring)
	      (push 
	         (lookup newstring) 
		 outlist))
	     ; Otherwise, must be a string value or new variable ID.
	     ; Use 49 as the token value.
	     (t
	      (push 
	         (list '49 newstring) 
		 outlist)))
         ; Check for end of scan operations
	 (if (eq pos2 stringend)
	    (return)) ; ???
         ; print out the scanner result if required.
	 (if *mybugs*
	    (progn
	       (print "SCANNER")
	       (princ outlist))) 
	 ; Update scan position
	 (setq pos1 (1+ pos2)
	       pos2 (position #\space instring :start pos1)))
     outlist))  ; Return the final list.

;; So we have lexical analysis --identifying and parsing symbols.
;; Now we need syntactic analysis: recognizing and evaluating expressions.
