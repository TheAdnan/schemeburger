(define (fish-eye-effect image layer lvls)
	(let* (
		(img image)
		(lyr layer)
		(levels lvls)
		(imgHeight (car (gimp-image-height img)))
		(imgWidth (car (gimp-image-width img)))
		(imgType (car (gimp-image-base-type img)))
		(background-layer (car (gimp-layer-new img imgWidth imgHeight imgType "Background layer" 100 0)))
	)
	(gimp-context-push)
	(set! background-layer (car (gimp-layer-copy lyr 1)))
	
	
	(gimp-image-undo-group-start image)
	(if (= levels TRUE)
		(gimp-levels-stretch lyr)
	)
	
	(gimp-image-set-active-layer img lyr)
	(plug-in-lens-distortion RUN-NONINTERACTIVE img lyr 0.0 0.0 29.467 36.677 22.257 3.135)
	
	(gimp-image-flatten img)
	(gimp-image-insert-layer img background-layer 0 1)
	(gimp-image-flatten img)
	(gimp-image-undo-group-end image)
	(gimp-image-crop img (- imgWidth 50) (- imgHeight 50) 25 25)
	(gimp-displays-flush)
	
	(gimp-context-pop)

	)
)

(script-fu-register
	"fish-eye-effect"
	_"Fish-eye effect by Kicin"
	"Fish eye effect by Adnan Kicin"
	"https://github.com/TheAdnan/"
	"copyright 2017, Adnan Kicin"
	"February 2017"
	"RGB*, GRAY*"
	SF-IMAGE "Image" 0
	SF-DRAWABLE "Layer" 0
	SF-TOGGLE "Auto adjust levels" TRUE
)
(script-fu-menu-register "fish-eye-effect" _"<Image>/Filters/Enhance")