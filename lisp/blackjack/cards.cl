;; Functions that simulate a deck of cards.
;; You can shuffle the deck and draw random cards either destructively
;; or non-destructively.

(defpackage cards)
(in-package cards)

(defvar *deck* ())
(defconstant +suits+ '(spade diamond heart club))
(defconstant +faces+ '(two three four five six seven eight nine ten jack queen 
   king ace))
   
(defun shuffle ()
   (setf *deck* ())
   (dolist (suit +suits+)
      (dolist (face +faces+)
         (push (list face suit) *deck*)))
   (format t "Deck shuffled~%"))

(defmacro draw-random ()  ;; Non-destructive
   `(nth (random (length *deck*)) *deck*))

;; Certain destructive deletion of the place-th element.
(defmacro dest-mod (place lst)  
   `(setf ,lst (remove (nth ,place ,lst) ,lst)))

(defun pick-random ()  ;; Destructive
   (cond 
     ((not (null *deck*))  ;; If deck isn't empty, get a card.
      (let ((card-place (random (length *deck*))))
         (let ((card (nth card-place *deck*)))
            (dest-mod card-place *deck*)
            card)))
     (t (format t "Deck is empty.  Shuffle? (y/n)  ") 
     ;; Otherwise, ask to reshuffle
        (cond 
           ((y-or-n-p) (shuffle) (pick-random))
	   (t nil)))))

(defmacro format-card (x)
   `(format t "You drew a ~A of ~AS" (car ,x) (cadr ,x)))
   
