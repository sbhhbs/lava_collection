 .org $79C0
              LDA $50
              PHA
              LDA $51
              PHA
              LDA #$60
              STA $05
              STA $0432
              LDA #$20
              STA $0B
              STA $043B
              LDA #$38 ;原值为#$83，可以修改，只要每次递减5，比如设为#$7e、#$79、#$74等。我怀疑这个值与显存地址有一定关系，因为设为#$38时显存地址正好在$1380……
              STA $06
              LDA #$A0 ;原值为#$50，这个应该就是调整行宽的了。但是我试了之后发现只有在值为#$40，#$50，#$A0时方有效。#$40就是让行宽等于16个字节。
              STA $0D
              LDA $0A
              PHA
	      AND #$F0
              STA $0A
              PHP
              SEI
              JSR $CC14
              LDA #$A6
              STA $50
              JSR $CBC8
              LDA #$A6
              STA $50
              JSR $CB72
              JSR $CBA0
              BCS QCB56
              LDX #$00
QCB25:        LDA $CC90,x
              STA $50
              JSR $CB72
              JSR $CBA0
              BCS QCB56
              LDA DATA,x
              CPX #$02
              BNE QCB3F
              LDY $03E8
              LDA $CCA4,y
QCB3F:        STA $50
              JSR $CB72
              JSR $CBA0
              BCS QCB56
              INX
              CPX #$0A
              BCC QCB25
              JSR $CBEA
              JSR $CB57
QCB56:        PLP
              LDA $3D
              ORA #$03
              STA $3D
              LDA $043D
              STA $3A
              LDA $043C
              STA $3C
              PLA
              STA $0A
              PLA
              STA $51
              PLA
              STA $50
              RTS
DATA:
 .DB $0F,$00,$00,$03,$08,$00,$00,$05,$0A,$0F