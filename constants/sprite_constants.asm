; pokemon's overworld sprites
const_value = 0

	const ICON_NULL        ; $00
	const ICON_POLIWAG     ; $01
	const ICON_JIGGLYPUFF  ; $02
	const ICON_DIGLETT     ; $03
	const ICON_PIKACHU     ; $04
	const ICON_STARYU      ; $05
	const ICON_FISH        ; $06
	const ICON_BIRD        ; $07
	const ICON_MONSTER     ; $08
	const ICON_CLEFAIRY    ; $09
	const ICON_ODDISH      ; $0a
	const ICON_BUG         ; $0b
	const ICON_GHOST       ; $0c
	const ICON_LAPRAS      ; $0d
	const ICON_HUMANSHAPE  ; $0e
	const ICON_FOX         ; $0f
	const ICON_EQUINE      ; $10
	const ICON_SHELL       ; $11
	const ICON_BLOB        ; $12
	const ICON_SERPENT     ; $13
	const ICON_VOLTORB     ; $14
	const ICON_SQUIRTLE    ; $15
	const ICON_BULBASAUR   ; $16
	const ICON_CHARMANDER  ; $17
	const ICON_CATERPILLAR ; $18
	const ICON_GEODUDE     ; $19
	const ICON_FIGHTER     ; $1a
	const ICON_JELLYFISH   ; $1b
	const ICON_MOTH        ; $1c
	const ICON_BAT         ; $1d
	const ICON_SNORLAX     ; $1e

; overworld sprites
const_value = 1

	const SPRITE_RED                       ; $01
	const SPRITE_BLUE                      ; $02
	const SPRITE_OAK                       ; $03
	const SPRITE_BUG_CATCHER               ; $04
	const SPRITE_SLOWBRO                   ; $05
	const SPRITE_LASS                      ; $06
	const SPRITE_BLACK_HAIR_BOY_1          ; $07
	const SPRITE_LITTLE_GIRL               ; $08
	const SPRITE_BIRD                      ; $09
	const SPRITE_FAT_BALD_GUY              ; $0a
	const SPRITE_GAMBLER                   ; $0b
	const SPRITE_BLACK_HAIR_BOY_2          ; $0c
	const SPRITE_GIRL                      ; $0d
	const SPRITE_HIKER                     ; $0e
	const SPRITE_FOULARD_WOMAN             ; $0f
	const SPRITE_GENTLEMAN                 ; $10
	const SPRITE_DAISY                     ; $11
	const SPRITE_BIKER                     ; $12
	const SPRITE_SAILOR                    ; $13
	const SPRITE_COOK                      ; $14
	const SPRITE_BIKE_SHOP_GUY             ; $15
	const SPRITE_MR_FUJI                   ; $16
	const SPRITE_GIOVANNI                  ; $17
	const SPRITE_ROCKET                    ; $18
	const SPRITE_MEDIUM                    ; $19
	const SPRITE_WAITER                    ; $1a
	const SPRITE_ERIKA                     ; $1b
	const SPRITE_MOM_GEISHA                ; $1c
	const SPRITE_BRUNETTE_GIRL             ; $1d
	const SPRITE_LANCE                     ; $1e
	const SPRITE_OAK_SCIENTIST_AIDE        ; $1f
	const SPRITE_OAK_AIDE                  ; $20
	const SPRITE_ROCKER                    ; $21
	const SPRITE_SWIMMER                   ; $22
	const SPRITE_WHITE_PLAYER              ; $23
	const SPRITE_GYM_HELPER                ; $24
	const SPRITE_OLD_PERSON                ; $25
	const SPRITE_MART_GUY                  ; $26
	const SPRITE_FISHER                    ; $27
	const SPRITE_OLD_MEDIUM_WOMAN          ; $28
	const SPRITE_NURSE                     ; $29
	const SPRITE_CABLE_CLUB_WOMAN          ; $2a
	const SPRITE_MR_MASTERBALL             ; $2b
	const SPRITE_LAPRAS_GIVER              ; $2c
	const SPRITE_WARDEN                    ; $2d
	const SPRITE_SS_CAPTAIN                ; $2e
	const SPRITE_FISHER2                   ; $2f
	const SPRITE_BLACKBELT                 ; $30
	const SPRITE_GUARD                     ; $31
	const SPRITE_COP_GUARD                 ; $32
	const SPRITE_MOM                       ; $33
	const SPRITE_BALDING_GUY               ; $34
	const SPRITE_YOUNG_BOY                 ; $35
	const SPRITE_GAMEBOY_KID               ; $36
	const SPRITE_GAMEBOY_KID_COPY          ; $37
	const SPRITE_CLEFAIRY                  ; $38
	const SPRITE_AGATHA                    ; $39
	const SPRITE_BRUNO                     ; $3a
	const SPRITE_LORELEI                   ; $3b
	const SPRITE_SEEL                      ; $3c
	const SPRITE_BILL                      ; $3d
	const SPRITE_BURGLAR                   ; $3e
	const SPRITE_SWIMMER_F                 ; $3f
	const SPRITE_POLIWRATH                 ; $40
	const SPRITE_BULBASAUR                 ; $41
	const SPRITE_ODDISH                    ; $42
	const SPRITE_SANDSHREW                 ; $43
	const SPRITE_JIGGLYPUFF                ; $44
	const SPRITE_CHANSEY                   ; $45
	const SPRITE_PIKACHU                   ; $46
	const SPRITE_OFFICER_JENNY             ; $47
	const SPRITE_RECEPTIONIST              ; $48
	const SPRITE_BALL                      ; $49
	const SPRITE_OMANYTE                   ; $4a
	const SPRITE_BOULDER                   ; $4b
	const SPRITE_PAPER_SHEET               ; $4c
	const SPRITE_BOOK_MAP_DEX              ; $4d
	const SPRITE_CLIPBOARD                 ; $4e
	const SPRITE_SNORLAX                   ; $4f
	const SPRITE_OLD_AMBER                 ; $50
	const SPRITE_LYING_OLD_MAN             ; $51

; different kinds of people events
ITEM    EQU $80
TRAINER EQU $40

OW_POKEMON EQU $80

BOULDER_MOVEMENT_BYTE_2 EQU $10

; sprite facing directions
SPRITE_FACING_DOWN  EQU $00
SPRITE_FACING_UP    EQU $04
SPRITE_FACING_LEFT  EQU $08
SPRITE_FACING_RIGHT EQU $0C
