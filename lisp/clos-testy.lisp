(defclass person ()  ; No superclasses
   ; Here we define fields with attributes
   ((name
      :accessor person-name
      :initform 'bill
      :initarg :name)
    (age
      :accessor person-age
      :initform 20
      :initarg :age)))


; Inheritance, yay!
(defclass teacher (person)
   ((subject 
      :accessor teacher-subject
      :initarg :subject)))

; Inheritance, overriding an initform!
(defclass math-teacher (teacher)
   ((subject
      :initform "Mathematics")))


; Kay, a method is a type of GENERIC function.
; The (teach teacher) tells it that if it gets passed an object of type
; "teacher", it should be bound to variable "teach".
(defmethod change-subject ((teach teacher) new-subject)
   (setf (teacher-subject teach) new-subject))


(defmethod test ((x number) (y number))
   '(num num))

(defmethod test ((x number) (y integer))
   '(num int))

(defmethod test ((x integer) (y number))
   '(int num))

(defmethod test ((x integer) (y integer))
   '(int int))


; Demonstrates :before and :after, and overloading methods.
; This also demonstrates specificity precedence.  More specific functions
; are executed first.

(defclass food () ())

(defmethod cook :before ((f food))
   (print "Food is about to be cooked."))

(defmethod cook :after ((f food))
   (print "Food has been cooked"))

(defmethod cook ((f food))
   (print "Food is being cooked"))

(defclass pie (food)
   ((filling
      :accessor pie-filling
      :initarg :filling
      :initform 'apple)))

(defmethod cook ((p pie))
   (print "Cooking a pie")
   (setf (pie-filling p) (list 'cooked (pie-filling p))))

(defmethod cook :before ((p pie))
   (print "A pie is about to be cooked"))

(defmethod cook :after ((p pie))
   (print "A pie has been cooked"))
