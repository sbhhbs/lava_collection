;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
qc1c6:
 int $c722
 lda #$00
 sta $03bc
 sta $03c1
 sta $03c2
 lda $03b1
 sta $03ba
 lda $03b2
 sta $03bb
qc214:
 asl $03ba
 rol $03bb
 bcs qc245
 lda $0395
 sta $80
 asl $80
 dec $80
 lda $03c2
 cmp $80
 bcs qc25c
 jsr qc352
qc245:
 inc $03c2
 inc $03c2
 inc $03c1
 lda $0395
 sta $80
 asl $80
 lda $03c2
 cmp $80
 bcc qc214
qc25c:
 lda #$00
 sta $03b1
 sta $03b2
 int $c723
 int $c71a
 rts

qc352:
 lda #$00
 sta $03c0
 int $c725
 lda $80
 sta $03be
 lda $81
 sta $03bf
qc364:
 lda $03be
 sta $80
 lda $03bf
 sta $81
 int $c726
 clc
 lda $80
 adc #$c0
 sta $80
 lda $81
 adc #$02
 sta $81
 ldy #$00
 lda ($80),y
 cmp #$9e
 beq qc3bf
 cmp #$a1
 bcs qc393
 int $c704
 jsr qc6f7
 jmp qc3ac
qc393:
 sta $92
 LDY #$01
 lda ($80),y
 sta $93
 int $c701
 int $c70b
 inc $03c0
 inc $03be
 bne qc3ac
 inc $03bf
qc3ac:
 inc $03c0
 inc $03be
 bne qc3b7
 inc $03bf
qc3b7:
 lda $03c0
 cmp #$14
 bcc qc364
 rts
qc3bf:
 lda #$00
 int $c704
 jsr qc6f7
 inc $03c0
 inc $03be
 bne qc3d2
 inc $03bf
qc3d2:
 lda $03c0
 cmp $0394
 bcc qc3bf
 rts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
qc6f7:
 lda $03c2
 asl
 asl
 asl
 asl
qc6fe:
 sta $82
 lda $03b7
 ora #$7f
 bmi qc709
 lda #$00
qc709:
 sta $86
 ldx #$00
qc70d:
 ldy $82
 lda $d2a6,y
 sta $80
 lda $d2a7,y
 sta $81
 lda $0280,x
 eor $86
 sta $88
 ldy $03c0
 bne qc735
 lda $88
 and #$7f
 sta $88
 lda ($80),y
 bpl qc735
 lda $88
 ora #$80
 sta $88
qc735:
 lda $88
 sta ($80),y
 inc $82
 inc $82
 inx
 cpx #$10
 bcc qc70d
 rts