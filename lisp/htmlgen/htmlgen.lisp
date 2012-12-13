;; Should all be compliant with XHTML 1.0/strict
;; This is not idiot-proof; idiots should not be making webpages,
;; let alone hacking Lisp.
;; I just wanna make the damn stuff easier to read and work with.
;; ...well, the HTML it produces ain't gonna be pretty.  But it should be
;; correct at least.  I should run it thru HTMLLint afterwards to clean it up.


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  CONSTANTS


;; Standard doctype
(defparameter *doctype* "
<?xml version=\"1.0\" encoding=\"iso-8859-1\"?>
<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">
")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  HELPER FUNCTIONS

;; Turns a list of (key . value) pairs into a string of key="value" pairs.
;; On nil returns an empty string
(defun build-opts (opts)
   (if opts
      (let ((final ""))
         (dolist (item opts)
            (setf final (concatenate 'string
                           final 
                           " \"" (string (car item)) "\"=\""
                                 (string (cdr item)) "\"")))
      final) ;; If opts != nil, eval and return string
      ""))   ;; Else return empty string


;; Returns an empty string on nil
;; Also builds a string out of a list of html funcs, simply by evaluating
;; them and catting the results together.
;; It should also turn <, > and & at least into the appropriate sequence.
;; Something to work on later
(defun build-body (body)
   (if body
      (let ((final ""))
         (dolist (item body)
            (setf final (concatenate 'string
	                   final
			   " " 
			   (string item))))
         final)
      ""))


;; Returns a string enclosed by the specified tag with the specified options
(defun tag (tag opts body)
   (if body                  ;; If body exists, build a full tag
      (concatenate 'string
         "<"
         (string-downcase (string tag))
         (build-opts opts)   ;; Returns empty if opts is nil
         "> "
         (build-body body)
         " </"
         (string-downcase (string tag))
         ">
")              ;; ...newline??
      (concatenate 'string   ;; otherwise, build a short tag, ie <br />
         " <"
         (string-downcase (string tag))
         (build-opts opts)
         " />
")))


;; test this!
;(defcustom *html-chars* 
;   list '((#\< . "&lt;") (#\> . "&gt;") (#\& . "&amp;"))
;   "The characters which must be replaced before putting a string into HTML.") 



;; Can this do what I think it can, and build the entire freakin' suite of
;; functions??
;; Apparently not.  Meh.

;(defmacro build-tag-funcs (foo)
;   (if foo
;      (progn (list 'defun (car foo) '(opt &rest body)
;                `(tag ,(car foo) opt body))
;             (build-tag-funcs (cdr foo)))
;      nil))




;; Sample
(defun ex ()
(princ *doctype*)
(princ
(html 
 (head 
  (title  "Simon's page")
  (meta '(("name" . "generator") ("content" . "S's HTMLGEN 0.1")))
  (link '(("rel" . "stylesheet") ("type" . "text/css") ("href" . "style1.css"))))
 (body '(("bgcolor" . "#CCCCCC"))
    (p () "This is a " (b "test") "page.")
    (br)
    (p () "Ain't that" (i "nice?"))))))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; All the tags and such


;; Comments work a tad differently.
(defun comment (&rest body)
   (concatenate 'string 
      "<!--  " 
      (build-body body) 
      "  -->  
"))


;; These are seperate 'cause they need commented text

;; Stylesheet decleration
(defun style (body)
   (tag 'style '(("type" . "text/css")) ;; like there's another kind??
      (comment body)))

(defun script (opts body)
   (tag 'script opts (comment body)))



; tags that take opts
(defun meta (opt &rest body)
   (tag 'meta opt body))

(defun link (opt &rest body)
   (tag 'link opt body))

(defun body (opt &rest body)
   (tag 'body opt body))

(defun p (opt &rest body)
   (tag 'p opt body))

(defun span (opt &rest body)
   (tag 'span opt body))

(defun div (opt &rest body)
   (tag 'div opt body))

(defun a (opt &rest body)
   (tag 'a opt body))

(defun img (opt &rest body)
   (tag 'img opt body))

(defun table (opt &rest body)
   (tag 'table opt body))

(defun form (opt &rest body)
   (tag 'form opt body

(defun tr (opt &rest body)
   (tag 'tr opt body))

(defun td (opt &rest body)
   (tag 'td opt body))

(defun ul (opt &rest body)
   (tag 'ul opt body))

(defun ol (opt &rest body)
   (tag 'ol opt body))

(defun li (opt &rest body)
   (tag 'li opt body))


;; Tags that don't take options
(defun html (&rest body)
   (tag 'html () body))

(defun head (&rest body)
   (tag 'head () body))

(defun title (&rest body)
   (tag 'title () body))

(defun br (&rest body)
   (tag 'br () body))

(defun b (&rest body)
   (tag 'b () body))

(defun i (&rest body)
   (tag 'i () body))

(defun u (&rest body)
   (tag 'u () body))

(defun em (&rest body)
   (tag 'em () body))

(defun strong (&rest body)
   (tag 'strong () body))

(defun h1 (&rest body)
   (tag 'h1 () body))

(defun h2 (&rest body)
   (tag 'h2 () body))

(defun h3 (&rest body)
   (tag 'h3 () body))

(defun h4 (&rest body)
   (tag 'h4 () body))



