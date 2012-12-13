; hello.scm
; Script-fu hello world.


(define (script-fu-hello-world img drawable)
  ; Start an undo group.
  (gimp-undo-push-group-start img)
  ; Create the text
  (set! text-float 
	(car (gimp-text-fontname img drawable 10 10
				 "Hello world!"
				 0 1 50 0
				 "-*-utopia-*-r-*-*-*-*-*-*-*-*-*-*")))

  ; Anchor the selection
  (gimp-floating-sel-anchor text-float)
  ; Complete the undo group
  (gimp-undo-push-group-end img)
  (gimp-displays-flush))



(script-fu-register "script-fu-hello-world"
		    "<Image>/Script-Fu/Tutorials/Hello World"
		    "Write hello world!"
		    "Simon Heath <snh1@cec.wustl.edu>"
		    "Simon Heath"
		    "2004-10-27"
		    "RGB*, GRAY*"
		    SF-IMAGE "Image" 0
		    SF-DRAWABLE "layer to blur" 0)