 .org $79c0
 lda $50
 pha
 lda $51
 pha
 int $c003
 int $c004
 pla
 sta $51
 pla
 sta $50
 rts