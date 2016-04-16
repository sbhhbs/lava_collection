 .org $79c0
 lda #$c0 ;---------------------------------------------------------------------#$c0
 sta $a8a5 ;ClearScreen
 sta $8795 ;_GBUF
 sta $8784 ;_GRAPH
 sta $a8c4 ;Refresh
 sta $a8cc ;Refresh
 lda #$79 ;---------------------------------------------------------------------#$79
 sta $a8a9 ;ClearScreen
 sta $8799 ;_GBUF
 sta $a8c8 ;Refresh
 lda #$19 ;---------------------------------------------------------------------#$19
 sta $a8d0 ;Refresh
 sta $8788 ;_GRAPH
 lda #$14 ;---------------------------------------------------------------------#$14
 sta $a8e4 ;Refresh
 sta $a8eb ;Refresh
 sta $a8f6 ;Refresh
 sta $ae0b ;Block
 sta $aafa ;GetBlock
 sta $ae0b ;Box
 sta $ad4b ;WriteBlock
 sta $ad58 ;WriteBlock
 lda #$7f ;---------------------------------------------------------------------#$7f
 sta $a8da ;Refresh
 lda #$4a ;---------------------------------------------------------------------#$4a
 sta $adad ;Point
 sta $aacd ;GetBlock
 sta $afe0 ;Block
 sta $aff0 ;Block
 sta $b206 ;FillArea
 sta $ae82 ;FillArea
 sta $abbc ;WriteBlock
 sta $abe1 ;WriteBlock
 sta $ac25 ;WriteBlock
 sta $ac2e ;WriteBlock
 lda #$07 ;---------------------------------------------------------------------#$07
 sta $adbd ;Point
 sta $af90 ;Block
 sta $af98 ;Block
 sta $afef ;Block
 sta $b1fc ;FillArea
 sta $ae53 ;FillArea
 sta $ae5b ;FillArea
 sta $abbb ;WriteBlock
 sta $abdc ;WriteBlock
 sta $ac5b ;WriteBlock
 sta $ac6e ;WriteBlock
 sta $ac7a ;WriteBlock
 sta $acae ;WriteBlock
 lda #$60 ;---------------------------------------------------------------------#$60
 sta $ada7 ;Point
 sta $afda ;Block
 sta $b1f4 ;FillArea
 lda #$f8 ;---------------------------------------------------------------------#$f8
 sta $b271 ;FillArea
 lda #$08 ;---------------------------------------------------------------------#$08
 sta $b274 ;FillArea
 lda #$80 ;---------------------------------------------------------------------#$80
 sta $b20d ;FillArea
 lda #$3f ;---------------------------------------------------------------------#$3f
 sta $a8bc ;ClearScreen
 lda #$a9 ;---------------------------------------------------------------------#$a9
 sta $af7b ;Block
 sta $af80 ;Block
 lda #$00 ;---------------------------------------------------------------------#$00
 sta $af7c ;Block
 lda #$18
 sta $8352
 sta $83ee
 sta $8448
 sta $baa7
 sta $baef
 sta $baff
 ldx $42
loop3:
 lda $1200,x
 sta $1800,x
 inx
 bne loop3
 lda #$79
 sta $80
 lda #$c0
 ldx #0
loop:
 sta $b47e, x;;;;;;;;;;;;;
 inx
 tay
 lda $80
 sta $b47e, x;;;;;;;;;;;;;
 inx
 clc
 tya
 adc #$14
 bcc next
 inc $80
next:
 cpx #160
 bcc loop
 ldx #0
loop1:
 txa
 ldy #8
loop2:
 asl
 ror $80
 dey
 bne loop2
 lda $80
 sta $7600, x;;;;;;;;;;;
 inx
 bne loop1
 rts