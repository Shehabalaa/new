;orientations
;00 up
;11 down
;01 right
;10 left
.286  
include test.inc
include map.inc   
include map2.inc
include Display.inc

.model meduim
.stack 64d
.data                        
WelcomeMessage db 10,13,10,13,13,13
               db '**         **  ********  **    ********* ******** ***           *** ********',10,13
               db '**         **  **        **    ********* *      * ** *        *  ** **' ,10,13
               db '**         **  **        **    **        *      * **  * *  * *   ** **'  ,10,13
               db '**   ***   **  ********  **    **        *      * **     **      ** ********'    ,10,13
               db '** **   ** **  **        **    ********* *      * **             ** **'  ,10,13
               db '***      ****  ********  ***** ********* ******** **             ** ********$' 
              
DoYoWantToPlay db 10,13,10,13,10,13,'                         If You want to play ,, press any key$'           
BulletCoordinates dw 00d,00d 
AllBullets dw 0000H,0000H

line label byte
StartPointX dw ,0
StartPointY dw ,0
EndPointX   dw ,0`
EndPointY   dw ,0
linecolor   db ,0


user1 label byte; +48 to get center + 52 to get orientation and hp word                                                                                                     
tank1 dw 1d,110d,41d,110d,41d,150d,1d,150d,  11d,0078h,31d,0078h,31d,008ch,11d,008ch, 16d,115d,26d,115d,26d,0078h,16d,0078h, 21d,130d ,0721h ;three rectangles 2 words tankcenter  more word for hp and orientation
shots1 dw 5d,0d
dw 0,0,0
dw 0,0,0
dw 0,0,0
dw 0,0,0
dw 0,0,0

user2 label byte; +48 to get center + 52 to get orientation and hp word
tank2 dw 80d,210d,0078h,210d,0078h,250d,80d,250d,  90d,00dch,110d,00dch,110d,00f0h,90d,00f0h, 95d,215d,105d,215d,105d,00dch,95d,00dch, 0064h,230d ,0711h
shots2 dw 5d,0d
dw 0,0,0
dw 0,0,0
dw 0,0,0
dw 0,0,0
dw 0,0,0

min_x dw 0
max_x dw 0
min_y dw 0
max_y dw 0 

damagedwall_pos dw ?,?,?  ; last word for power that wall hit with 
shootspeed dw 2

GiftsX dw 20 dup(0) 
GiftsY dw 20 dup(0) 

integar db ' '

.code 
main proc far 
    mov AX,@Data
    mov DS,AX
    mov es,ax    
    
    ;Display  WelcomeMessage
    ;Display  DoYoWantToPlay
    
    ;mov ah,0
    ;int 16h
    mov bh,0
    mov ah,0
    mov al,12h
    int 10h   
    
    
    SetMap
    call DropGifts
 
    
    mov bx ,offset tank1
    mov cx ,13d
    loop111111111:
        mov al ,1d
        call drawpx
        add bx,4d
    loop loop111111111
        mov bx ,offset tank2
        mov cx ,13d
    loop21111:
        mov al ,2d
        call drawpx
        add bx,4d
    loop loop21111

    l1:

        ;---------------------------------
        mov bx,offset shots1 ;bx on shots1(2) di for tank1(2)
        mov di,offset tank1
        call inputshots
        ;---------------------------------
        mov bx, offset shots1
        mov di, offset tank2
        call process_shots  ;bx on shots1(2) of attacker tank2(1) and di on victm tank
    jmp l1    
    hlt
main endp

DrawLine proc near
    pusha
    mov AX,StartPointX
    cmp Ax,EndPointX
	je VerticalLine

    HorizontalLine:
    mov cx,StartPointX 	;Column
    mov dx,StartPointY 	;Row
    mov al,linecolor  		;Pixel color
    mov ah,0ch  		;Draw Pixel Command
    looop1: int 10h
    	 inc cx
    	 cmp cx,EndPointX
    	 jnz looop1
    popa
    ret
    
    VerticalLine:
    mov cx,StartPointX 	;Column
    mov dx,StartPointY 	;Row
    mov al,linecolor  		;Pixel color
    mov ah,0ch  		;Draw Pixel Command
    looop2: int 10h
	 inc dx
	 cmp dx,EndPointY
	 jnz looop2 
	
    popa
    ret
Drawline endp 


drawpx proc near ; draw pixel with color in al
    pusha
    mov cx,[bx]
    mov dx,[bx]+2
    mov ah,0ch
    mov bh,0
    int 10h
    popa
    ret 
drawpx endp 



inputshots proc near
    pusha 
    ;i here interset in shoot only  
    mov ah,1d
    int 16h 
    jnz con
    popa
    ret
    con: 
    cmp ah,57d     
    jz con2
    popa
    ret
    con2:
    
        mov si ,[bx]
        mov ax ,[bx]+2
        cmp si ,ax
    jnz con3
    mov ah,0
    int 16h   
    popa
    ret
    con3:
    mov ah,0
    int 16h
     
    ;-----------
    mov ax,[bx]+2
    mov cl,6 
    mul cl
    mov cx,[bx]+2
    inc cx
    mov [bx]+2,cx 
    add bx,4
    add bx,ax 
    ;--------- 
    mov cx  , [di]+48d
    mov [bx], cx
    mov cx  , [di]+50d
    mov [bx] +2 , cx
    mov cx  , [di]+52d 
    and cx,00ffh
    mov [bx] +4 ,cx
    mov cx  , [di]+52d
    and cx,0ff1fh
    or cx ,0010h  
    mov [di]+52d ,cx   
    and cl ,0000000003h
  
    cas1:    
        cmp cl , 0d
        jnz cas2
        mov si,[bx +2]
        sub si ,21d
        mov [bx+2],si
        jmp finish
    cas2:
        cmp cl ,1d
        jnz cas3
        mov si,[bx]
        add si ,21d
        mov [bx],si
        jmp finish
    cas3:    
        cmp cl , 2d 
        jnz cas4
        mov si,[bx]
        sub si ,21d
        mov [bx],si 
        jmp finish
    cas4:    
        cmp cl , 3d
        jnz finish
        mov si,[bx +2]
        add si ,21
        mov [bx+2],si
    finish:      
     
    
    ;---------------    
    popa
    ret
inputshots endp

process_shots proc near   ;bx on shots of attacker tank and di on victm tank 
    ;steps
    ;1.process shots 2.draw shots 3.clear and move them 4.repeat
    pusha  ;now shots to process 
    mov cx,[bx]+2 
    cmp cx,0
    jnz cont
    popa
    ret
    cont:


    ;get smallest and bigest x  
    push di
    mov ax,[di] ;max x
    mov dx,ax   ;min x
    add di,4
    mov cx,3
    get_min_max_x:
       cmp ax,[di]
       ja here
           mov ax,[di]
           jmp skip
       here:
       cmp dx,[di]
       jb skip
       mov dx,[di] 
        
    skip:
    add di,4
    loop get_min_max_x   
    pop di 
    
    mov max_x,ax
    mov min_x,dx     
    ;-----------------------------
    
    ;get smallest and bigest y  
    push di  
    add di,2
    mov ax,[di] ;max y
    mov dx,ax   ;min y
    add di,4
    
    mov cx,3
    get_min_max_y:
       cmp ax,[di]
       ja here2
           mov ax,[di]
           jmp skip2
       here2:
       cmp dx,[di]
       jb skip2
       mov dx,[di] 
        
    skip2:add di,4
    loop get_min_max_y  
    pop di
    mov max_y,ax
    mov min_y,dx
    ;-----------------------------
    
    mov cx,[bx]+2 
    add bx,4
    push bx             
    check_del_shots:
        push cx        
        ;first check shots throug wall  
        mov cx ,[bx] +4
        and cl ,0000000003h
        mov ax,shootspeed ;this is shoot speed  
        option1:   
            cmp cl , 0d
            jnz option2
            push cx
            mov cx,[bx]
            mov dx,[bx +2] 
            dec ax ; dec ax counter of loop to use it
            add dx,ax
            inc ax ;bring it back
            push ax 
            mov ah,0dh
            ;
            push bx
            mov bh,0
            int 10h
            pop bx
            ; 
            cmp al,3d     ;very very strong wall
            jnz to1 
                pop ax
                pop cx 
                jmp noneg  ;noneg name has no meaning here it will go to line when i start deleteing node (by chance :D)       
          to1:   
            cmp al,0ch    ;strong wall   
            jz todamge1
            cmp al,0eh   ;weak wall 
            jnz to2  
            
            
            todamge1: ; here i should change wall color 
            mov damagedwall_pos ,cx
            mov damagedwall_pos +2  ,dx
            ;-----
            push cx
            mov cx,[bx]+4
            shr cx,4
            xor ch,ch 
            mov damagedwall_pos +4  ,cx
            pop cx
            ;----- 
            call damagewall   
            
            pop ax
            pop cx
            jmp noneg        
            to2:
            pop ax
            pop cx  
                
            dec ax
         jnz option1
        option2:
            cmp cl , 1d
            jnz option3
            push cx
            mov cx,[bx]
            mov dx,[bx +2]
            dec ax ; dec ax counter of loop to use it
            add cx,ax
            inc ax ;bring it back
            push ax 
            mov ah,0dh 
            ;
            push bx
            mov bh,0
            int 10h
            pop bx 
            ; 
            cmp al,3d      ;very very strong wall
            jnz to11 
                pop ax
                pop cx 
                jmp noneg        
          to11:
            cmp al,0ch    ;strong wall   
            jz todamge2
            cmp al,0eh   ;weak wall 
            jnz to22  

            todamge2: ; here i should change wall color 
            mov damagedwall_pos ,cx
            mov damagedwall_pos +2  ,dx
            ;-----
            push cx
            mov cx,[bx]+4
            shr cx,4
            xor ch,ch 
            mov damagedwall_pos +4  ,cx
            pop cx
            ;-----  
            call damagewall   
            
            pop ax
            pop cx
            jmp noneg          
            to22:
            pop ax
            pop cx  
                
             dec ax
         jnz option2
        option3:    
            cmp cl , 2d
            jnz option4
            push cx
            mov cx,[bx]
            mov dx,[bx +2]
            dec ax ; dec ax counter of loop to use it
            sub cx,ax
            inc ax ;bring it back
            push ax 
            mov ah,0dh
            ;
            push bx
            mov bh,0
            int 10h
            pop bx 
            ; 
            cmp al,3d
            jnz to111 
                pop ax
                pop cx 
                jmp noneg        
          to111:
            cmp al,0ch    ;strong color   
            jz todamge3
            cmp al,0eh   ;weak color 
            jnz to222  

            todamge3: ; here i should change wall color 
            mov damagedwall_pos ,cx
            mov damagedwall_pos +2  ,dx
            ;-----
            push cx
            mov cx,[bx]+4
            shr cx,4
            xor ch,ch 
            mov damagedwall_pos +4  ,cx
            pop cx
            ;-----  
            call damagewall   
            
            pop ax
            pop cx
            jmp noneg         
            to222:
            pop ax
            pop cx 

	   jmp check_del_shots_bridge2
	   check_del_shots_bridge1:
	  jmp check_del_shots
	   check_del_shots_bridge2:	 
                
            dec ax
         jnz option3
        option4:    
            cmp cl , 3d
            jnz finishcheck
            push cx
            mov cx,[bx]
            mov dx,[bx +2]
            dec ax ; dec ax counter of loop to use it
            sub dx,ax
            inc ax ;bring it back
            push ax 
            mov ah,0dh
            ;
            push bx
            mov bh,0
            int 10h
            pop bx 
            ; 
            cmp al,3d
            jnz to1111 
                pop ax
                pop cx 
                jmp noneg        
          to1111:
            cmp al,0ch    ;strong wall   
            jz todamge4
            cmp al,0eh   ;weak wall 
            jnz to2222  

            todamge4: ; here i should change wall color 
            mov damagedwall_pos ,cx
            mov damagedwall_pos +2  ,dx
            ;-----
            push cx
            mov cx,[bx]+4
            shr cx,4
            xor ch,ch 
            mov damagedwall_pos +4  ,cx
            pop cx
            ;----- 
            call damagewall    
            
            pop ax
            pop cx
            jmp noneg         
            to2222:
            pop ax
            pop cx     
            dec ax
         jnz option4
        finishcheck: 

     jmp check_del_shots_bridge22
	   check_del_shots_bridge11:
	  jmp check_del_shots_bridge1
	   check_del_shots_bridge22: 
   
        ;check point between two xs
        mov ax,min_x
        cmp [bx],ax
        jb next
        mov ax,max_x
        cmp [bx],ax
        ja next 
                   
        ;check point between two ys 
        mov ax,min_y
        cmp [bx+2],ax
        jb next     
        mov ax,max_y
        cmp [bx+2],ax
        ja next 
                      
        ; process deleting pixel and decreaing tank hp to be continue
        mov ax,[di]+52d 
        mov dx,[bx]+4d
        shr dl,4
        sub ah,dl
        ja noneg
            mov ah,0 
        noneg:
        mov [di]+52,ax
    
        pop ax ; now orginal cx in ax ; i wonot use just to get original bx
        pop si ; now original bx in si
        push si ;put them back
        push ax ;put them back
        mov cx,[si]-2
        mov ax,cx
        dec ax
        mov cl,6
        mul cl
        add si,ax ;si on last shot now replace
        mov cx,[si] ;first word
        mov [bx],cx
        mov cx,[si]+2 ;second word
        mov [bx]+2,cx
        mov cx,[si]+4 ;third word
        mov [bx]+4,cx
        sub si,ax ;get si back of first shot
        mov ax,[si-2]
        dec ax
        mov [si-2],ax
        sub bx,6d
        pop cx
        cmp cx,1
        jz donot
        dec cx 
        donot:
        push cx
        next: 

        
        ;here check shots and walls
        
        add bx,6d   
        pop cx
    loop check_del_shots_bridge11
    pop bx
    
    
    call drawshots 
    call moveshots ;mov shots and clear old shots the from screen 

    popa
    ret
process_shots endp




moveshots proc near
    pusha  
    
    
    mov cx,[bx]-2
    cmp cx,0
    jnz moveshotsloop
    popa
    ret
    moveshotsloop:
        push cx         
        mov al ,00h  ;remove(from screen) shot before moving ant itwill redrawn in next iteration 
        call drawpx 
        
        mov ax,[bx]+4
        and al ,0000000003h
    
        cas_1:    
            cmp al , 0d
            jnz cas_2
            mov si,[bx +2] 
            ;--
            cmp si,shootspeed
            jb overflow1 ; over flow check
            sub si ,shootspeed 
            jmp nooverflow1
            overflow1:
            mov si,0
            nooverflow1:
            ;--
            mov [bx+2],si
            jmp finish2
        cas_2:
            cmp al ,1d
            jnz cas_3
            mov si,[bx] 
            ;---
            cmp si,0fffdh 
            ja overflow2 ; over flow check ; it will never exceed that number before delete (casue of map borders)
            add si ,shootspeed 
            jmp nooverflow2
            overflow2:
            mov si,0
            nooverflow2:
            ;---
            mov [bx],si
            jmp finish2
        cas_3:    
            cmp al , 2d 
            jnz cas_4
            mov si,[bx]
            ;---
            cmp si,shootspeed
            jb overflow3 ; over flow check
            sub si ,shootspeed 
            jmp nooverflow3
            overflow3:
            mov si,0
            nooverflow3:
            ;---
            mov [bx],si 
            jmp finish2
        cas_4:    
            cmp al , 3d
            jnz finish2
            mov si,[bx +2]
            ;---
            cmp si,0fffdh 
            ja overflow4 ; over flow check ; it will never exceed that number before delete (casue of map borders)
            add si ,shootspeed 
            jmp nooverflow4
            overflow4:
            mov si,0
            nooverflow4:
            ;---
            mov [bx+2],si
        finish2:
        add bx,6d   
        pop cx       
    loop moveshotsloop
    popa
    ret     
moveshots endp 


drawshots proc near
    pusha 
    ; now bx on first shot
    mov cx,[bx-2] 
    cmp cx,0
    jnz drawshotsloop 
    popa
    ret
    drawshotsloop:
         mov al ,0fh
         call drawpx
         add bx,6d
    loop drawshotsloop
    popa
    ret  
drawshots endp



damagewall proc near  
    pusha 
    ;----------------------------   1 
    mov di,21d
    vrmup:     ;vertical removal up then down
    mov cx,damagedwall_pos
    mov dx,damagedwall_pos+ 2
    sub dx,di
    ;----
    push cx
    push dx
    push di 
    mov bh,0
    mov ah,0dh
    int 10h
    pop di
    pop dx
    pop cx   
    ;----
    cmp al,0ch
    jz damage1
    cmp al,0eh
    jnz remove1
    mov al,0h
    jmp remove1
    damage1:
    cmp damagedwall_pos+4,2
    jz strongdamage1
        mov al,0eh 
        jmp remove1   
    strongdamage1:
    mov al,0h
    remove1:

        
    
    mov si ,damagedwall_pos+ 2
    mov  damagedwall_pos+ 2,dx
    mov bx,offset damagedwall_pos
    call drawpx 
    mov damagedwall_pos +2,si

    dec di
    jnz vrmup
    ;------------------------- 
     ; i wonot process middle pixel as it will be processed in horizontal remove
    ;----------------------------    2 
    mov di,21d
    vrmdw:     ;vertical removal down then down
    mov cx,damagedwall_pos
    mov dx,damagedwall_pos+ 2
    add dx,di
    ;----
    push cx
    push dx
    push di 
    mov bh,0
    mov ah,0dh
    int 10h
    pop di
    pop dx
    pop cx  
    ;---- 
    cmp al,0ch
    jz damage2
    cmp al,0eh
    jnz remove2
    mov al,0h
    jmp remove2
    damage2:
    cmp damagedwall_pos+4,2
    jz strongdamage2
        mov al,0eh 
        jmp remove2   
    strongdamage2:
    mov al,0h
    remove2:
     
    
    mov si ,damagedwall_pos+ 2
    mov  damagedwall_pos+ 2,dx
    mov bx,offset damagedwall_pos
    call drawpx 
    mov damagedwall_pos +2,si

    dec di
    jnz vrmdw
    ;-------------------------  
    
    
    ;----------------------------    3          now horizontal removal right then left
    mov di,21
    hrrmr:     ;horizontal remove right 
    mov cx,damagedwall_pos
    mov dx,damagedwall_pos+ 2
    add cx,di
    ;----
    push cx
    push dx
    push di 
    mov bh,0
    mov ah,0dh
    int 10h
    pop di
    pop dx
    pop cx
    ;----  
    cmp al,0ch
    jz damage3
    cmp al,0eh
    jnz remove3
    mov al,0h
    jmp remove3
    damage3:
    cmp damagedwall_pos+4,2
    jz strongdamage3
        mov al,0eh 
        jmp remove3   
    strongdamage3:
    mov al,0h
    remove3:     
    
    mov si ,damagedwall_pos
    mov  damagedwall_pos,cx
    mov bx,offset damagedwall_pos
    call drawpx 
    mov damagedwall_pos,si
    
    dec di
    jnz hrrmr
    ;------------------------- 
    ;in last loop i removed 20 point right center point so i will go right one step and remove 20 point left ; i will bring it back after all horizontal removing
    mov ax,damagedwall_pos
    inc ax
    mov damagedwall_pos,ax 
    
    ;----------------------------    4 
    mov di,21
    hrrml:     ;horizontal remove left
    mov cx,damagedwall_pos
    mov dx,damagedwall_pos+ 2
    sub cx,di
    ;----
    push cx
    push dx
    push di 
    mov bh,0
    mov ah,0dh
    int 10h
    pop di
    pop dx
    pop cx  
    ;-----
    cmp al,0ch
    jz damage4
    cmp al,0eh
    jnz remove4
    mov al,0h
    jmp remove4
    damage4:
    cmp damagedwall_pos+4,2
    jz strongdamage4
        mov al,0eh 
        jmp remove4   
    strongdamage4:
    mov al,0h
    remove4:      
    
    mov si ,damagedwall_pos
    mov  damagedwall_pos,cx
    mov bx,offset damagedwall_pos
    call drawpx 
    mov damagedwall_pos,si

    dec di
    jnz hrrml
    ;-------------------------  
    
    ;see comments above 
    mov ax,damagedwall_pos
    dec ax
    mov damagedwall_pos,ax 
       
    
    popa
    ret
damagewall endp



DropGifts proc near
	pusha	        
	mov bx,offset GiftsX  
	mov Si,offset GiftsY

	mov [bx],003ch
	mov [bx+2],0064h
	mov [bx+4],0050h
	mov [bx+6],0003h


	mov [bx+8],021ch
	mov [bx+10],0244h
	mov [bx+12],0230h
	mov [bx+14],0003h

	mov [bx+16],012ch
	mov [bx+18],0154h
	mov [bx+20],0140h
	mov [bx+22],0003h

	mov [bx+24],012ch
	mov [bx+26],0154h
	mov [bx+28],0140h
	mov [bx+30],0003h

	mov [bx+32],012ch
	mov [bx+34],0154h
	mov [bx+36],0140h
	mov [bx+38],0003h



	mov [si],00c8h
	mov [si+2],00f0h
	mov [si+4],00dch
	mov [si+6],0003h


	mov [si+8],00c8h
	mov [si+10],00f0h
	mov [si+12],00dch
	mov [si+14],0003h


	mov [si+16],00c8h
	mov [si+18],00f0h
	mov [si+20],00dch
	mov [si+22],0003h

	mov [si+24],0064h
	mov [si+26],008ch
	mov [si+28],0078h
	mov [si+30],0003h

	mov [si+32],012ch
	mov [si+34],0154h
	mov [si+36],0140h
	mov [si+38],0003h




	call Check_Passing_Through_Tank1
	call Check_Passing_Through_Tank2

	mov bx,offset GiftsX  
	mov Si,offset GiftsY
	LOOPS: 
	mov di,05d
	outerloop:

	cmp di,1
	je firstGift
	jmp maybeSecond
	firstGift:
	cmp [bx+6],0000h
	je Black
	jmp lightCyan
	Black:
	mov al,00000000b
	jmp label333
	lightCyan:
	mov al,10000011b
	jmp label333

	maybeSecond:
	cmp di,2
	je SecondGift
	jmp maybeThird
	SecondGift:
	cmp [bx+6],0000h
	je Black
	jmp lightBlue
	lightBlue:
	mov al,00001001b
	jmp label333


	maybeThird:
	cmp di,3
	je ThirdGift
	jmp maybeFourth
	ThirdGift:
	cmp [bx+6],0000h
	je Black
	jmp lightCyan


	maybeFourth:
	cmp di,4
	je FourthGift
	jmp DefinitelyFifth
	FourthGift:
	cmp [bx+6],0000h
	je Black
	jmp lightBlue


	DefinitelyFifth:
	cmp [bx+6],0000h
	je Black
	jmp lightCyan


	label333:
	mov cx,[bx]
	mov dx,[si] 

	innerloop:
	mov ah,0ch
	push bx 
	mov bh,00
	pop bx
	int 10h
	inc cx
	cmp cx,[bx+2]
	je label0
	jmp innerloop
	label0:
	cmp dx,[si+2]
	je label222
	sub cx,0028h
	inc dx    

	jmp innerloop
	label222:
	add bx,08d
	add si,08d
	dec di
	jnz outerloop

	mov bx,offset GiftsX
	mov Si,offset GiftsY
	cmp [bx+6],0000h
	je firstBlack
	jmp start
	firstBlack:
	cmp [bx+14],0000h
	je SecondBlack
	Jmp start
	SecondBlack:
	cmp [bx+22],0000h
	je ThirdBlack
	Jmp start
	ThirdBlack:
	cmp [bx+30],0000h
	je FourthBlack
	Jmp start
	FourthBlack:
	cmp [bx+38],0000h
	je RemoveBlack
	Jmp start
	RemoveBlack:
	mov [bx+6],0003h
	mov [bx+14],0003h
	mov [bx+22],0003h
	mov [bx+30],0003h
	mov [bx+38],0003h
	jmp LOOPS
	start:
	popa
	ret
DropGifts endp 



Check_Passing_Through_Tank1 proc
	pusha
	
	mov bx,offset GiftsX
	mov Si,offset GiftsY
	mov Di,offset Tank1
	mov cx,05d
	loop11:
	mov dx,[di+48]
    cmp [bx+4],dx
	jae label11 
	jmp label22
	label11:
	mov ax,00
	mov ax,[bx+4]
	sub ax,[di+48]
	cmp ax,0028h
	jb label33
	jmp label44
	label33:
	jmp checkYy
	label22:
	add ax,00h
	mov ax,[di+48]
	sub ax,[bx+4]
	cmp ax,0028h
	jb label33
	label44:
	add bx,08d
	add si,08d
	loop loop11
	jmp tt
	checkYy:
	mov dx,[di+50]
	cmp [si+4],dx
	jge labelaa
	jmp labelbb
	labelaa:
	add ax,00h
	mov ax,[si+4]
	sub ax,[di+50]
	cmp ax,0028h
	jb labelcc
	jmp label4
;---
jmp bridgeloop11
bridgeloop11: jmp loop11
nobridgeloop11:
;---
	labelcc:
	jmp applyy
	labelbb:
	add ax,00
	mov ax,[di+50]
	sub ax,[si+4]
	cmp ax,40d
	jb labelcc
	add bx,08d
	add si,08d
	loop bridgeloop11
	applyy:
	cmp cx,1
	je boost_HPp
	cmp cx,3
	je boost_HPp
	cmp cx,5
	je boost_HPp
	cmp cx,2
	jmp boost_Powerr
	boost_HPp:
	cmp [bx+6],0003h
	je ForSure11
	add bx,08d
	add si,08d
	loop bridgeloop11
	ForSure11:
	mov dx,[di+52]
	mov dh,07d
	mov [di+52],dx
	and [bx+6],0000h
	add bx,08d
	add si,08d
	loop bridgeloop11
	boost_Powerr:
	cmp [bx+6],0003h
	je ForSure22
	add bx,08d
	add si,08d
	loop bridgeloop11
	ForSure22:
	mov dx,[di+52]
	OR  dx,0000000000100000b 
	And dx,1111111111101111b
	mov [di+52],dx
	and [bx+6],0000h
	add bx,08d
	add si,08d
	loop bridgeloop11
	tt:
	popa
	ret
Check_Passing_Through_Tank1 endp


Check_Passing_Through_Tank2 proc near

	pusha
	mov bx,offset GiftsX
	mov Si,offset GiftsY
	mov Di,offset Tank2
	mov cx ,05d
	loop1:
	mov dx,[di+48]
    cmp [bx+4],dx
	jge label1 
	jmp label2
	label1:
	add ax,00
	mov ax,[bx+4]
	sub ax,[di+48]
	cmp ax,40d
	jb label3
	jmp label4
	label3:
	jmp checkY
	label2:
	add ax,00
	mov ax,[di+48]
	sub ax,[bx+4]
	cmp ax,40d
	jb label3
	label4:
	add bx,08d
	add si,08d
	loop loop1
	jmp cc
	checkY:
	mov dx,[di+50]
	cmp [si+4],dx
	jge labela 
	jmp labelb
	labela:
	add ax,00
	mov ax,[si+4]
	sub ax,[di+50]
	cmp ax,40d
	jb labelc
	jmp label4
;---
jmp bridgeloop1
bridgeloop1: jmp loop1
nobridgeloop1:
;---
	labelc:
	jmp apply
	labelb:
	add ax,00
	mov ax,[di+50]
	sub ax,[si+4]
	cmp ax,40d
	jb labelc
	add bx,08d
	add si,08d
	loop bridgeloop1
	apply:
	cmp cx,1
	je boost_HP
	cmp cx,3
	je boost_HP
	cmp cx,5
	je boost_HP
	cmp cx,2
	jmp boost_Power
	boost_HP:
	cmp [bx+6],0003h
	je ForSure1
	add bx,08d
	add si,08d
	loop bridgeloop1
	ForSure1:
	mov dx,[di+52]
	mov dh,07d
	mov [di+52],dx
	and [bx+6],0000h
	add bx,08d
	add si,08d
	loop bridgeloop1
	boost_Power:
	cmp [bx+6],0003h
	je ForSure2
	add bx,08d
	add si,08d
	loop bridgeloop1
	ForSure2:
	mov dx,[di+52]
	OR  dx,0000000000100000b 
	And dx,1111111111101111b
	mov [di+52],dx
	and [bx+6],0000h
	add bx,08d
	add si,08d
	loop bridgeloop1
	cc:
	popa
	ret
Check_Passing_Through_Tank2 endp


end main
                                 
                                 2
