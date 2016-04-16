 .org $79C0
 LDA $50
 PHA
 LDA $51
 PHA
 LDA #$60
 STA $05
 STA $0431
 LDA #$20
 STA $0B
 STA $0434
 LDA #$38;83图形缓存开始地址
 STA $06
 LDA #$A0;50亮度
 STA $0D
 ;int$c005修改..................
 LDA $0434
 ORA #$03
 STA $0B
 STA $0434
 LDA $0431
 ORA #$1B
 STA $05
 STA $0431
 LDA #$00
 STA $19
 STA $0438
 LDA #$26
 STA $3E
 LDA #$03
 STA $3F
 LDA #$A6
 STA $50
 LDA #$20
 STA $3E
 LDA $043A
 ORA #$60
 STA $3F
 LDA $043B
 ORA #$60
 STA $1E
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 AND #$BF
 STA $1E
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 AND #$9F
 STA $1E
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 LDA #$A6
 STA $50
 JSR L_C910
 JSR L_C96E
 BCS L_C90F
 LDX #$00
L_C8D6:
 LDA L_CACD,X
 STA $50
 JSR L_C910
 JSR L_C96E
 BCS L_C90F
 LDA L_CAD7,X
 CPX #$02
 BNE L_C8F0
 LDY $03E9
 LDA L_CAE1,Y
L_C8F0:
 STA $50
 JSR L_C910
 JSR L_C96E
 BCS L_C90F
 INX
 CPX #$0A
 BCC L_C8D6
 JSR L_C9F9
 LDA #$20
 STA $3E
 LDA $043A
 AND #$9F
 STA $3F
 CLC
L_C90F:
 PLA
 STA $51
 PLA
 STA $50
 RTS
L_C910:
 LDA #$20
 STA $3E
 LDA $043A
 ORA #$60
 STA $3F
 LDA #$08
 STA $51
L_C91F:
 ASL $50
 LDA $043B
 BCC L_C92B
 ORA #$40
 .DB $2C
L_C92B:
 AND #$BF
 AND #$DF
 STA $1E
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 ORA #$20
 STA $1E
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 AND #$DF
 STA $1E
 DEC $51
 BNE L_C91F
 RTS
L_C96E:
 LDA #$20
 STA $3E
 LDA $043A
 ORA #$20
 AND #$BF
 STA $3F
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 LDA $043B
 ORA #$20
 STA $1E
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 LDA $1E
 AND #$40
 BEQ L_C9A5
 LDA $043B
 ORA #$40
 STA $1E
 SEC
 RTS
L_C9A5:
 LDA $043B
 AND #$DF
 STA $1E
 CLC
 RTS
L_C9F9:
 LDA #$20
 STA $3E
 LDA $043A
 ORA #$60
 STA $3F
 LDA $043B
 AND #$9F
 STA $1E
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 ORA #$20
 STA $1E
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 ORA #$40
 STA $1E
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 NOP
 RTS
L_CACD:
 .DB $00,$01,$02,$03,$10,$11,$20,$21,$22,$23
L_CAD7:
 .DB $0f,$00,$00,$01,$08,$00,$00,$05,$0a,$0f
L_CAE1:
 .DB $01,$03,$05,$07,$09,$0b,$0d,$0f,$11,$13,$15,$17,$19,$1b,$1d,$1f
