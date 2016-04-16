INC2	.MACRO
	inc ?1
	bne .L
	inc ?1+1
.L
	.ENDM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DEC2	.MACRO
	lda ?1
	bne .L
	dec ?1+1
.L
	dec ?1
	.ENDM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ALLOC	.MACRO
?2 = __BASE
__BASE = __BASE + ?1
	.ENDM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;常量
hd_debug_max    = $1000         ;延时
hd_delay_max    = $80          ;数据包延时

hand_signal1	= '>'
hand_signal2    = '<'
hand_signal3    = '-'
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;地址
CODEBUF 	= $1000		;代码定义起始地址
VARBUF          = $f0           ;变量定义起始地址
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;系统
watchdog        = $3f6

switch_bank     .MACRO
		lda     $3d
		.IF     ?1 != 3
		and     #$fc
		.ENDIF
		.IF     ?1 > 0
		.IF     ?1 < 3
		ora     #?1
		.ENDIF
		.IF     ?1 == 3
		ora     #3
		.ENDIF
		.ENDIF
		sta     $3d
		.ENDM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
__BASE		= VARBUF
 ALLOC          2, ptr
 ALLOC		2, rdata                ;多用途
 ALLOC          2, hd_debug_count
 ALLOC          1, ecc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;代码
 .org CODEBUF
;初始化计数器为hd_debug_max
hd_debug_init:
	lda	#<hd_debug_max
	sta	hd_debug_count
	lda	#>hd_debug_max
	sta	hd_debug_count + 1
	rts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;计数器递减，并判断是否为0
hd_debug:
	DEC2	hd_debug_count
	lda	hd_debug_count + 1
	ora	hd_debug_count
	cmp	#0
	rts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;打开com口
ComOpen:
	switch_bank	0
	lda	#4
	sta	$3d;IVReg			;UART CLOCK enable = 1
	lda	#1
	sta	$3b;LCReg			;N 8 1
        lda	#$20
	sta	$3e
        lda	$043a
	ora	#$10
	sta	$3f
	sta	$043a
        lda	$043b
	ora	#$10
	sta	$1e
	sta	$043b
			;Disable_Irda
	switch_bank	3
	lda #$80
	sta $3a
	sta $3c
	switch_bank	1
			;lm	IRCReg,#0
	lda     #0
	sta     $3b
	lda	#$30
	sta	$3d;FCReg			;CHW clear T&R FIFO; switch bank 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;brui_reset
	jsr	hd_debug_init
brui_reset_loop:
        switch_bank       0
        lda     #0
        sta     $3d;IVReg
        lda     #4
        sta     $3d;IVReg
        switch_bank       0
        lda     $3b;LSReg
        cmp     #$60
	beq	brui_clear_ok
	jsr	hd_debug
	bne	brui_reset_loop
	jmp     error
brui_clear_ok:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	switch_bank	1
	lda     rdata
	and     #7
	sta	$3a;BSReg
        switch_bank	0
	lda     #0
	sta     $3c
	switch_bank	2
	lda     #$20;#00100000b
	sta     $3c;TMReg
	bne     rdata_init
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;关闭com口
ComClose:
	switch_bank	0	;没有握手信号
	lda	$3d;IVReg
	and	#$fb
	sta	$3d;IVReg		;UART CLOCK enable = 0
	switch_bank	2
	lda	#0
	sta	$3c;TMReg		;diable UART
        rts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;将寄存器A的数据发送到com口,成功则C = 0否则C = 1
rout:
	pha
	switch_bank	0
	jsr	hd_debug_init
wait_txr:
	lda	$3b;LSReg
	and	#$20
	bne	tx_ready
	jsr	hd_debug
	bne	wait_txr
        jsr     error
	pla
	pla
	pla
	rts
tx_ready:
        pla
	sta	$3a;THReg
	rts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;发送一个字节数据,返回-1出错
ComPutc:
        lda     rdata
        jsr     rout
        jmp     rdata_init
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
get_endptr:		;size = size + ptr
        clc
	lda     rdata
	adc     ptr
	sta     rdata
	lda     rdata + 1
	adc     ptr + 1
	sta     rdata + 1
	rts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;发送数据块,成功则返回0，否则返回-1
ComWrite:
	jsr     get_endptr
        ldy     #0
        sty     ecc
rwrite_loop:
	lda     ptr + 1
	cmp     rdata + 1
	bne     rwrite_start
	lda     ptr
	cmp     rdata
	beq	sent_ecc
rwrite_start:
	lda     (ptr), y
	jsr	rout
	eor     ecc
	sta     ecc
	INC2    ptr
	bne     rwrite_loop
	beq	rwrite_loop
sent_ecc:
	lda     ecc
	jsr	rout
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;返回-1或0
rdata_init:
	lda	#0
	.db     $2c
error:
	lda     #$ff
	sta	rdata
	sta     rdata + 1;
	rts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;从com口接收数据到寄存器A中,成功则C = 0否则C = 1
rin:
	switch_bank	0
	jsr	hd_debug_init
wait_rxr:
	lda	$3b;MCReg
	and	#1
	bne	rx_ready
	jsr	hd_debug
	bne	wait_rxr
	sec
	rts
rx_ready:
        lda     $3a;RHReg
        clc
	rts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;接收一个字节数据,返回-1出错
ComGetc:
	jsr     rin
	bcs     error
	sta     rdata
	lda     #0
	sta     rdata + 1
	rts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;接收数据块,成功则返回0，否则返回-1
ComRead:
	jsr	get_endptr
        ldy	#0
        sty     ecc
rread_loop:
	lda	ptr + 1
	cmp     rdata + 1
	bne     rread_start
	lda     ptr
	cmp     rdata
	beq	check_ecc
rread_start:
        jsr     rin
	bcs     error
	sta     (ptr), y
	eor     ecc
	sta     ecc
	INC2    ptr
	bne     rread_loop
	beq	rread_loop
check_ecc:
	jsr     rin
	bcs     error
	eor     ecc
	bne     error
	beq     rdata_init
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;等待com口数据,有数据则返回0，错误返回-1
ComWaitReady:
	switch_bank	0
	lda	$3b;LSReg
	and	#$9e;#10011110b
	bne	error
	lda	$3b;LSReg
	and	#$60;#01100000b
	cmp	#$60;#01100000b
	bne	ComWaitReady
	beq     rdata_init
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;发送数据包
ComPutData:
	lda     #$100 - hd_delay_max
	sta     ecc
pdataloop1:
	lda	#0
	sta	watchdog
	jsr	rin
	bcc	pdatanext1
	lda     #hand_signal3
	jsr     rout
	inc     ecc
	bne     pdataloop1
	jmp	error
pdatanext1:
	cmp     #hand_signal1
	bne     pdataloop1
	lda     #hand_signal2
	jsr     rout
	lda     rdata
	jsr     rout
	lda     rdata + 1
	jsr     rout
	jmp     ComWrite
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;接收数据包
ComGetData:
	lda	#$100 - hd_delay_max
	sta	ecc
gdataloop1:
	lda	#hand_signal1
	jsr	rout
gdataloop2:
	jsr	hd_debug_init
gdataloop3:
	lda	#0
	sta	watchdog
	lda	$3b;MCReg
	and	#1
	bne	gdatanext1
	jsr	hd_debug
	bne	gdataloop3
	inc     ecc
	bne     gdataloop2
	jmp	error
gdatanext1:
	lda     $3a
	cmp     #hand_signal2
	bne     gdataloop1
	ldy     #0
	jsr     rin
	sta     (rdata),y
	pha
	iny
	jsr     rin
	sta     (rdata),y
	sta     rdata + 1
	pla
	sta     rdata
	jmp     ComRead
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;.dw ComOpen, ComClose, ComPutc, ComWrite, ComGetc, ComRead, ComWaitReady, ComPutData, ComGetData