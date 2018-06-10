Lab2Script:
	jp EnableAutoTextBoxDrawing

Lab2TextPointers:
	dw Lab2Text1
	dw Lab2Text2
	dw Lab2Text3

Lab2Text1:
	TX_FAR _Lab2Text1
	db "@"

Lab2Text2:
	TX_ASM
	ld hl, Trader6Name
	call SetCustomName
	ld a, $6
	ld [wWhichTrade], a
	jr Lab2DoTrade

Lab2Text3:
	TX_ASM
	ld hl, Trader7Name
	call SetCustomName
	ld a, $7
	ld [wWhichTrade], a
Lab2DoTrade:
	predef DoInGameTradeDialogue
	jp TextScriptEnd

Trader6Name:
	db "CLIFTON@"

Trader7Name:
	db "NORMA@"
