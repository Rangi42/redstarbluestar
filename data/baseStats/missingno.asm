db 0 ; pokedex id
db 33 ; base hp
db 136 ; base attack
db 0 ; base defense
db 29 ; base speed
db 6 ; base special
db BIRD ; species type 1
db NORMAL ; species type 2
db 255 ; catch rate
db 143 ; base exp yield
db $88 ; sprite dimensions
dw MissingNoPicFront
dw $8F37
; attacks known at lvl 0
db WATER_GUN
db WATER_GUN
db SKY_ATTACK
db 0
db $1A ; growth rate
; learnset
db $37,$37,$0D,$37,$00,$1C,$0D
db BANK(MissingNoPicFront)
