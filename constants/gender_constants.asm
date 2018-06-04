; See data/gender_ratios.asm

; Used to define gender ratios
MALE_ONLY         EQU $00
MALE_88_PERCENT   EQU $1F
MALE_75_PERCENT   EQU $3F
SAME_BOTH_GENDERS EQU $7F
FEMALE_75_PERCENT EQU $BF
FEMALE_ONLY       EQU $FE
NO_GENDER         EQU $FF

; used when returning a Pokemon's gender
GENDERLESS EQU $00
MALE       EQU $01
FEMALE     EQU $02
