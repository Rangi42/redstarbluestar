FuchsiaMartScript:
	jp EnableAutoTextBoxDrawing

FuchsiaMartTextPointers:
	dw FuchsiaCashierText
	dw FuchsiaMartText2
	dw FuchsiaMartText3

FuchsiaMartText2:
	TX_FAR _FuchsiaMartText2
	db "@"

FuchsiaMartText3:
	TX_FAR _FuchsiaMartText3
	db "@"

FuchsiaCashierText:
	TX_MART ULTRA_BALL, GREAT_BALL, SUPER_POTION, REVIVE, FULL_HEAL, SUPER_REPEL
