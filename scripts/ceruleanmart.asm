CeruleanMartScript:
	jp EnableAutoTextBoxDrawing

CeruleanMartTextPointers:
	dw CeruleanCashierText
	dw CeruleanMartText2
	dw CeruleanMartText3

CeruleanMartText2:
	TX_FAR _CeruleanMartText2
	db "@"

CeruleanMartText3:
	TX_FAR _CeruleanMartText3
	db "@"

CeruleanCashierText:
	TX_MART POKE_BALL, POTION, REPEL, ANTIDOTE, BURN_HEAL, AWAKENING, PARLYZ_HEAL
