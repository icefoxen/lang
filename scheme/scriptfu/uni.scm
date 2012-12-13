; uni.scm
; Produces a uniform image of the requested size and color.

(define (uni-img size color)
  ; Create the image and layer
  (set! img (car (gimp-image-new size size RGB)))
  (set! layer (car (gimp-layer-new img size size RGB "Layer 1" 100 NORMAL)))

  ; Gimpy stuff
  (gimp-image-undo-disable img)
  (gimp-image-add-layer img layer 0)

  ; Do painting
  (gimp-palette-set-background color)
  (gimp-edit-fill layer BG-IMAGE-FILL)

  ; More gimpy stuff
  (gimp-display-new img)
  (gimp-image-undo-enable img))

; Register our script
(script-fu-register "uni-img"
		    "<Toolbox>/Xtns/Script-Fu/Tutorials/Uniform image"
		    "Creates a uniform image"
		    "Simon Heath <snh1@cec.wustl.edu>"
		    "Simon Heath"
		    "2004-10-27"
		    ""
		    SF-VALUE "size" "100"
		    SF-COLOR "color" '(255 127 0))