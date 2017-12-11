;Question 2

INCLUDE Irvine32.inc
BUFMAX = 80
CBUFMAX = 2

.386
.model flat,stdcall
.stack 4096
	ExitProcess proto,dwExitCode:dword
	WriteDec PROTO
	WriteString PROTO
	WriteChar PROTO
	Crlf PROTO
	ReadString PROTO
	DumpRegs PROTO
	Delay PROTO

.data
    sPrompt BYTE "Enter the plaint text : ",0
	sPrompt2 BYTE "Enter the key        : ",0
	sEncrypt BYTE "Cipher text:           ",0
	sDecrypt BYTE "Decrypted:             ",0
	buffer BYTE BUFMAX+1 DUP(0)
	key BYTE BUFMAX+1 DUP(0)
	bufSize DWORD ?
	
.code
main PROC

	call InputTheString			;input plain
	call InputTheChar			;input key
	call TranslateBuffer		;encrypt 
	move edx,OFFSET sEncrypt	;display encrypted text
	call DisplayMessage
	call TranslateBuffer		;decrypt
	move edx,OFFSET sDecrypt    ;display decrypted text
	call DisplayMessage


	exit
main ENDP

InputTheString PROC

	pushad
	mov edx,OFFSET sPrompt		 ;display a prompt
	call WriteString			 
	move ecx,BUFMAX				 ;maximum character count
	mov edx,OFFSET buffer		 ;point to the buffer
	call ReadString			     ;input string
	mov bufSize,eax				 ;save lenght
	call Crlf
	popad
	ret
InputTheString ENDP

InputTheChar PROC

	pushad
	mov edx,OFFSET sPrompt2		 ;display a prompt
	call WriteString			 ;write it out
	call Crlf					 ;clear the line
	mov edx,OFFSET key			 ;get the address of char deposit
	mov ecx,CBUFMAX				 ;get the ASCII 
	call ReadString				 ;double space
	call Crlf					 ;double space
	popad
	ret
InputTheChar ENDP

DisplayMessage PROC
	
	pushad
	call WriteString
	mov edx,OFFSET buffer		 ;display buffer
	call WriteString
	call Crlf
	call Crlf
	popad
	ret
DisplayMessage ENDP

TranslateBuffer PROC
	
	pushad
	mov ecx,bufSize				 ;loop counter
	mov esi,0					 ;index 0 in buffer
L1:
	xor buffer[esi],key			 ;translate a byte
	inc esi						 ;point to next byte
	loop L1

	popad
	ret
TranslateBuffer ENDP
END main