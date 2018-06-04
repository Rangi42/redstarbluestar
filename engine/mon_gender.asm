GetMonGender::
	ld hl, MonGenderRatios
	ld a, [wGenderTemp]
	dec a
	ld c, a
	ld b, 0
	add hl, bc

; Attack DV
	ld a, [de]
	and $f0
	ld b, a
; Speed DV
	inc de
	ld a, [de]
	and $f0
	swap a
	or b
	ld b, a

	ld a, [hl]

	cp NO_GENDER
	jr z, .genderless

	cp FEMALE_ONLY
	jr z, .female

	and a ; MALE_ONLY
	jr z, .male

	cp b
	jr c, .male

.female
	ld a, FEMALE
	jr .done
.male
	ld a, MALE
	jr .done
.genderless
	ld a, GENDERLESS
.done
	ld [wGenderTemp], a
	ret


INCLUDE "data/gender_ratios.asm"
