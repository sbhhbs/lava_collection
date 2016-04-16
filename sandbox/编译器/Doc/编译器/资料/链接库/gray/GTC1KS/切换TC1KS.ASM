 .org $79c0
 lda #$80 ;---------------------------------------------------------------------#$80
 sta $a894 ;ClearScreen
 sta $878a ;_GBUF
 sta $8779 ;_GRAPH
 sta $a8b3 ;Refresh
 sta $a8bb ;Refresh
 lda #$63 ;---------------------------------------------------------------------#$63
 sta $a898 ;ClearScreen
 sta $878e ;_GBUF
 sta $a8b7 ;Refresh
 lda #$13 ;---------------------------------------------------------------------#$13
 sta $a8bf ;Refresh
 sta $877d ;_GRAPH
 lda #$28 ;---------------------------------------------------------------------#$28
 sta $a8d3 ;Refresh
 sta $a8da ;Refresh
 sta $a8e5 ;Refresh
 sta $adfa ;Block
 sta $aae9 ;GetBlock
 sta $adfa ;Box
 sta $ad3a ;WriteBlock
 sta $ad47 ;WriteBlock
 lda #$3f ;---------------------------------------------------------------------#$3f
 sta $a8c9 ;Refresh
 lda #$ea ;---------------------------------------------------------------------#$ea
 sta $ad9c ;Point
 sta $aabc ;GetBlock
 sta $afcf ;Block
 sta $afdf ;Block
 sta $b1f5 ;FillArea
 sta $ae71 ;FillArea
 sta $abab ;WriteBlock
 sta $abd0 ;WriteBlock
 sta $ac14 ;WriteBlock
 sta $ac1d ;WriteBlock
 lda #$03 ;---------------------------------------------------------------------#$03
 sta $adac ;Point
 sta $af7f ;Block
 sta $af87 ;Block
 sta $afde ;Block
 sta $b1eb ;FillArea
 sta $ae42 ;FillArea
 sta $ae4a ;FillArea
 sta $abaa ;WriteBlock
 sta $abcb ;WriteBlock
 sta $ac4a ;WriteBlock
 sta $ac5d ;WriteBlock
 sta $ac69 ;WriteBlock
 sta $ac9d ;WriteBlock
 ;sta $03e9 ;SetVolume
 lda #$50 ;---------------------------------------------------------------------#$50
 sta $ad96 ;Point
 sta $afc9 ;Block
 sta $b1e3 ;FillArea
 lda #$fc ;---------------------------------------------------------------------#$fc
 sta $b260 ;FillArea
 lda #$04 ;---------------------------------------------------------------------#$04
 sta $b263 ;FillArea
 lda #$c0 ;---------------------------------------------------------------------#$c0
 sta $b1fc ;FillArea
 lda #$7f ;---------------------------------------------------------------------#$7f
 sta $a8ab ;ClearScreen
 lda #$a5 ;---------------------------------------------------------------------#$a5
 sta $af6a ;Block
 sta $af6f ;Block
 lda #$fe ;---------------------------------------------------------------------#$fe
 sta $af6b ;Block
 lda #$12
 sta $8347
 sta $83e3
 sta $843d
 sta $ba96
 sta $bade
 sta $baee
 ldx $42
loop3:
 lda $1800,x
 sta $1200,x
 inx
 bne loop3
 lda #$63
 sta $80
 lda #$80
 ldx #0
loop:
 sta $b46d, x;;;;;;;;;;;;;
 inx
 tay
 lda $80
 sta $b46d, x;;;;;;;;;;;;;
 inx
 clc
 tya
 adc #$28
 bcc next
 inc $80
next:
 cpx #160
 bcc loop
 ldx #0
loop1:
 txa
 ldy #4
loop2:
 asl
 php
 asl
 ror $80
 plp
 ror $80
 dey
 bne loop2
 lda $80
 sta $7600, x;;;;;;;;;;;
 inx
 bne loop1
 rts