 .org $79c0
 lda #$80 ;---------------------------------------------------------------------#$80
 sta $a6db ;ClearScreen
 sta $85c1 ;_GBUF
 sta $85b0 ;_GRAPH
 sta $a6fa ;Refresh
 sta $a702 ;Refresh
 lda #$63 ;---------------------------------------------------------------------#$63
 sta $a6df ;ClearScreen
 sta $85c5 ;_GBUF
 sta $a6fe ;Refresh
 lda #$13 ;---------------------------------------------------------------------#$13
 sta $a706 ;Refresh
 sta $85b4 ;_GRAPH
 lda #$28 ;---------------------------------------------------------------------#$28
 sta $a71a ;Refresh
 sta $a721 ;Refresh
 sta $a72c ;Refresh
 sta $ac41 ;Block
 sta $a930 ;GetBlock
 sta $ac41 ;Box
 sta $ab81 ;WriteBlock
 sta $ab8e ;WriteBlock
 lda #$3f ;---------------------------------------------------------------------#$3f
 sta $a710 ;Refresh
 lda #$ea ;---------------------------------------------------------------------#$ea
 sta $abe3 ;Point
 sta $a903 ;GetBlock
 sta $ae26 ;Block
 sta $ae16 ;Block
 sta $b03c ;FillArea
 sta $acb8 ;FillArea
 sta $a9f2 ;WriteBlock
 sta $aa17 ;WriteBlock
 sta $aa5b ;WriteBlock
 sta $aa64 ;WriteBlock
 lda #$03 ;---------------------------------------------------------------------#$03
 sta $abf3 ;Point
 sta $adc6 ;Block
 sta $adce ;Block
 sta $ae25 ;Block
 sta $b032 ;FillArea
 sta $ac89 ;FillArea
 sta $ac91 ;FillArea
 sta $a9f1 ;WriteBlock
 sta $aa12 ;WriteBlock
 sta $aa91 ;WriteBlock
 sta $aaa4 ;WriteBlock
 sta $aab0 ;WriteBlock
 sta $aae4 ;WriteBlock
 lda #$50 ;---------------------------------------------------------------------#$50
 sta $abdd ;Point
 sta $ae10 ;Block
 sta $b02a ;FillArea
 lda #$fc ;---------------------------------------------------------------------#$fc
 sta $b0a7 ;FillArea
 lda #$04 ;---------------------------------------------------------------------#$04
 sta $b0aa ;FillArea
 lda #$c0 ;---------------------------------------------------------------------#$c0
 sta $b043 ;FillArea
 lda #$7f ;---------------------------------------------------------------------#$7f
 sta $a6f2 ;ClearScreen
 lda #$a5 ;---------------------------------------------------------------------#$a5
 sta $adb1 ;Block
 sta $adb6 ;Block
 lda #$fe ;---------------------------------------------------------------------#$fe
 sta $adb2 ;Block
 lda #$63;;;;;;;;
 sta $80
 lda #$80;;;;;;;;
 ldx #0
loop:
 sta $b2b4, x;;;;;;;;;;;;;
 inx
 tay
 lda $80
 sta $b2b4, x;;;;;;;;;;;;;
 inx
 clc
 tya
 adc #$28;;;;;;;;
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