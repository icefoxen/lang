(defun fib1 (x)
  (if (< x 2)
    1
    (+ (fib1 (- x 1)) (fib1 (- x 2)))))

; Optimizations on!
(defun fib2 (x)
  (declare (fixnum x) (optimize (speed 3) (debug 0) (safety 0)))
  (if (< x 2)
    1
    (+ (fib2 (- x 1)) (fib2 (- x 2)))))

; Same thing without the fixnum declaration
(defun fib3 (x)
  (declare (optimize (speed 3) (debug 0) (safety 0)))
  (if (< x 2)
    1
    (+ (fib3 (- x 1)) (fib3 (- x 2)))))

;(fib 40)

; Let's see how much overhead CLOS adds...
; ...woah.  Not much.
(defmethod add1 ((x integer) (y integer)) 
   (+ x y))

(defmethod sub1 ((x integer) (y integer)) 
   (- x y))

(defmethod lt1 ((x integer) (y integer)) 
   (< x y))

(defun fib4 (x)
  (if (lt1 x 2)
    1
    (add1 (fib4 (sub1 x 1)) (fib4 (sub1 x 2)))))

(defun fib5 (x)
  (declare (fixnum x) (optimize (speed 3) (debug 0) (safety 0)))
  (if (lt1 x 2)
    1
    (add1 (fib5 (sub1 x 1)) (fib5 (sub1 x 2)))))

(defmethod add2 ((x integer) (y integer)) 
  (declare (fixnum x) (optimize (speed 3) (debug 0) (safety 0)))
   (+ x y))

(defmethod sub2 ((x integer) (y integer)) 
  (declare (fixnum x) (optimize (speed 3) (debug 0) (safety 0)))
   (- x y))

(defmethod lt2 ((x integer) (y integer)) 
  (declare (fixnum x) (optimize (speed 3) (debug 0) (safety 0)))
   (< x y))

(defun fib6 (x)
  (declare (fixnum x) (optimize (speed 3) (debug 0) (safety 0)))
  (if (lt2 x 2)
    1
    (add2 (fib6 (sub2 x 1)) (fib6 (sub2 x 2)))))
