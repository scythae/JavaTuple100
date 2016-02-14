format pe
include '..\INCLUDE\win32a.inc'

.start:
	mov ecx,1
.printnewline:
	mov eax,ecx
	mov ebx,integerValAnsi
	call .itoa10

	mov eax,part1
	call .printf
	mov eax,integerValAnsi
	call .printf
	mov eax,part2
	call .printf
	call .printparams
	
	mov eax,part3
	call .printf

	inc ecx
	cmp ecx, [linecount]
	jna .printnewline
.end:	
	cinvoke system,pauseCommand
	cinvoke ExitProcess,0

.printparams:
	pusha
	mov edx,0	
.newparam:
	mov eax,edx
	mov ebx,integerValAnsi
	call .itoa10

	mov eax,underline
	call .printf
	mov eax,integerValAnsi
	call .printf
.checklastparam:
	inc edx 
	cmp edx, ecx;
	jnl .printparams_end
.printcomma:
	mov eax,comma
	call .printf
	jmp .newparam
.printparams_end:
	popa
	ret

.printf:
; prints a null-terminated string.
; eax - contains pointer to string.
	pusha
	cinvoke printf,eax
	popa
	ret
.itoa10:
; converts an integer val to null-terminated string.
; eax - contains integer val.
; ebx - contains pointer to string what will be returned.
	pusha
	cinvoke itoa,eax,ebx,10
	popa
	ret	

part1 db 'class Tuple',0
part2 db ' {public Object ',0
part3 db ';}',13,10,0
underline db '_',0
comma db ',',0
pauseCommand db 'pause',0
integerValAnsi db 0,0,0
linecount dd 10

data import
    library kernel32,'KERNEL32.DLL',\
	    crtdll,'CRTDLL.DLL'

    import kernel32,\
	    ExitProcess,'ExitProcess'
    import crtdll,\
	    printf,'printf',\
	    itoa,"_itoa",\
	    system,"system"
end data
