; copyblur.scm
; Copies the current layer to a new one, blurs, and inverts.
; Avaliable through the right-click menu on an image.

(define (script-fu-copy-blur img drawable blur-radius)
  (set! new-layer (car (gimp-layer-copy drawable 0)))
  (gimp-layer-set-name new-layer "Gauss-blurred")
  (gimp-image-add-layer img new-layer 0)
  ; Call plugin to blur the image
  (plug-in-gauss-rle 1 img new-layer blur-radius 1 1)
  (gimp-invert new-layer)
  (gimp-displays-flush))

(script-fu-register "script-fu-copy-blur"
		    "<Image>/Script-Fu/Tutorials/Copy-blur"
		    "Copy and blur an image"
		    "Simon Heath <snh1@cec.wustl.edu>"
		    "Simon Heath"
		    "2004-10-27"
		    "RGB*, GRAY*"
		    SF-IMAGE "Image" 0
		    SF-DRAWABLE "layer to blur" 0
		    SF-VALUE "blur strength" "5")