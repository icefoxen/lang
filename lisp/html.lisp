;; Should all be compliant with XHTML 1.0/strict
;; This DOES NOT guarentee a good html; if you tell it to do <b href="booga" />
;; it WILL DO it!  'Tis not idiot-proof; idiots should not be making webpages,
;; let alone hacking Lisp.
;; I just wanna make the damn stuff easier to read and work with.


;; Standard doctype
(defparameter *doctype* "
<?xml version=\"1.0\" encoding=\"iso-8859-1\"?>
<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 trict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">
")

;; list of html tags  --style, script and comment are done later
;; Body is also done later, 'cause it's gonna have more tags embedded in it.
;; Does NOT do frames or flash so far!
(defparameter *html-tags* 
'(html head title meta link body p br span div b i u em strong a img table tr td
h1 h2 h3 h4 ul ol li))


;; Turns a list of (key . value) pairs into a string of key="value" pairs
;; on nil returns an empty string
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
;; Also builds a string out of a list of html funcs.  Or at least it should.
(defun build-body (body)
   (if body
      (let ((final ""))
         (dolist (item str)
            (setf final (concatenate 'string
	                   final
			   item))))
      ""))


;; Returns a string enclosed by the specified tag
(defun tag (tag opts &rest body)
   (if body                  ;; If body exists, build a full tag
      (concatenate 'string
         "<"
         (to-lowercase (string tag))
         (build-opts opts)   ;; Returns empty if opts is nil
         ">\n"
         (build-body)
         " </"
         tag
         ">\n")              ;; ...newline??
      (concatenate 'string   ;; otherwise, build a short tag, ie <br />
         " <"
         (to-lowercase (string tag))
         (build-opts opts)
         " />\n")))

;; test this!
;(defcustom *html-chars* 
;   list '((#\< . "&lt;") (#\> . "&gt;") (#\& . "&amp;"))
;   "The characters which must be replaced before putting a string into HTML.")



(defun comment (body)
   (concatenate 'string 
      "<!--\n" 
      (build-body body) 
      "\n-->\n"))


;; Can this do what I think it can, and build the entire freakin' suite of
;; functions??
#|
(defmacro build-tag-funcs (foo)
   (if foo
      (progn (defun (car foo) (opt &rest body)
                (tag (car foo) opt body))
             (build-tag-funcs (cdr foo)))
      nil))
|#

(defun html (opts &rest x)
   (tag 'html '(("xml:lang" . en) '(lang . en) opts) x))



;; These are seperate 'cause they need commented text

;; Stylesheet decleration
(defun style (body)
   (tag 'style '(("type" . "text/css")) ;; like there's another kind??
      (comment body)))

(defun script (opts body)
   (tag 'script opts (comment body)))

;; Sample
#|
(build-tag-funcs)
(print *doctype*)
(print
(html
 (head
  (title () "Simon's page")
  (meta '((name . generator) '(content . "S's HTMLGEN 0.1")))
  (link '(("rel" . "stylesheet") ("type" . "text/css") ("href" . "style1.css"))))
 (body '(("bgcolor" . "#CCCCCC")))))
|#



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; All the tags and such
#|


(defun head (x)
   (tag 'head () x))

(defun title (x)
   (tag 'title () x))

;; possible options: *name, content,* http-equiv...
(defun meta (opts)
   (tag 'meta opts))

;; Usage: <link rel="stylesheet" type="text/css" href="..." />
(defun link (opts)
   (tag 'link opts))



(defun body (opts body)
   (tag opts body))

;; Opts: href
(defun a (opts body)
   (tag opts body))

;; Opts: src, border
(defun img (opts body)
   (tag opts body))

|#
