 .org $0
 LDA #$00;;;;;;;;;;;;;;;;;;;;;
 STA $90
 STA $92
 LDA #$20;;;;;;;;;;;;;;;;;;;;;
 STA $91
 STA $93
 LDA #$50
 STA $94
WB_LOOP1:
 LDX #$50
 LDY #$00
WB_LOOP2:
 LDA ($90),Y
 ASL
 ROL $95
 ASL
 ROL $95
 ASL
 ASL
 ASL
 ROL $95
 ASL
 ROL $95
 INY
 LDA ($90),Y
 ASL
 ROL $95
 ASL
 ROL $95
 ASL
 ASL
 ASL
 ROL $95
 ASL
 ROL $95
 INY
 TYA
 PHA
 LSR
 TAY
 LDA $95
 STA ($92),Y
 PLA
 TAY
 DEX
 BNE WB_LOOP2
 CLC
 LDA $90
 ADC #$50
 STA $90
 BCC WB_ADC1
 INC $91
WB_ADC1:
 CLC
 LDA $92
 ADC #$28
 STA $92
 BCC WB_ADC2
 INC $93
WB_ADC2:
 DEC $94
 BNE WB_LOOP1
 RTS