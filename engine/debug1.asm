SetCheatTeam:
	ld de, CheatTeam
.loop
	ld a, [de]
	cp $ff
	ret z
	ld [wcf91], a
	inc de
	ld a, [de]
	ld [wCurEnemyLVL], a
	inc de
	call AddPartyMon
	jr .loop

CheatTeam:
	db EXEGGUTOR,90
	db MEW,70
	db RHYDON,60
	db VAPOREON,60
	db CHARIZARD,60
	db $FF

DebugMenu:
	call ClearScreen

	call LoadFontTilePatterns
	call LoadHpBarAndStatusTilePatterns
	call ClearSprites
	call RunDefaultPaletteCommand

	coord hl, 5, 6
	ld b, 3
	ld c, 9
	call TextBoxBorder

	coord hl, 7, 7
	ld de, DebugMenuOptions
	call PlaceString

	ld a, 1 ; fast speed
	ld [wOptions], a

	ld a, A_BUTTON | B_BUTTON | START
	ld [wMenuWatchedKeys], a
	xor a
	ld [wMenuJoypadPollCount], a
	inc a
	ld [wMaxMenuItem], a
	ld a, 7
	ld [wTopMenuItemY], a
	dec a
	ld [wTopMenuItemX], a
	xor a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	ld [wMenuWatchMovingOutOfBounds], a

	call HandleMenuInput
	bit BIT_B_BUTTON, a
	jp nz, DisplayTitleScreen

	ld a, [wCurrentMenuItem]
	and a ; NOCLIP?
	jp z, StartNewGameDebug
	; DEBUG
	jp StartCheatGame

DebugMenuOptions:
	db   "NOCLIP"
	next "DEBUG@"

SetupCheatMode:
	ld a, $f0
	ld [wMonDataLocation], a

	; Fly anywhere.
	ld a, $ff
	ld [wTownVisitedFlag], a
	ld [wTownVisitedFlag + 1], a

	; Get all badges except Earth Badge.
	ld a, %01111111
	ld [wObtainedBadges], a

	; Get ¥999999.
	ld a, $99
	ld hl, wPlayerMoney
	ld [hli], a
	ld [hli], a
	ld [hl], a

	call SetCheatTeam

	; Exeggutor gets four HM moves.
	ld hl, wPartyMon1Moves
	ld a, FLY
	ld [hli], a
	ld a, CUT
	ld [hli], a
	ld a, SURF
	ld [hli], a
	ld a, STRENGTH
	ld [hl], a
	ld hl, wPartyMon1PP
	ld a, 15
	ld [hli], a
	ld a, 30
	ld [hli], a
	ld a, 15
	ld [hli], a
	;ld a, 15
	ld [hl], a

	; Mew gets a special attacker set.
	ld hl, wPartyMon2Moves
	ld a, PSYCHIC_M
	ld [hli], a
	ld a, THUNDERBOLT
	ld [hli], a
	ld a, ICE_BEAM
	ld [hli], a
	ld a, SOFTBOILED
	ld [hl], a
	ld hl, wPartyMon2PP
	ld a, 10
	ld [hli], a
	ld a, 15
	ld [hli], a
	ld a, 10
	ld [hli], a
	;ld a, 10
	ld [hl], a

	; Rhydon gets Surf and a physical attacker set.
	ld hl, wPartyMon3Moves
	ld a, EARTHQUAKE
	ld [hli], a
	ld a, ROCK_SLIDE
	ld [hli], a
	ld a, BODY_SLAM
	ld [hli], a
	ld a, SURF
	ld [hl], a
	ld hl, wPartyMon3PP
	ld a, 10
	ld [hli], a
	;ld a, 10
	ld [hli], a
	ld a, 15
	ld [hli], a
	;ld a, 15
	ld [hl], a

	; Vaporeon gets Surf and some better moves.
	ld hl, wPartyMon4Moves
	ld a, SURF
	ld [hli], a
	ld a, BLIZZARD
	ld [hli], a
	ld a, ACID_ARMOR
	ld [hli], a
	ld a, TOXIC
	ld [hl], a
	ld hl, wPartyMon4PP
	ld a, 15
	ld [hli], a
	ld a, 5
	ld [hli], a
	ld a, 40
	ld [hli], a
	ld a, 10
	ld [hl], a

	; Charizard gets Fly and some better moves.
	ld hl, wPartyMon5Moves
	ld a, FLY
	ld [hli], a
	ld a, FLAMETHROWER
	ld [hli], a
	ld a, SLASH
	ld [hli], a
	ld a, EARTHQUAKE
	ld [hl], a
	ld hl, wPartyMon5PP
	ld a, 15
	ld [hli], a
	;ld a, 15
	ld [hli], a
	ld a, 20
	ld [hli], a
	ld a, 10
	ld [hl], a

	; Get some cheat items.
	ld hl, wNumBagItems
	ld de, CheatItemsList
.items_loop
	ld a, [de]
	and a
	jr z, .items_end
	ld [wcf91], a
	inc de
	ld a, [de]
	inc de
	ld [wItemQuantity], a
	call AddItemToInventory
	jr .items_loop
.items_end

	; Complete the Pokédex.
	ld hl, wPokedexOwned
	call CheatSetPokedexEntries
	ld hl, wPokedexSeen
	call CheatSetPokedexEntries

	; Rival chose Squirtle,
	; Player chose Charmander.
	ld hl, wRivalStarter
	ld a, STARTER2
	ld [hli], a
	inc hl ; hl = wPlayerStarter
	ld a, STARTER1
	ld [hl], a

	ld de, CheatSetEvents
.set_events_loop
	ld a, [de]
	and a
	jr z, .set_events_done
	ld b, a
	inc de
	ld a, [de]
	ld l, a
	inc de
	ld a, [de]
	ld h, a
	ld a, [hl]
	or b
	ld [hl], a
	inc de
	jr .set_events_loop
.set_events_done

	ld hl, CheatHideShowObjects
	ld de, wMissableObjectFlags
	ld bc, CheatHideShowObjects.End - CheatHideShowObjects
	call CopyData

	ld a, $5
	ld [wPalletTownCurScript], a
	ld a, $11
	ld [wOaksLabCurScript], a
	ld a, $2
	ld [wViridianMarketCurScript], a
	ret

CheatSetPokedexEntries:
	ld b, wPokedexOwnedEnd - wPokedexOwned - 1
	ld a, %11111111
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ld [hl], %01111111
	ret

CheatItemsList:
	db BICYCLE, 1
	db FULL_RESTORE, 99
	db FULL_HEAL, 99
	db MAX_ELIXER, 99
	db ESCAPE_ROPE, 99
	db RARE_CANDY, 99
	db MASTER_BALL, 99
	db S_S_TICKET, 1
	db SECRET_KEY, 1
	db CARD_KEY, 1
	db LIFT_KEY, 1
	db 0 ; end

CheatSetEvents:
cheat_event: MACRO
	db 1 << ((\1) % 8)
	dw wEventFlags + ((\1) / 8)
ENDM
	cheat_event EVENT_FOLLOWED_OAK_INTO_LAB
	cheat_event EVENT_FOLLOWED_OAK_INTO_LAB_2
	cheat_event EVENT_OAK_ASKED_TO_CHOOSE_MON
	cheat_event EVENT_GOT_STARTER
	cheat_event EVENT_BATTLED_RIVAL_IN_OAKS_LAB
	cheat_event EVENT_GOT_POKEDEX
	cheat_event EVENT_OAK_APPEARED_IN_PALLET
	cheat_event EVENT_OAK_GOT_PARCEL
	cheat_event EVENT_GOT_OAKS_PARCEL
	db 0 ; end

CheatHideShowObjects:
; hide HS_OAKS_LAB_OAK_2
; show HS_OAKS_LAB_OAK_1
; hide HS_OAKS_LAB_RIVAL
; hide HS_STARTER_BALL_1
; hide HS_STARTER_BALL_2
; hide HS_POKEDEX_1
; hide HS_POKEDEX_2
; hide HS_LYING_OLD_MAN
; show HS_OLD_MAN
	db $a3, $00, $7e, $01, $08, $9d, $03
.End
