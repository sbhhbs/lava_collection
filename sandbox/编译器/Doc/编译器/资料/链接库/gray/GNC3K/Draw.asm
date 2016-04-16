 .org $0
Draw:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Draw
 pha
 lda #$80
 sta $80
 lda #$63
 sta $81
 lda #$50
 sta $82
 pla
 bne Draw_0
Draw0_loop0:
 ldx #2
Draw0_loop1:
 ldy #$27
 clc
Draw0_loop2:
 lda ($80),y
 rol
 sta ($80),y
 dey
 bpl Draw0_loop2
 dex
 bne Draw0_loop1
 clc
 lda #$28
 adc $80
 sta $80
 bcc Draw0_adc
 inc $81
Draw0_adc:
 dec $82
 bne Draw0_loop0
 rts
Draw_0:
 cmp #1
 bne Draw_1
Draw1_loop0:
 ldx #2
Draw1_loop1:
 ldy #0
 clc
Draw1_loop2:
 lda ($80),y
 ror
 sta ($80),y
 iny
 cpy #$28
 bne Draw1_loop2
 dex
 bne Draw1_loop1
 clc
 lda #$28
 adc $80
 sta $80
 bcc Draw1_adc
 inc $81
Draw1_adc:
 dec $82
 bne Draw1_loop0
Draw_1:
 cmp #4
 bne Draw_2
Draw2_loop0:
 lda #$13
 sta $83
 lda #$14
 sta $84
Draw2_loop1:
 ldy $83
 lda ($80),y
 pha
 ldy $84
 lda ($80),y
 tax
 lda $7700,x;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ldy $83
 sta ($80),y
 pla
 tax
 lda $7700,x;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ldy $84
 sta ($80),y
 inc $84
 dec $83
 bpl Draw2_loop1
 clc
 lda #$28
 adc $80
 sta $80
 bcc Draw2_adc
 inc $81
Draw2_adc:
 dec $82
 bne Draw2_loop0
 rts
Draw_2:
 cmp #5
 bne Draw_3
 lda #$d8
 sta $82
 lda #$6f
 sta $83
 lda #$28
 sta $84
Draw3_loop0:
 ldy #$27
Draw3_loop1:
 lda ($82),y
 tax
 lda ($80),y
 sta ($82),y
 txa
 sta ($80),y
 dey
 bpl Draw3_loop1
 clc
 lda #$28
 adc $80
 sta $80
 bcc Draw3_adc0
 inc $81
Draw3_adc0:
 sec
 lda $82
 sbc #$28
 sta $82
 bcs Draw3_adc1
 dec $83
Draw3_adc1:
 dec $84
 bne Draw3_loop0
Draw_3:
 rts