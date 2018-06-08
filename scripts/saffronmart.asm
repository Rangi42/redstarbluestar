SaffronMartScript:
	jp EnableAutoTextBoxDrawing

SaffronMartTextPointers:
	dw SaffronCashierText
	dw SaffronMartText2
	dw SaffronMartText3

SaffronMartText2:
	TX_FAR _SaffronMartText2
	db "@"

SaffronMartText3:
	TX_FAR _SaffronMartText3
	db "@"

SaffronCashierText:
	TX_MART GREAT_BALL, HYPER_POTION, MAX_REPEL, ESCAPE_ROPE, FULL_HEAL, REVIVE
