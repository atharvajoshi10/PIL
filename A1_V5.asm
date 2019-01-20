	.model  small
    	.stack  64
dim1	EQU	99

input	MACRO	
	mov	ah,01h
	int	21h
	endm

tonum	MACRO	l
	sub	l[di],ax
	endm

	
print	MACRO	msg
	lea	dx,msg
	mov 	ah,09h
	int	21h
	endm

	.data
list	dw	dim1 DUP(0)
dig1	db	0
dig2	db	0
dig3	db	0
temp	dw	0
s	dw	0
we	db	'Enter Count:','$'
count	dw	?
nl	db	10,13,'$'
	

	.code
main	proc	far
	mov	ax,@data
	mov	ds,ax
	print	we
	
;Input Count 2 digit
	input
	mov	bh,00h
	mov	bl,0Ah
	mov	ah,00h
	sub	al,30h
	mul	bl
	mov	bx,00h
	mov	bl,al
	input
	sub	al,30h
	mov	ah,00h	
	add	al,bl
	mov	count,ax
	mov	cx,count
	print nl
	

	mov	di,00h
;Accept Array Elements
do:	input
	mov	bh,00h
	mov	bl,0Ah
	mov	ah,00h
	sub	al,30h
	mul	bl
	mov	bx,00h
	mov	bl,al
	input
	sub	al,30h
	mov	ah,00h	
	add	al,bl
	mov	list[di],ax
	print	nl
	inc	di
	inc	di
	loop	do

;Code for summing
	mov di,0
	mov	cx,00h
	mov cx,count
	mov	ax,00h
	
sum:
	add	ax,list[di]
	inc	di
	inc di
	loop sum
	
	mov	s,ax
;Convert Final Sum to Ascii again and print
	mov	bl,64h
	mov	bh,00h
	mov	dx,00h
	div	bx
	add 	ax,30h
	mov	temp,dx
	mov	dx,00h
	mov	dx,ax
	mov	ah,02h
	int	21h
	;1st digit printed
	
	mov	ax,00h
	mov	ax,temp
	mov	bx,00h
	mov	bx,0Ah
	mov	dx,00h
	div	bx
	add 	ax,30h
	mov	temp,dx
	mov	dx,00h
	mov	dx,ax
	mov	ah,02h
	int	21h
	;2nd digit printed
	
	mov	ax,00h
	mov	ax,temp
	add	ax,30h
	mov	dx,00h
	mov	dx,ax
	mov	ah,02h
	int 	21h
	;3rd	digit printed

	input

;Terminate
	mov	ax,4C00h
	int	21h
main	endp
	end	main
