CeladonMart5Script:
	jp EnableAutoTextBoxDrawing

CeladonMart5TextPointers:
	dw CeladonMart5Text1
	dw CeladonMart5Text2
	dw CeladonMart5Clerk1Text
	dw CeladonMart5Clerk2Text
	dw CeladonMart5Text5

CeladonMart5Text1:
	TX_FAR _CeladonMart5Text1
	db "@"

CeladonMart5Text2:
	TX_FAR _CeladonMart5Text2
	db "@"

CeladonMart5Text5:
	TX_FAR _CeladonMart5Text5
	db "@"

CeladonMart5Clerk1Text:
	TX_MART X_ACCURACY, GUARD_SPEC, DIRE_HIT, X_ATTACK, X_DEFEND, X_SPEED, X_SPECIAL

CeladonMart5Clerk2Text:
	TX_MART HP_UP, PROTEIN, IRON, CARBOS, CALCIUM
