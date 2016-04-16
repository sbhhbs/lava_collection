 .org $79c0
 lda #$c0 ;---------------------------------------------------------------------#$c0
 sta $a6db ;ClearScreen
 sta $85c1 ;_GBUF
 sta $85b0 ;_GRAPH
 sta $a6fa ;Refresh
 sta $a702 ;Refresh
 lda #$79 ;---------------------------------------------------------------------#$79
 sta $a6df ;ClearScreen
 sta $85c5 ;_GBUF
 sta $a6fe ;Refresh
 lda #$19 ;---------------------------------------------------------------------#$19
 sta $a706 ;Refresh
 sta $85b4 ;_GRAPH
 lda #$14 ;---------------------------------------------------------------------#$14
 sta $a71a ;Refresh
 sta $a721 ;Refresh
 sta $a72c ;Refresh
 sta $ac41 ;Block
 sta $a930 ;GetBlock
 sta $ac41 ;Box
 sta $ab81 ;WriteBlock
 sta $ab8e ;WriteBlock
 lda #$7f ;---------------------------------------------------------------------#$7f
 sta $a710 ;Refresh
 lda #$4a ;---------------------------------------------------------------------#$4a
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
 lda #$07 ;---------------------------------------------------------------------#$07
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
 lda #$60 ;---------------------------------------------------------------------#$60
 sta $abdd ;Point
 sta $ae10 ;Block
 sta $b02a ;FillArea
 lda #$f8 ;---------------------------------------------------------------------#$f8
 sta $b0a7 ;FillArea
 lda #$08 ;---------------------------------------------------------------------#$08
 sta $b0aa ;FillArea
 lda #$80 ;---------------------------------------------------------------------#$80
 sta $b043 ;FillArea
 lda #$3f ;---------------------------------------------------------------------#$3f
 sta $a6f2 ;ClearScreen
 lda #$a9 ;---------------------------------------------------------------------#$a9
 sta $adb1 ;Block
 sta $adb6 ;Block
 lda #$00 ;---------------------------------------------------------------------#$00
 sta $adb2 ;Block
 lda #$79
 sta $80
 lda #$c0
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
 sta $7700, x;;;;;;;;;;;
 inx
 bne loop1
 rts