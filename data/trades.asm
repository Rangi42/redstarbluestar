TradeMons:
; givemonster, getmonster, textstring, nickname (11 bytes), 14 bytes total
IF DEF(_RED)
	db RHYDON,    KANGASKHAN,0,"TERRY@@@@@@"
	db ABRA,      MR_MIME,   0,"MARCEL@@@@@"
	db BUTTERFREE,BEEDRILL,  2,"STINGER@@@@"
	db GROWLITHE, HORSEA,    0,"SAILOR@@@@@"
	db SPEAROW,   FARFETCHD, 2,"DUX@@@@@@@@"
	db PRIMEAPE,  LICKITUNG, 0,"MARC@@@@@@@"
	db STARYU,    JYNX,      1,"LOLA@@@@@@@"
	db SLOWBRO,   ELECTRODE, 2,"DORIS@@@@@@"
	db MACHOKE,   HAUNTER,   1,"GEIST@@@@@@"
	db NIDORAN_M, NIDORAN_F, 2,"SPOT@@@@@@@"
ENDC
IF DEF(_BLUE)
	db MAROWAK,   KANGASKHAN,0,"TERRY@@@@@@"
	db CLEFAIRY,  MR_MIME,   0,"MARCEL@@@@@"
	db BEEDRILL,  BUTTERFREE,2,"FLAPPER@@@@"
	db VULPIX,    KRABBY,    0,"SAILOR@@@@@"
	db PIDGEY,    FARFETCHD, 2,"DUX@@@@@@@@"
	db PERSIAN,   TAUROS,    0,"MARC@@@@@@@"
	db SHELLDER,  JYNX,      1,"LOLA@@@@@@@"
	db GOLDUCK,   ELECTRODE, 2,"DORIS@@@@@@"
	db GRAVELER,  HAUNTER,   1,"GEIST@@@@@@"
	db NIDORAN_F, NIDORAN_M, 2,"SPOT@@@@@@@"
ENDC
