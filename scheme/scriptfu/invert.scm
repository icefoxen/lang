; invert.scm
; Invert an image's colors.


(define (script-fu-invert img drawable)
  (set! new-layer (car (gimp-layer-copy drawable 0)))
  (gimp-layer-set-name new-layer "inverted")
  (gimp-image-add-layer img new-layer 0)
  (gimp-invert new-layer)
  (gimp-displays-flush))

(script-fu-register "script-fu-invert"
		    "<Image>/Script-Fu/Tutorials/Invert"
		    "Invert the colors of an image"
		    "Simon Heath <snh1@cec.wustl.edu>"
		    "Simon Heath"
		    "2004-10-27"
		    "RGB*, GRAY*"
		    SF-IMAGE "Image" 0
		    SF-DRAWABLE "layer to invert" 0)
