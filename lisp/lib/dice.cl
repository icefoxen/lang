;; Dice.cl
;; This just makes a random integer between 1 and 6.
;; Simon Heath
;; 27/05/2002
(defun roll ()
   (first (list (round (* 6 (random 1.0))))))

;; ...Or you could just do:
;; (1+ (random 6))
;; But where's the fun in that???
