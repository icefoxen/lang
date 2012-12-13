;; Functions that simulate a deck of cards.
;; You can shuffle the deck and draw random cards either destructively
;; or non-destructively.

;; Basic declarations

;(defpackage cards)
;(in-package cards)

(defvar *deck* ())
(defconstant +suits+ '(spade diamond heart club))
(defconstant +faces+ '(two three four five six seven eight nine ten jack queen 
   king ace))

;; Low-level functions and macros   

; Builds a new deck
(defun shuffle ()
   (setf *deck* ())
   (dolist (suit +suits+)
      (dolist (face +faces+)
         (push (list face suit) *deck*)))
   (format t "Deck shuffled~%"))

; Certain destructive deletion of the place-th element.
(defmacro dest-mod (place lst)  
   `(setf ,lst (remove (nth ,place ,lst) ,lst)))

; Non-destructively shows a random card from deck
(defmacro draw-random ()
   `(nth (random (length *deck*)) *deck*))

; Destructively draws a random card from deck
(defun pick-random ()  
   (cond 
     ((not (null *deck*))  ;; If deck isn't empty, get a card.
      (let ((card-place (random (length *deck*))))
         (let ((card (nth card-place *deck*)))
            (dest-mod card-place *deck*) ; probably not good code...
            card)))
      (t (format t "Deck is empty.  Shuffle? (y/n)  ")
         ;; Otherwise, ask to reshuffle
            (when (y-or-n-p) 
               (shuffle)
	       (pick-random)))))

; Prints out the value of a card nicely
(defun format-card (x)
   (concatenate 'string (string (car x)) " of " (string (cadr x)) "S"))

; Returns the numerical value of a card -aces can be 1 or 11
(defun value-card (x)
   (case (first x) ((two) 2)
                   ((three) 3)
	           ((four) 4)
	           ((five) 5)
	           ((six) 6)
	           ((seven) 7)
	           ((eight) 8)
	           ((nine) 9)
	           ((ten jack queen king) 10)
	           ((ace) 'ace)))
		   
; Certain destructive append
(defmacro dest-append (x y) 
   `(setf ,x (append ,x ,y)))

;; Intermediete level functions

; prints out an entire hand nice and neatly
(defun format-hand (x)
   (concatenate 'string (format-card (car x)) 
                        (when (cdr x) (string " and "))
                        (when (cdr x) (format-hand (cdr x))))) 

; Returns the value of an entire hand --determines aces as 1 or 11 correctly
(defun value-hand (hand &optional initial-value) ;; the initial-value arg
   (let ((total (if (null initial-value)         ;; lets it recurse
                     0
		     initial-value))
         (card (value-card (first hand))))
      (if (equal card 'ace)  ;; figure out value of ace: 1 or 11
         (if (> 21 (+ (value-hand (cdr hand) total) 11)) 
             ; recurses to find value of hand minus aces -I think
	     ; really not sure how I got this to work.
	      (setf total (+ 1 total))
	      (setf total (+ 11 total)))
	 (setf total (+ total card)))  ;; 2nd Else
      (if (null (cdr hand))  ;; primary recursion
          total
	  (value-hand (cdr hand) total))))

;; High-level functions --Direct game operations

; prints out all the stats of the game
(defun print-stats (dealer-hand player-hand)
   (let ((dealer-value (value-hand dealer-hand))
         (player-value (value-hand player-hand)))
	 ; Yeah, I could have the values passed as an argument, and it would
	 ; be quicker, but 4 arguments gets messy to invoke.
      (format t "Cards left in deck: ~A~%" (length *deck*))
      (format t "The dealer is showing a ~A~%" 
         (format-hand (cdr dealer-hand))) ;; first card is hidden
      (format t "You have a ~A~%" (format-hand player-hand))
      (format t "Dealer total: ~A~%" (value-hand (cdr dealer-hand)))
      (format t "Your total: ~A~2%" player-value)))

; figures out who wins
(defun evaluate (dealer-hand player-hand)
   (let ((dealer-value (value-hand dealer-hand))
         (player-value (value-hand player-hand))) 
    (cond
       ((> player-value 21) (format t "You lose!~%") 'dealer)
       ((> dealer-value 21) (format t "Dealer loses!~%") 'player)
;       ((= player-value dealer-value)
;          (format t "Draw: ~A vs. ~A~%" 
;             (format-hand dealer-hand) (format-hand player-hand))
;          'draw)
       ((= player-value 21) (format t "Blackjack!  Player wins!~%")
          'player)
       ((= dealer-value 21) (format t "Blackjack!  Dealer wins!~%")
          'dealer)
       (t (format t 
             "\"H\" to hit, \"S\" to stay, \"Q\" to quit.~%-->")
	  'continue))))

(defun dealer-ai (hand)
   (do ((val (value-hand hand)) 
        (margin (+ 3 (random 4)))) ; how close to 21 the dealer tries to get
       (>= val (- 21 margin)) ; ending condition
       
;; above is iterative verson, below is recursive.  Both are wrong.      
      
(defun dealer-ai (hand)
   (let ((val (value-hand hand))
         (margin (random 2)))
      (cond
      ((= margin 1)
         (setf 
      

;;;;;;;;;;; The game itself ;;;;;;;;;;;;

(defun blackjack ()
   (format t "Welcome to Simon's Blackjack!~%")
   (shuffle)
   (loop
     (let* ((dealer-hand (list (pick-random) (pick-random)))
             (player-hand (list (pick-random) (pick-random)))
	     (dealer-value (value-hand dealer-hand))
	     (player-value (value-hand player-hand)))
        (loop
	 (print-stats dealer-hand player-hand)
	 (case (evaluate dealer-hand player-hand)
	    ((player dealer))
               (format t "Press Enter to continue.") (read))
	    ((continue) 
	       (case (read)
	          ((h) (format t "~%Player hits!~%")
		       (setf player-hand 
		          (append player-hand (list (pick-random)))))
		  ((s) (format t "~%Player stays~%"))
		  ((q) (break)))))))))
