PewterMartScript:
	call EnableAutoTextBoxDrawing
	ld a, $1
	ld [wAutoTextBoxDrawingControl], a
	ret

PewterMartTextPointers:
	dw PewterCashierText
	dw PewterMartText2
	dw PewterMartText3

PewterMartText2:
	TX_ASM
	ld hl, .Text
	call PrintText
	jp TextScriptEnd
.Text
	TX_FAR _PewterMartText2
	db "@"

PewterMartText3:
	TX_ASM
	ld hl, .Text
	call PrintText
	jp TextScriptEnd
.Text
	TX_FAR _PewterMartText3
	db "@"

PewterCashierText:
	TX_MART POKE_BALL, POTION, REPEL, ESCAPE_ROPE, ANTIDOTE, AWAKENING, PARLYZ_HEAL
