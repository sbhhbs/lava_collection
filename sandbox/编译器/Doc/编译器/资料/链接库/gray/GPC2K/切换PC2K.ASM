 .org $79c0
 lda #$80 ;---------------------------------------------------------------------#$80
 sta $a6c3 ;ClearScreen
 sta $85c6 ;_GBUF
 sta $85b5 ;_GRAPH
 sta $a6e2 ;Refresh
 sta $a6ea ;Refresh
 lda #$63 ;---------------------------------------------------------------------#$63
 sta $a6c7 ;ClearScreen
 sta $85ca ;_GBUF
 sta $a6e6 ;Refresh
 lda #$13 ;---------------------------------------------------------------------#$13
 sta $a6ee ;Refresh
 sta $85b9 ;_GRAPH
 lda #$28 ;---------------------------------------------------------------------#$28
 sta $a702 ;Refresh
 sta $a709 ;Refresh
 sta $a714 ;Refresh
 sta $ac29 ;Block
 sta $a918 ;GetBlock
 sta $ac29 ;Box
 sta $ab69 ;WriteBlock
 sta $ab76 ;WriteBlock
 lda #$3f ;---------------------------------------------------------------------#$3f
 sta $a6f8 ;Refresh
 lda #$ea ;---------------------------------------------------------------------#$ea
 sta $abcb ;Point
 sta $a8eb ;GetBlock
 sta $adfe ;Block
 sta $ae0e ;Block
 sta $b024 ;FillArea
 sta $aca0 ;FillArea
 sta $a9da ;WriteBlock
 sta $a9ff ;WriteBlock
 sta $aa43 ;WriteBlock
 sta $aa4c ;WriteBlock
 lda #$03 ;---------------------------------------------------------------------#$03
 sta $abdb ;Point
 sta $adae ;Block
 sta $adb6 ;Block
 sta $ae0d ;Block
 sta $b01a ;FillArea
 sta $ac71 ;FillArea
 sta $ac79 ;FillArea
 sta $a9d9 ;WriteBlock
 sta $a9fa ;WriteBlock
 sta $aa79 ;WriteBlock
 sta $aa8c ;WriteBlock
 sta $aa98 ;WriteBlock
 sta $aacc ;WriteBlock
 lda #$50 ;---------------------------------------------------------------------#$50
 sta $abc5 ;Point
 sta $adf8 ;Block
 sta $b012 ;FillArea
 lda #$fc ;---------------------------------------------------------------------#$fc
 sta $b08f ;FillArea
 lda #$04 ;---------------------------------------------------------------------#$04
 sta $b092 ;FillArea
 lda #$c0 ;---------------------------------------------------------------------#$c0
 sta $b02b ;FillArea
 lda #$7f ;---------------------------------------------------------------------#$7f
 sta $a6da ;ClearScreen
 lda #$a5 ;---------------------------------------------------------------------#$a5
 sta $ad99 ;Block
 sta $ad9e ;Block
 lda #$fe ;---------------------------------------------------------------------#$fe
 sta $ad9a ;Block
 lda #$63
 sta $80
 lda #$80
 ldx #0
loop:
 sta $b29c, x;;;;;;;;;;;;;
 inx
 tay
 lda $80
 sta $b29c, x;;;;;;;;;;;;;
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
 sta $7700, x;;;;;;;;;;;
 inx
 bne loop1
 rts