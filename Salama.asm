.286
        include Drop.inc 
        .MODEL SMALL
        .STACK 64
        .DATA
        GiftsX dw 20 dup(?)
        GiftsY dw 20 dup(?)
        tank1 dw 30d,110d,70d,110d,70d,170d,30d,170d,  40d,125d,60d,125d,60d,155d,40d,155d, 48d,120d,52d,120d,52d,125d,48d,125d, 540d,200d, 0511h ;three rectangles 2 words tankcenter  more word for hp and orientation  
        tank2 dw 130d,110d,170d,110d,170d,170d,130d,170d, 140d,125d,160d,125d,160d,155d,140d,155d, 148d,120d,152d,120d,152d,125d,148d,125d, 300d,200d ,0311h
        .code
MAIN    PROC FAR               
        MOV AX,@DATA
        MOV DS,AX

        mov ah,0
        mov al,12h
        int 10h
        Drop GiftsX,GiftsY,Tank1,Tank2  
        hlt
        
MAIN    ENDP 
