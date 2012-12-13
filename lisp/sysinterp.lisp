#!/lisp.run -norc --quiet -M sysinterp.lim
;; Sysinterp file, executed by the kernel at startup.
;; Currently dependent on non-standard CLISP junk.  Is it worth linking
;; CLOCC into this??
;; Maybe later.  Too early to tell.  The idea has merit, though.


;; Setup and packaging
(eval-when (compile load eval))

(defpackage :SYSINTERP)
(in-package :SYSINTERP)

(import :COMMON-LISP :SYSTEM)

;; Load application environment.
(load "app.lisp")

;; Constants
(defconstant *sysinterp-version* 0.1)

;; Splash
(format t "This is MSDOS (Mad Scientist Designer Operating System)
Currently running ~A ~A, with sysinterp.lisp version ~A.
Machine is a ~A.
Current time is ~A~%" 
   (lisp-implementation-type) 
   (lisp-implementation-version)
   *sysinterp-version* 
   (machine-type)
   (current-time))


;; Set environment variables
(setenv "HOME" "/")
(setenv "SHELL" "StackShell.lisp")


; Execute shell
(execute (getenv "SHELL"))
