;;; Test how fast CLOS function-calling really is.


(defun fib (x)
   (if (< x 2)
       x
       (+ (fib (- x 1))
          (fib (- x 2)))))


(defclass int ()
   ((val
      :accessor int-val
      :initarg :val
      :initform 0)))

(defparameter *one* (make-instance 'int :val 1))
(defparameter *two* (make-instance 'int :val 2))

(defmethod intadd ((x int) (y int))
   (make-instance 'int :val (+ (int-val x) (int-val y))))

(defmethod intsub ((x int) (y int))
   (make-instance 'int :val (- (int-val x) (int-val y))))

;; These bits are the key.
;; We can't manipulate integers-as-objects directly without doing
;; a whole SMECKLOAD of boxing, unboxing, object-creation, and
;; general tom-foolery.  All we want to check really is method-call
;; speed, when we have a few different methods to choose from.
(defmethod intfib1 ((x integer))
   (if (< x 2)
       x
       (+ (intfib1 (- x 1))
          (intfib1 (- x 2)))))
   

(defmethod intfib1 ((x int))
   (intfib1 (int-val x)))

;; clisp> (time (intfib1 (make-instance 'int :val 22)))
;;
;; Real time: 10.750976 sec.
;; Run time: 10.72 sec.
;; Space: 115776336 Bytes
;; GC: 176, GC time: 2.89 sec.
;;
;; clisp> (time (fib 22))
;; Real time: 0.07079 sec.
;; Run time: 0.07 sec.
;; Space: 0 Bytes
;;
;; Say function calls ~150 times faster --two+ orders of magnitude!!!

;; cmucl> (time (intfib1 (make-instance 'int :val 22)))
;; Evaluation took:
;;   23.56 seconds of real time
;;   22.65 seconds of user run time
;;   0.8 seconds of system run time
;;   [Run times include 0.2 seconds GC run time]
;;   0 page faults and
;;   366,186,080 bytes consed.
;;
;; cmucl> (time (fib 30))
;; Evaluation took:
;;   0.12 seconds of real time
;;   0.13 seconds of user run time
;;   0.0 seconds of system run time
;;   0 page faults and
;;   0 bytes consed.
;;
;; Faster overall, but function calls ~200 times faster than methods.
