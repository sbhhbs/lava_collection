jcs	.MACRO
	bcc .L
	jmp ?1
.L
	.ENDM
jne	.MACRO
	beq .L
	jmp ?1
.L
	.ENDM
phx	.MACRO
	txa
	pha
	.ENDM

plx	.MACRO
	pla
	tax
	.ENDM
ALLOC	.MACRO
?2 = __BASE
__BASE = __BASE + ?1
	.ENDM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SND_BUFSIZE	=$3e0
SND_BUFADDR	=$2000
SND_TICK_MAX	=63
;;;;;;;;;;;;;;;;;;;;;;;;;;
DSP_Busy	=$e093
DSP_Start	=$e0a8
DSP_End		=$e0ae
send_byte	=$e0b4
Wait		=$e0ba
FileRead	=$0516
PlayInit	=$094e
PlayStop	=$094f
;;;;;;;;;;;;;;;;;;;;;;;;;;
databufptr	=$e0
playptr		=$fb
playnum		=$a2c
datasize	=$8c6
filehandle	=$8c8
state		=$23e9
__BASE		=$1000
 ALLOC		1,status
 ALLOC		1,sndfp
 ALLOC		4,sndtype
 ALLOC		4,playlen
 ALLOC  	1,tick
 ALLOC		1,tmp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 .org $23ea
ChkBusy:
 ldx #$f0
CB_Loop:
 jsr Wait
 jsr DSP_Busy
 bcc CB_End
 dex
 bne CB_Loop
 sec
CB_End:
 rts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SndOpen:
 int PlayInit
 bcc End_0
End_1:
 lda #$ff
 .db $2c
End_0:
 lda #$00
 sta status
 rts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SndPlayFile:
 lda filehandle
 sta sndfp
 lda #0
 sta tick
 sta playnum
 sta state
SndResume:
 lda #$c0
 sta $1c
 jsr ChkBusy
 bcs End_1
 lda sndtype+2
 jsr DSP_Start
 bcc End_1
 lda #$ff
 sta state
 lda sndtype+2
 beq End_0
 jsr ChkBusy
 bcs End_1
 lda #$22
 jsr send_byte
 bcc End_1
 lda #$02
 jsr send_byte
 bcc End_1
 lda sndtype
 jsr send_byte
 bcc End_1
 lda sndtype+1
 jsr send_byte
 bcc End_1
 bcs End_0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SndPause:
 int PlayStop
 lda #0
 sta state
 rts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SndIfEnd:
 lda state
 beq End_0
 lda playnum
 jne SIE_Send_Bytes
 lda playlen+2
 bne SIE_Len_Else
 lda playlen+1
 cmp #>SND_BUFSIZE
 bne SIE_Cmp_Next0
 lda playlen
 cmp #<SND_BUFSIZE
SIE_Cmp_Next0:
 BCS SIE_Len_Else
 lda playlen
 sta datasize
 lda playlen+1
 sta datasize+1
 jmp SIE_Read
SIE_Len_Else:
 lda #<SND_BUFSIZE
 sta datasize
 lda #>SND_BUFSIZE
 sta datasize+1
SIE_Read:
 lda #<SND_BUFADDR
 sta databufptr
 sta playptr
 lda #>SND_BUFADDR
 sta databufptr+1
 sta playptr+1
 lda sndfp
 sta filehandle
 int FileRead
 bcs SIE_End_1
 sec
 lda playlen
 sbc datasize
 sta playlen
 lda playlen+1
 sbc datasize+1
 sta playlen+1
 bcs SIE_Dec
 dec playlen+2
SIE_Dec:
 lda datasize
 sta tmp
 lsr datasize+1
 ror
 lsr datasize+1
 ror
 lsr
 lsr
 lsr
 sta playnum
 bne SIE_Send_Bytes
 jsr ChkBusy
 bcs SIE_End_1
 lda tmp
 bne SIE_Last_Bytes
 jsr DSP_End
 lda #0
 sta state
SIE_End_1:
 jmp End_1
SIE_Last_Bytes:
 jsr Send_ABytes
 bcs SIE_End_1
 bcc SIE_End
SIE_Send_Bytes:
 ldx #0
SIE_Loop:
 phx
 jsr ChkBusy
 bcs SIE_End_1
 lda #4
 jsr Send_ABytes
 bcs SIE_End_1
 plx
 inx
 cpx #8
 bcc SIE_Loop
 dec playnum
SIE_End:
 inc tick
 lda tick
 cmp #SND_TICK_MAX
 bcc SIE_End_0
 lda #0
 sta tick
SIE_End_0:
 jmp End_0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Send_ABytes:
 sta tmp
 lda #$22
 jsr send_byte
 bcc Send_Error
 lda tmp
 jsr send_byte
 bcc Send_Error
 ldy #0
Sned_Loop:
 lda (playptr),y
 jsr send_byte
 bcc Send_Error
 iny
 cpy tmp
 bcc Sned_Loop
Send_Secceed:
 clc
 lda playptr
 adc tmp
 sta playptr
 bcc Send_adc
 inc playptr+1
Send_adc:
 clc
 rts
Send_Error:
 sec
 rts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;.dw SndOpen,SndPlayFile,SndIfEnd,SndPause,SndResume