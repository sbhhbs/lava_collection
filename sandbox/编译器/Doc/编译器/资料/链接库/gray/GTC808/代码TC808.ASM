 .org $79c8
Point1:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Point1
 eor #$ff
 and ($80),y
 ora $79c4,x
 sta ($80),y
 rts
Point2:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Point2
 ora $79c0,x
 sta ($80),y
 rts
Block1:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Block1
 sta ($94),y
 lda $80
 eor #$ff
 and $fe
 ora ($94),y
 sta ($94),y
 rts
Block2:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Block2
 and ($94),y
 sta ($94),y
 lda $80
 eor #$ff
 and $ff
 ora ($94),y
 sta ($94),y
 rts
ClearScreen:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;ClearScreen
 ldy #0
 lda $fe
 rts
GetPoint:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;GetPoint
 and ($80),y
GetPoint_0:
 cpx #3
 beq GetPoint_1
 lsr
 lsr
 inx
 bne GetPoint_0
GetPoint_1:
 sta $80
 rts
TextOut:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;TextOut
 bcc TextOut_0
 inc $93
TextOut_0:
 ldx #0
 stx $80
 lda $3d1
 cmp #4
 beq TextOut_1
 ldy #1
 sty $80
TextOut_1:
 cmp #16
 beq TextOut_2
 lda #16
 .db $24
TextOut_2:
 asl
 sta $81
 ldy #0
TextOut_loop0:
 tya
 pha
 lda ($92),y
 pha
TextOut_loop1:
 ldy #$4
TextOut_loop2:
 pla
 asl
 pha
 bcc TextOut_white
 lda $ff
 bcs TextOut_next
TextOut_white:
 lda $fe
TextOut_next:
 asl
 rol $7fc0,x
 asl
 rol $7fc0,x
 dey
 bne TextOut_loop2
 inx
 txa
 and $80
 bne TextOut_loop1
 pla
 pla
 tay
 iny
 cpy $81
 bcc TextOut_loop0
 lda #$c0
 sta $92
 lda #$7f
 sta $93
 rts
WriteBlock1:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;WriteBlock1
 asl
 sta $03cf
 rts
WriteBlock2:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;WriteBlock2
 sta $90
 lda $3d3
 eor #$ff
 and $2a0,y
 ora $90
 rts
WriteBlock3:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;WriteBlock3
 cmp #5
 beq wb_start
 jmp $ae2f;;;;;;;;;;;;;;;;;;;;;;
wb_start:
 lda $3d0
 eor #$ff
 and $2a0
 sta $2a0
 ldy $3d4
 dey
 lda $3d3
 eor #$ff
 and $2a0,y
 sta $2a0,y
 ldy #0
 rts
printf:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;printf
 lda #$ff
 sta $3af
 sta $3b0
 int $c719
 lda #$c0
 sta $80
 lda #$19
 sta $81
 lda #$80
 sta $82
 lda #$13
 sta $83
 lda #16
 sta $86
printf_loop0:
 ldy #0
printf_loop1:
 lda ($80),y
 ldx #4
printf_asl1:
 asl
 php
 rol $84
 plp
 rol $84
 dex
 bne printf_asl1
 ldx #4
printf_asl2:
 asl
 php
 rol $85
 plp
 rol $85
 dex
 bne printf_asl2
 tya
 tax
 asl
 tay
 lda $84
 sta ($82),y
 iny
 lda $85
 sta ($82),y
 txa
 tay
 iny
 cpy #100
 bcc printf_loop1
 clc
 lda $80
 adc #100
 sta $80
 bcc printf_adc1
 inc $81
printf_adc1:
 clc
 lda $82
 adc #200
 sta $82
 bcc printf_adc2
 inc $83
printf_adc2:
 dec $86
 bne printf_loop0
 rts
getchar:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;getcgar
 lda $c7
 bmi getchar_0
 lda #0
 sta $03f7;;;;;;;;;;;;;;;;;;;;
 jmp getchar
getchar_0:
 lda $c7
 cmp #$a1
 beq getchar_1
 cmp #$98
 beq getchar_1
 cmp #$80
 bcc getchar_2
 cmp #$8d
 bcs getchar_2
getchar_1:
 int $c003;;;;;;;;;;;;;;;;;;;;;;;;;;
 int $c004;;;;;;;;;;;;;;;;;;;;;;;;;;
getchar_2:
 jsr $9c38;;;;;;;;;;;;;;;;;;;;;;;;;;
 rts
 ;.dw Point1,Point2,Block1,Block2,ClearScreen,GetPoint,TextOut,WriteBlock1,WriteBlock2,WriteBlock3,printf,getchar