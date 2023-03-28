[org 0x7e00]

jmp MoreBits

%Include "gdt.asm"
%Include "print.asm"

MoreBits:
	call enableA20
	cli
	lgdt [gdt_descriptor]
	mov eax, cr0
	or eax, 1
	mov cr0, eax
	jmp codeseg:StartProtectedMode

enableA20:
	in al, 0x92
	or al, 2
	out 0x92, al
	ret

[bits 32]

StartProtectedMode:

	mov ax, dataseg
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax


	mov eax, 0x00ff
	mov ebx, 0xb8000
	mov ecx, 2000
	bk2:
		mov [ebx], byte 0xdb
		add ebx, 1
		
		mov [ebx], byte 0x0f
		add ebx, 1
		loop bk2
		
	jmp $

times 2048-($-$$) db 0