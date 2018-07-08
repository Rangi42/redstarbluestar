db 0 ; pokedex id
db 33 ; base hp
db 136 ; base attack
db 0 ; base defense
db 29 ; base speed
db 6 ; base special
db BIRD ; species type 1
db NORMAL ; species type 2
db 29 ; catch rate
db 143 ; base exp yield
db $88 ; sprite dimensions
dw MissingNoPicFront
dw vChars1 + $737
; attacks known at lvl 0
db WATER_GUN
db WATER_GUN
db SKY_ATTACK
db 0
db $1A ; growth rate
; learnset
	tmlearn 1,2,3,5,6 ; $37
	tmlearn 9,10,11,13,14 ; $37
	tmlearn 17,19,20 ; $0D
	tmlearn 25,26,27,29,30 ; $37
	tmlearn 0 ; $00
	tmlearn 43,44,45 ; $1C
	tmlearn 49,51,52 ; $0D
db BANK(MissingNoPicFront)
