;; Roller.cl
;; The archetypical Rifts-type RPG dice roller.
;; Enter the number of dice and the sides.
;; Simon Heath
;; 27/05/2002
(defun roller (number sides)
   (let ((roll (1+ (random sides))))
   (format t "D~A = ~A~%" sides roll)
   (cond
      ((= number 1) t)
      (t (roller (1- number) sides)))))

(defun roll-iterative (number sides)
   (let ((stack ())
      (dotimes (count number)
         (let ((result (1+ random sides)))
         (format t "~AD~A = ~A~%" count sides result)
         (push result x)))
      (let ((sum 0))   
         (dotimes (count (length stack))
            (let ((sum (+ sum (pop stack)))
