;; This is just messing with structures.
;; Simon Heath
;; 27/05/2002
(defstruct struct1 color size shape weight location)
(setq object1 (make-struct1
   :color 'green
   :size 'small
   :shape 'square
   :weight 'light
   :location 'on-floor))
object1
(struct1-p object1)
(struct1-color object1)
(struct1-size object1)
(struct1-shape object1)
(struct1-weight object1)
(struct1-location object1)
(setf (struct1-location object1) 'under-table)
object1
(type-of 123)
(type-of object1)

;; Random insanity
(format t "~3%Loading this doesn't do much good; look at the source.~%
Use the source, Luke!  hahaha...~3%")
