  .org $2000
scandisk:
        lda	#1
	clc
	adc	$087B          ;ActiveSBpos

	cmp	#5
	bcc	ok_bitmap_posi

	sec
	sbc	#5

ok_bitmap_posi:
        TAX
        LDA $087C,X
        STA $0A12
        TXA
        ASL
        TAX
        LDA $0881,X
        STA $0A13
        INX
        LDA $0881,X
        STA $0A14

	;lm2	len,#BNUM/8
	LDA #$00
	STA $0A16
	LDA #$01
        STA $0A17

	;lm2	NORbufptr,#RecBuf
	LDA #$00
	STA $DB
	LDA #$0B
        STA $DC
	INT	$0508          ;__NorReadBytes

	;lm2	a5,#0
	LDA #0
	STA $88
	STA $89
	;lm2	a1,#RecBuf
        STA $80
        LDA #$0B
        STA $81

	;add	a1,#(BNUM-48)/8,a2
	CLC
	LDA $80
	ADC #$FA
	STA $82
	LDA $81
	ADC #$00
	STA $83

	ldy	#0
chk_used_loop:
	lda	($80),y
	cmp	#$ff
	beq	chk_forward

	ldx	#0
chk_asl_loop:
	asl
	bcs	chk_asl
	;inc2	a5
	INC $88
	BNE chk_asl
	INC $89
chk_asl:
	inx
	cpx	#8
	bcc	chk_asl_loop
chk_forward:
	;inc2	a1
	INC $80
	BNE INCCC
	INC $81
INCCC:
	;cmp2	a1,a2
	LDA $81
	CMP $83
	BNE CMPPPP
	LDA $80
	CMP $82
CMPPPP:
	bcc	chk_used_loop

	;add	a5,#48
	CLC
	LDA $88
	ADC #$30
	STA $88
	BNE ADDDD
	INC $89
ADDDD:                    ;$88,$89
	rts