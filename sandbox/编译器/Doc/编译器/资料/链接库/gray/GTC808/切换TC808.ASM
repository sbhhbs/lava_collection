 .org $79c0
 lda #$80 ;---------------------------------------------------------------------#$80
 sta $a9a1 ;ClearScreen
 sta $87eb ;_GBUF
 sta $87da ;_GRAPH
 sta $a9c0 ;Refresh
 sta $a9c8 ;Refresh
 lda #$63 ;---------------------------------------------------------------------#$63
 sta $a9a5 ;ClearScreen
 sta $87ef ;_GBUF
 sta $a9c4 ;Refresh
 lda #$13 ;---------------------------------------------------------------------#$13
 sta $a9cc ;Refresh
 sta $87de ;_GRAPH
 lda #$28 ;---------------------------------------------------------------------#$28
 sta $a9e0 ;Refresh
 sta $a9e7 ;Refresh
 sta $a9f2 ;Refresh
 sta $af0a ;Block
 sta $abf9 ;GetBlock
 sta $af0a ;Box
 sta $ae4a ;WriteBlock
 sta $ae57 ;WriteBlock
 lda #$3f ;---------------------------------------------------------------------#$3f
 sta $a9d6 ;Refresh
 lda #$ea ;---------------------------------------------------------------------#$ea
 sta $aeac ;Point
 sta $abcc ;GetBlock
 sta $b0df ;Block
 sta $b0ef ;Block
 sta $b305 ;FillArea
 sta $af81 ;FillArea
 sta $acbb ;WriteBlock
 sta $ace0 ;WriteBlock
 sta $ad24 ;WriteBlock
 sta $ad2d ;WriteBlock
 lda #$03 ;---------------------------------------------------------------------#$03
 sta $aebc ;Point
 sta $b08f ;Block
 sta $b097 ;Block
 sta $b0ee ;Block
 sta $b2fb ;FillArea
 sta $af52 ;FillArea
 sta $af5a ;FillArea
 sta $acba ;WriteBlock
 sta $acdb ;WriteBlock
 sta $ad5a ;WriteBlock
 sta $ad6d ;WriteBlock
 sta $ad79 ;WriteBlock
 sta $adad ;WriteBlock
 ;sta $03e9 ;SetVolume
 lda #$50 ;---------------------------------------------------------------------#$50
 sta $aea6 ;Point
 sta $b0d9 ;Block
 sta $b2f3 ;FillArea
 lda #$fc ;---------------------------------------------------------------------#$fc
 sta $b370 ;FillArea
 lda #$04 ;---------------------------------------------------------------------#$04
 sta $b373 ;FillArea
 lda #$c0 ;---------------------------------------------------------------------#$c0
 sta $b30c ;FillArea
 lda #$7f ;---------------------------------------------------------------------#$7f
 sta $a9b8 ;ClearScreen
 lda #$a5 ;---------------------------------------------------------------------#$a5
 sta $b07a ;Block
 sta $b07f ;Block
 lda #$fe ;---------------------------------------------------------------------#$fe
 sta $b07b ;Block
 lda #$11
 sta $83a8
 sta $8444
 sta $849e
 sta $b790
 sta $b7d8
 sta $b7e8
 ldx $42
loop3:
 lda $16d9,x
 sta $11d9,x
 inx
 bne loop3
 lda #$63
 sta $80
 lda #$80
 ldx #0
loop:
 sta $b57d, x;;;;;;;;;;;;;
 inx
 tay
 lda $80
 sta $b57d, x;;;;;;;;;;;;;
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