ReadTrainer:

; don't change any moves in a link battle
	ld a, [wLinkState]
	and a
	ret nz

; set [wEnemyPartyCount] to 0, [wEnemyPartyMons] to FF
; XXX first is total enemy pokemon?
; XXX second is species of first pokemon?
	ld hl, wEnemyPartyCount
	xor a
	ld [hli], a
	dec a
	ld [hl], a

; get the pointer to trainer data for this class
	ld a, [wCurOpponent]
	sub $C9 ; convert value from pokemon to trainer
	add a
	ld hl, TrainerDataPointers
	ld c, a
	ld b, 0
	add hl, bc ; hl points to trainer class
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wTrainerNo]
	ld b, a
; At this point b contains the trainer number,
; and hl points to the trainer class.
; Our next task is to iterate through the trainers,
; decrementing b each time, until we get to the right one.
.outer
	dec b
	jr z, .IterateTrainer
.inner
	ld a, [hli]
	cp -1 ; have we reached the end of the trainer data?
	jr nz, .inner
	jr .outer

; if the first byte of trainer data is FF, each pokemon has a specific level
; (as opposed to the whole team being of the same level)
; else the first byte is the level of every pokemon on the team
.IterateTrainer
	call SetCustomName
	ld a, [hli]
	cp LEVELS ; does the trainer have a level for each pokemon?
	jr z, .LevelsTrainer
	cp MOVES ; does the trainer have a level+moveset for each pokemon?
	jr z, .MovesTrainer

; ; if this code is being run,
; the trainer has a single level for all pokemon
	ld [wCurEnemyLVL], a
.LoopTrainerData
	ld a, [hli]
	cp -1 ; have we reached the end of the trainer data?
	jp z, .FinishUp
	ld [wcf91], a ; write species somewhere (XXX why?)
	ld a, ENEMY_PARTY_DATA
	ld [wMonDataLocation], a
	push hl
	call AddPartyMon
	pop hl
	jr .LoopTrainerData

.LevelsTrainer
; if this code is being run, each pokemon has a specific level
; (as opposed to the whole team being of the same level)
	ld a, [hli]
	cp -1 ; have we reached the end of the trainer data?
	jr z, .FinishUp
	ld [wCurEnemyLVL], a
	ld a, [hli]
	ld [wcf91], a
	ld a, ENEMY_PARTY_DATA
	ld [wMonDataLocation], a
	push hl
	call AddPartyMon
	pop hl
	jr .LevelsTrainer

.MovesTrainer
; if this code is being run, each pokemon has a specific level and moveset
; (as opposed to the whole team having their default movesets)
	ld a, [hli]
	cp -1 ; have we reached the end of the trainer data?
	jr z, .FinishUp
	ld [wCurEnemyLVL], a
	ld a, [hli]
	ld [wcf91], a
	ld a, ENEMY_PARTY_DATA
	ld [wMonDataLocation], a
	push hl
	call AddPartyMon
	ld a, [wEnemyPartyCount] ; which mon is this?
	dec a
	ld hl, wEnemyMon1Moves
	ld bc, wEnemyMon2 - wEnemyMon1
	call AddNTimes
	ld d, h
	ld e, l ; de now holds this mon's moves
	pop hl ; get our spot back in the party data
	ld b, NUM_MOVES
.AddMoveLoop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .AddMoveLoop
	jr .MovesTrainer

.FinishUp
; clear wAmountMoneyWon addresses
	xor a
	ld de, wAmountMoneyWon
	ld [de], a
	inc de
	ld [de], a
	inc de
	ld [de], a
	ld a, [wCurEnemyLVL]
	ld b, a
.LastLoop
; update wAmountMoneyWon addresses (money to win) based on enemy's level
	ld hl, wTrainerBaseMoney + 1
	ld c, 2 ; wAmountMoneyWon is a 3-byte number
	push bc
	predef AddBCDPredef
	pop bc
	inc de
	inc de
	dec b
	jr nz, .LastLoop ; repeat wCurEnemyLVL times
	ret

GetTrainerMonDVs:: ; called from engine/battle/core.asm
	ld a, [wTrainerClass]
	dec a
	ld c, a
	ld b, 0
	ld hl, TrainerClassDVs
	add hl, bc
	add hl, bc
	ld de, wTempDVs
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	ret

INCLUDE "data/trainer_dvs.asm"
