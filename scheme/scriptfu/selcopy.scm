; selcopy.scm
; Takes a selection, copies it, and plonks it back down a fixed distance
; away.


(define (script-fu-sel-copy img drawable)
  (gimp-undo-push-group-start img)

  (gimp-edit-copy drawable)
  (set! sel-float (car (gimp-edit-paste drawable FALSE)))
  (gimp-layer-set-offsets sel-float 100 50)
  (gimp-floating-sel-anchor sel-float)

  (gimp-undo-push-group-end img)
  (gimp-displays-flush))



(script-fu-register "script-fu-sel-copy"
		    "<Image>/Script-Fu/Tutorials/Selection copy"
		    "Copies the selection onto the same layer"
		    "Simon Heath <snh1@cec.wustl.edu>"
		    "Simon Heath"
		    "2004-10-27"
		    "RGB*, GRAY*"
		    SF-IMAGE "Image" 0
		    SF-DRAWABLE "layer" 0)
