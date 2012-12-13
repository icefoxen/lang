; swaprb.scm
; This swaps the red and blue colors in an image.
; It tries not to affect black.

(define (swap-color c)
  (define r (car c))
  (define g (cadr c))
  (define b (caddr c))
  (list b g r))

(define (script-fu-swap-rb img drawable)
  (gimp-undo-push-group-start img)
  (define new-layer (car (gimp-layer-copy drawable 0)))
  (gimp-layer-set-name new-layer "New layer")
  (gimp-image-add-layer img new-layer 0)
  
  (define black (gimp-image-pick-color img drawable 0 0 0 0 0))
  (define xcord 0)
  (define ycord 0)

  (while (< xcord (gimp-image-width img))
	 (set! ycord 0)

	 (while (< ycord (gimp-image-height img))
		(let* ((oldcol (gimp-image-pick-color img drawable xcord ycord
						      0 0 0))
		       (newcol (swap-color oldcol)))
		  (gimp-rect-select img xcord ycord 1 1 REPLACE 0 0)
		  (gimp-palette-set-background newcol)
		  (gimp-edit-fill layer BG-IMAGE-FILL)
		  (gimp-selection-none img))
		(set! ycord (+ ycord 1)))
	 
	 (set! xcord (+ xcord 1)))
  
  (gimp-undo-push-group-end img)
  (gimp-displays-flush))



(script-fu-register "script-fu-swap-rb"
		    "<Image>/Script-Fu/Tutorials/Swap Red and Blue"
		    "Swaps the red and blue in an image."
		    "Simon Heath <snh1@cec.wustl.edu>"
		    "Simon Heath"
		    "2004-10-27"
		    "RGB*, GRAY*"
		    SF-IMAGE "Image" 0
		    SF-DRAWABLE "layer" 0)

	 