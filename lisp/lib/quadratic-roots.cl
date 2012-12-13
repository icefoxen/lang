;; quadratic-roots.cl
;; Returns the roots of the quadratic equation aX+bX^2+c=0
;; I'm sure I'll find a use for it someday.
;; Simon Heath
;; 28/05/2002
(defun quadratic-roots (a b c)
   "returns the roots of the quadratic equation aX+bX^2+c=0"
   ;; This is a documentation string, try 
   ;; (documentation 'quadratic-roots 'function)
   (let ((discriminant (- (* b b) (* 4 a c))))
   (values (/ (+ (- b) (sqrt discriminant)) (* 2 a))
           (/ (- (- b) (sqrt discriminant)) (* 2 a))))) 
