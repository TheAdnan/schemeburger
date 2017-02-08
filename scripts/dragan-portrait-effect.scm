; dragan-portrait-effect.scm
; version 1.0
; Copyright (C) 2017 Adnan Kièin <adnankicin92@gmail.com>


(define (dragan-script image layer)
	(let* (
		(img image)
		(lyr layer)
	)
	(gimp-context-push)
	(gimp-image-undo-group-start image)
	
	;Duplicate layer and desaturate
	(define novi-layer (car (gimp-layer-copy lyr 0)))
    (gimp-item-set-name novi-layer "Novi Layer")
    (gimp-image-insert-layer img novi-layer 0 0)
	(gimp-layer-set-opacity novi-layer 90)
	(gimp-layer-set-mode novi-layer 3)
	(gimp-desaturate-full novi-layer 2)
	(gimp-image-merge-down img novi-layer 0)
	
	; (define novi-layer2 (car (gimp-layer-copy lyr 0)))
    ; (gimp-item-set-name novi-layer2 "Novi Layer 2")
    ; (gimp-image-insert-layer img novi-layer2 0 0)
	; (gimp-layer-set-opacity novi-layer2 100)
	; (gimp-layer-set-mode novi-layer2 3)
	; (gimp-desaturate-full novi-layer2 2)
	; (gimp-image-merge-down img novi-layer2 0)
	 
	(gimp-image-flatten img)
	
	
	
	(gimp-image-undo-group-end image)
	(gimp-displays-flush)
	(gimp-context-pop)

	)
)

(script-fu-register
	"dragan-script"
	_"Dragan portrait effect"
	"Dragan portrait effect by Adnan Kicin"
	"https://github.com/TheAdnan/"
	"copyright 2017, Adnan Kicin"
	"February 2017"
	"RGB*, GRAY*"
	SF-IMAGE "Image" 0
	SF-DRAWABLE "Layer" 0
)
(script-fu-menu-register "dragan-script" _"<Image>/Filters/Enhance/Kicin")