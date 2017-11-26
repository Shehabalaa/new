SetMap MACRO ;640*480 

; Frame
mov StartPointX, 0d
mov StartPointY, 0d
mov EndPointX, 639d
mov EndPointY,0d
mov linecolor,3
call DrawLine

mov StartPointX, 0d
mov StartPointY, 479d-40d
mov EndPointX, 640d
mov EndPointY,480d-40d
mov linecolor,3
call DrawLine

mov StartPointX, 0d
mov StartPointY, 0d
mov EndPointX, 0d
mov EndPointY,479d-40d
mov linecolor,3
call DrawLine

mov StartPointX, 639d
mov StartPointY, 0d
mov EndPointX, 639d
mov EndPointY,479d-40d
mov linecolor,3
call DrawLine

; First siege

mov StartPointX, 45d
mov StartPointY, 45d
mov EndPointX, 595d
mov EndPointY,45d
mov linecolor,0CH
call DrawLine

mov StartPointX, 45d
mov StartPointY, 435d-40d
mov EndPointX, 596d
mov EndPointY,436d-40d
mov linecolor,0CH
call DrawLine

mov StartPointX, 45d
mov StartPointY, 45d
mov EndPointX, 45d
mov EndPointY,435d-40d
mov linecolor,0CH
call DrawLine

mov StartPointX, 595d
mov StartPointY, 45d
mov EndPointX, 595d
mov EndPointY,435d-40d
mov linecolor,0CH
call DrawLine

; Second siege

mov StartPointX, 85d
mov StartPointY, 85d
mov EndPointX, 555d
mov EndPointY,85d
mov linecolor,0CH
call DrawLine

mov StartPointX, 85d
mov StartPointY, 395d-40d
mov EndPointX, 556d
mov EndPointY,396d-40d
mov linecolor,0CH
call DrawLine

mov StartPointX, 85d
mov StartPointY, 85d
mov EndPointX, 85d
mov EndPointY,395d-40d
mov linecolor,0CH
call DrawLine

mov StartPointX, 555d
mov StartPointY, 85d
mov EndPointX, 555d
mov EndPointY,395d-40d
mov linecolor,0CH
call DrawLine

; Third siege

mov StartPointX, 125d
mov StartPointY, 125d
mov EndPointX, 515d
mov EndPointY,125d
mov linecolor,0CH
call DrawLine

mov StartPointX, 125d
mov StartPointY, 355d-40d
mov EndPointX, 516d
mov EndPointY,356d-40d
mov linecolor,0CH
call DrawLine

mov StartPointX, 125d
mov StartPointY, 125d
mov EndPointX, 125d
mov EndPointY,355d-40d
mov linecolor,0CH
call DrawLine

mov StartPointX, 515d
mov StartPointY, 125d
mov EndPointX, 515d
mov EndPointY,355d-40d
mov linecolor,0CH
call DrawLine

; Forth siege

mov StartPointX, 165d
mov StartPointY, 165d
mov EndPointX, 475d
mov EndPointY,165d
mov linecolor,0CH
call DrawLine

mov StartPointX, 165d
mov StartPointY, 315d-40d
mov EndPointX, 476d
mov EndPointY,316d-40d
mov linecolor,0CH
call DrawLine

mov StartPointX, 165d
mov StartPointY, 165d
mov EndPointX, 165d
mov EndPointY,315d-40d
mov linecolor,0CH
call DrawLine

mov StartPointX, 475d
mov StartPointY, 165d
mov EndPointX, 475d
mov EndPointY,315d-40d
mov linecolor,0CH
call DrawLine

; Fifth siege

;mov StartPointX, 200d
;mov StartPointY, 200d
;mov EndPointX, 440d
;mov EndPointY,200d
;mov linecolor,0CH
;call DrawLine

;mov StartPointX, 200d
;mov StartPointY, 280d
;mov EndPointX, 441d
;mov EndPointY,281d-40d
;mov linecolor,0CH
;call DrawLine

;mov StartPointX, 200d
;mov StartPointY, 200d
;mov EndPointX, 200d
;mov EndPointY,280d-40d
;mov linecolor,0CH
;call DrawLine

;mov StartPointX, 440d
;mov StartPointY, 200d
;mov EndPointX, 440d
;mov EndPointY,280d-40d
;mov linecolor,0CH
;call DrawLine

;DrawUpperGates

mov StartPointX, 300d
mov StartPointY, 45d
mov EndPointX, 340d
mov EndPointY,45d
mov linecolor,0
call DrawLine

mov StartPointX, 300d
mov StartPointY, 120d
mov EndPointX, 340d
mov EndPointY,120d
mov linecolor,0
call DrawLine

;mov StartPointX, 300d
;mov StartPointY, 200d
;mov EndPointX, 340d
;mov EndPointY,200d
;mov linecolor,0
;call DrawLine

;DrawLowerGates

mov StartPointX, 300d
mov StartPointY, 480-80d
mov EndPointX, 340d
mov EndPointY,480-80d
mov linecolor,0
call DrawLine

mov StartPointX, 300d
mov StartPointY, 480-160d
mov EndPointX, 340d
mov EndPointY,480-160d
mov linecolor,0
call DrawLine

;mov StartPointX, 300d
;mov StartPointY, 480-200d
;mov EndPointX, 340d
;mov EndPointY,480-200d
;mov linecolor,0
;call DrawLine

;DrawLeftGates

mov StartPointX, 80d
mov StartPointY, 200d
mov EndPointX, 80d
mov EndPointY,240d
mov linecolor,0
call DrawLine

mov StartPointX, 160d
mov StartPointY, 200d
mov EndPointX, 160d
mov EndPointY,240d
mov linecolor,0
call DrawLine

;mov StartPointX, 240d
;mov StartPointY, 200d
;mov EndPointX, 240d
;mov EndPointY,240d
;mov linecolor,0
;call DrawLine

;DrawRightGates

mov StartPointX, 640-80d 
mov StartPointY, 200d 
mov EndPointX, 640-80d
mov EndPointY,240d
mov linecolor,0
call DrawLine

mov StartPointX, 640-160d
mov StartPointY, 200d
mov EndPointX, 640-160d
mov EndPointY,240d
mov linecolor,0
call DrawLine

;mov StartPointX, 640-240d
;mov StartPointY, 200d
;mov EndPointX, 640-240d
;mov EndPointY,240d
;mov linecolor,0
;call DrawLine


ENDM SetMap
