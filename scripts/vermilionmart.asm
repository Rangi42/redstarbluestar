VermilionMartScript:
	jp EnableAutoTextBoxDrawing

VermilionMartTextPointers:
	dw VermilionCashierText
	dw VermilionMartText2
	dw VermilionMartText3

VermilionMartText2:
	TX_FAR _VermilionMartText2
	db "@"

VermilionMartText3:
	TX_FAR _VermilionMartText3
	db "@"

VermilionCashierText:
	TX_MART POKE_BALL, SUPER_POTION, ICE_HEAL, AWAKENING, PARLYZ_HEAL, REPEL
