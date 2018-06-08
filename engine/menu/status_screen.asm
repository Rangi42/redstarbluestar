DrawHP:
; Draws the HP bar in the stats screen
	call GetPredefRegisters
	ld a, $1
	jr DrawHP_

DrawHP2:
; Draws the HP bar in the party screen
	call GetPredefRegisters
	ld a, $2

DrawHP_:
	ld [wHPBarType], a
	push hl
	ld a, [wLoadedMonHP]
	ld b, a
	ld a, [wLoadedMonHP + 1]
	ld c, a
	or b
	jr nz, .nonzeroHP
	xor a
	ld c, a
	ld e, a
	ld a, $6
	ld d, a
	jp .drawHPBarAndPrintFraction
.nonzeroHP
	ld a, [wLoadedMonMaxHP]
	ld d, a
	ld a, [wLoadedMonMaxHP + 1]
	ld e, a
	predef HPBarLength
	ld a, $6
	ld d, a
	ld c, a
.drawHPBarAndPrintFraction
	pop hl
	push de
	push hl
	push hl
	call DrawHPBar
	pop hl
	ld a, [hFlags_0xFFF6]
	bit 0, a
	jr z, .printFractionBelowBar
	ld bc, $9 ; right of bar
	jr .printFraction
.printFractionBelowBar
	ld bc, SCREEN_WIDTH + 1 ; below bar
.printFraction
	add hl, bc
	ld de, wLoadedMonHP
	lb bc, 2, 3
	call PrintNumber
	ld a, "/"
	ld [hli], a
	ld de, wLoadedMonMaxHP
	lb bc, 2, 3
	call PrintNumber
	pop hl
	pop de
	ret


; Predef 0x37
StatusScreen:
	call LoadMonData
	ld a, [wMonDataLocation]
	cp BOX_DATA
	jr c, .DontRecalculate
; mon is in a box or daycare
	ld a, [wLoadedMonBoxLevel]
	ld [wLoadedMonLevel], a
	ld [wCurEnemyLVL], a
	ld hl, wLoadedMonHPExp - 1
	ld de, wLoadedMonStats
	ld b, $1
	call CalcStats ; Recalculate stats
.DontRecalculate
	ld hl, wd72c
	set 1, [hl]
	ld a, $33
	ld [rNR50], a ; Reduce the volume
	call GBPalWhiteOutWithDelay3
	call ClearScreen
	call UpdateSprites
	call LoadHpBarAndStatusTilePatterns
	ld a, [hTilesetType]
	push af
	xor a
	ld [hTilesetType], a
	coord hl, 8, 0
	ld [hl], "№"
	inc hl
	ld [hl], "."
	coord hl, 8, 4
	ld de, IDNoOTText
	call PlaceString ; "ID№/" "OT/"
	coord hl, 0, 7
	ld a, $71 ; horizontal dash tile
	ld c, SCREEN_WIDTH
.dashes
	ld [hli], a
	dec c
	jr nz, .dashes
	coord hl, 1, 8
	predef DrawHP2
	ld hl, wStatusScreenHPBarColor
	call GetHealthBarColor
	ld de, wLoadedMonDVs
	callba IsMonShiny
	ld hl, wShinyMonFlag
	jr nz, .shiny
	res 0, [hl]
	jr .setPal
.shiny
	set 0, [hl]
.setPal
	ld b, SET_PAL_STATUS_SCREEN
	call RunPaletteCommand
	coord hl, 7, 11
	ld de, wLoadedMonStatus
	call PrintStatusCondition
	jr nz, .StatusWritten
	coord hl, 7, 11
	ld de, OKText
	call PlaceString ; "OK"
.StatusWritten
	coord hl, 0, 11
	ld de, StatusText
	call PlaceString ; "STATUS/"
	coord hl, 14, 0
	call PrintLevel ; Pokémon level
	ld a, [wMonHIndex]
	ld [wd11e], a
	predef IndexToPokedex
	coord hl, 10, 0
	ld de, wd11e
	lb bc, LEADING_ZEROES | 1, 3
	call PrintNumber ; Pokémon no.
	ld hl, NamePointers2
	call .GetStringPointer
	ld d, h
	ld e, l
	coord hl, 8, 2
	call PlaceString ; Pokémon name
	ld hl, OTPointers
	call .GetStringPointer
	ld d, h
	ld e, l
	coord hl, 11, 6
	call PlaceString ; OT
	coord hl, 11, 4
	ld de, wLoadedMonOTID
	lb bc, LEADING_ZEROES | 2, 5
	call PrintNumber ; ID Number
	ld d, $0
	call PrintStatsBox
	call PrintMonGender_StatusScreen
	call PrintMonShiny_StatusScreen
	coord hl, 0, 13
	ld de, StatusScreenExpText
	call PlaceString ; "EXP POINTS" "LEVEL UP"
	ld a, [wLoadedMonLevel]
	push af
	cp MAX_LEVEL
	jr z, .Level100
	inc a
	ld [wLoadedMonLevel], a ; Increase temporarily if not 100
.Level100
	coord hl, 5, 16
	ld [hl], $70 ; 1-tile "to"
	inc hl
	inc hl
	call PrintLevel
	pop af
	ld [wLoadedMonLevel], a
	ld de, wLoadedMonExp
	coord hl, 2, 14
	lb bc, 3, 7
	call PrintNumber ; exp
	call CalcExpToLevelUp
	ld de, wLoadedMonExp
	coord hl, 0, 16
	lb bc, 3, 5
	call PrintNumber ; exp needed to level up
	call Delay3
	call GBPalNormal
	coord hl, 0, 0
	call LoadFlippedFrontSpriteByMonIndex ; draw Pokémon picture
	ld a, [wcf91]
	call PlayCry ; play Pokémon cry
	call WaitForTextScrollButtonPress ; wait for button
	pop af
	ld [hTilesetType], a
	ret

.GetStringPointer
	ld a, [wMonDataLocation]
	add a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wMonDataLocation]
	cp DAYCARE_DATA
	ret z
	ld a, [wWhichPokemon]
	jp SkipFixedLengthTextEntries

OTPointers:
	dw wPartyMonOT
	dw wEnemyMonOT
	dw wBoxMonOT
	dw wDayCareMonOT

NamePointers2:
	dw wPartyMonNicks
	dw wEnemyMonNicks
	dw wBoxMonNicks
	dw wDayCareMonName

TypesText:
	db "TYPE/@"

IDNoOTText:
	db   "<ID>№/"
	next "OT/@"

StatusText:
	db "STATUS/@"

OKText:
	db "OK@"

PrintMonGender_StatusScreen:
	ld a, [wLoadedMonSpecies]
	ld [wGenderTemp], a
	ld de, wLoadedMonDVs
	callba GetMonGender
	ld a, [wGenderTemp]
	and a
	ret z
	dec a
	ld a, "♂"
	jr z, .ok
	ld a, "♀"
.ok
	coord hl, 18, 0
	ld [hl], a
	ret

PrintMonShiny_StatusScreen:
	ld de, wLoadedMonDVs
	callba IsMonShiny
	ret z
	coord hl, 19, 0
	ld [hl], "<SHINY>"
	ret

PrintStatsBox:
	ld a, d
	and a ; a is 0 from the status screen
	jr nz, .DifferentBox
	coord hl, 10, 8
	ld b, 8
	ld c, 8
	call TextBoxBorder ; Draws the box
	coord hl, 11, 9 ; Start printing stats from here
	ld bc, $0019 ; Number offset
	jr .PrintStats
.DifferentBox
	coord hl, 9, 2
	ld b, 8
	ld c, 9
	call TextBoxBorder
	coord hl, 11, 3
	ld bc, $0018
.PrintStats
	push bc
	push hl
	ld de, StatsText
	call PlaceString
	pop hl
	pop bc
	add hl, bc
	ld de, wLoadedMonAttack
	lb bc, 2, 3
	call PrintStat
	ld de, wLoadedMonDefense
	call PrintStat
	ld de, wLoadedMonSpeed
	call PrintStat
	ld de, wLoadedMonSpecial
	jp PrintNumber
PrintStat:
	push hl
	call PrintNumber
	pop hl
	ld de, SCREEN_WIDTH * 2
	add hl, de
	ret

StatsText:
	db   "ATTACK"
	next "DEFENSE"
	next "SPEED"
	next "SPECIAL@"

StatusScreen2:
	ld a, [hTilesetType]
	push af
	xor a
	ld [hTilesetType], a
	ld [H_AUTOBGTRANSFERENABLED], a
	ld bc, NUM_MOVES + 1
	ld hl, wMoves
	call FillMemory
	ld hl, wLoadedMonMoves
	ld de, wMoves
	ld bc, NUM_MOVES
	call CopyData
	callab FormatMovesString
	coord hl, 8, 2
	lb bc, 5, 10
	call ClearScreenArea ; Clear name, ID №, and OT
	coord hl, 8, 4
	ld de, TypesText
	call PlaceString ; "TYPES/"
	coord hl, 0, 8
	ld b, 8
	ld c, 18
	call TextBoxBorder ; Draw move container
	coord hl, 2, 9
	ld de, wMovesString
	call PlaceString ; Print moves
	ld a, [wNumMovesMinusOne]
	inc a
	ld c, a
	ld a, $4
	sub c
	ld b, a ; Number of moves ?
	coord hl, 11, 10
	ld de, SCREEN_WIDTH * 2
	ld a, "<P>"
	call StatusScreen_PrintPP ; Print "PP"
	ld a, b
	and a
	jr z, .InitPP
	ld c, a
	ld a, "-"
	call StatusScreen_PrintPP ; Fill the rest with --
.InitPP
	ld hl, wLoadedMonMoves
	coord de, 14, 10
	ld b, 0
.PrintPP
	ld a, [hli]
	and a
	jr z, .PPDone
	push bc
	push hl
	push de
	ld hl, wCurrentMenuItem
	ld a, [hl]
	push af
	ld a, b
	ld [hl], a
	push hl
	callab GetMaxPP
	pop hl
	pop af
	ld [hl], a
	pop de
	pop hl
	push hl
	ld bc, wPartyMon1PP - wPartyMon1Moves - 1
	add hl, bc
	ld a, [hl]
	and $3f
	ld [wStatusScreenCurrentPP], a
	ld h, d
	ld l, e
	push hl
	ld de, wStatusScreenCurrentPP
	lb bc, 1, 2
	call PrintNumber
	ld a, "/"
	ld [hli], a
	ld de, wMaxPP
	lb bc, 1, 2
	call PrintNumber
	pop hl
	ld de, SCREEN_WIDTH * 2
	add hl, de
	ld d, h
	ld e, l
	pop hl
	pop bc
	inc b
	ld a, b
	cp $4
	jr nz, .PrintPP
.PPDone
	ld a, [wMonHIndex]
	ld [wd0b5], a
	ld [wd11e], a
	call GetMonName
	coord hl, 8, 2
	call PlaceString
	coord hl, 9, 5
	predef PrintMonType
	ld a, $1
	ld [H_AUTOBGTRANSFERENABLED], a
	call Delay3
	call WaitForTextScrollButtonPress ; wait for button
	pop af
	ld [hTilesetType], a
	ld hl, wd72c
	res 1, [hl]
	ld a, $77
	ld [rNR50], a
	call GBPalWhiteOut
	jp ClearScreen

CalcExpToLevelUp:
	ld a, [wLoadedMonLevel]
	cp MAX_LEVEL
	jr z, .atMaxLevel
	inc a
	ld d, a
	callab CalcExperience
	ld hl, wLoadedMonExp + 2
	ld a, [hExperience + 2]
	sub [hl]
	ld [hld], a
	ld a, [hExperience + 1]
	sbc [hl]
	ld [hld], a
	ld a, [hExperience]
	sbc [hl]
	ld [hld], a
	ret
.atMaxLevel
	ld hl, wLoadedMonExp
	xor a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ret

StatusScreenExpText:
	db   "EXP POINTS"
	next "LEVEL UP@"

StatusScreen_ClearName:
	ld bc, 10
	ld a, " "
	jp FillMemory

StatusScreen_PrintPP:
; print PP or -- c times, going down two rows each time
	ld [hli], a
	ld [hld], a
	add hl, de
	dec c
	jr nz, StatusScreen_PrintPP
	ret
