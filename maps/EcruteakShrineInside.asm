const_value set 2
	const ECRUTEAKSHRINEINSIDE_REI
	const ECRUTEAKSHRINEINSIDE_GRAMPS
	const ECRUTEAKSHRINEINSIDE_SAGE
	const ECRUTEAKSHRINEINSIDE_FURRET

EcruteakShrineInside_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

EcruteakShrineInsideReiScript:
	faceplayer
	opentext
	checkflag ENGINE_DAILY_SHRINE_VISIT
	iftrue .ReiDone
	writetext EcruteakShrineInsideReiGreetingText
	loadmenudata .ReiMenuDataHeader
	verticalmenu
	closewindow
	if_equal $1, .ReiBless
	if_equal $2, .ReiBattle
	jump .ReiCancel

.ReiBless
	writetext EcruteakShrineInsideReiBlessText
	buttonsound
	special Special_ReiBlessing
	if_equal $0, .ReiCancel
	if_equal $1, .EggBlessing
	setflag ENGINE_DAILY_SHRINE_VISIT
	writetext EcruteakShrineInsideReiBlessingText
	special PlayCurMonCry
	waitbutton
	jump .ReiDone

.ReiBattle
	writetext EcruteakShrineInsideReiBattleText
	waitbutton
	closetext
	setflag ENGINE_DAILY_SHRINE_VISIT
	winlosstext EcruteakShrineInsideReiBeatenText, 0
	setlasttalked ECRUTEAKSHRINEINSIDE_REI
	loadtrainer REI, 1
	startbattle
	reloadmapafterbattle
	opentext

.ReiDone
	writetext EcruteakShrineInsideReiComeAgainText
	waitbutton
	closetext
	end

.ReiCancel
	writetext EcruteakShrineInsideReiCancelText
	waitbutton
	closetext
	end

.EggBlessing
	writetext EcruteakShrineInsideReiBlessEggText
	waitbutton
	closetext
	end

.ReiMenuDataHeader:
	db $40 ; flags
	db 04, 00 ; start coords
	db 11, 11 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 3 ; items
	db "Blessing@"
	db "Battle@"
	db "Cancel@"

EcruteakShrineInsideGrampsScript:
	jumptextfaceplayer EcruteakShrineInsideGrampsText

EcruteakShrineInsideSageScript:
	jumptextfaceplayer EcruteakShrineInsideSageText

EcruteakShrineInsideReiGreetingText:
	text "Rei: Oh, hello."
	line "Welcome to our"
	cont "shrine."

	para "Did you come to"
	line "have me bless one"
	cont "of your #mon?"

	para "Or would you like"
	line "to battle?"
	done

EcruteakShrineInsideReiBlessText:
	text "Rei: Okay, which"
	line "#mon should I"
	cont "bless?"
	done

EcruteakShrineInsideReiBlessingText:
	text "Rei: May you be"
	line "at ease, and find"
	cont "peace."
	done

EcruteakShrineInsideReiBlessEggText:
	text "Rei: I'm can't"
	line "bless an Egg."
	done

EcruteakShrineInsideReiBattleText:
	text "Rei: Very well."
	line "Evil spirits,"
	cont "begone!"
	done

EcruteakShrineInsideReiBeatenText:
	text "I admit defeat!"
	done

EcruteakShrineInsideReiComeAgainText:
	text "Rei: Please come"
	line "again tomorrow."
	done

EcruteakShrineInsideReiCancelText:
	text "Rei: Please come"
	line "back if you change"
	cont "your mind."
	done

EcruteakShrineInsideGrampsText:
	text "The shrine maiden"
	line "here is my grand-"
	cont "daughter."
	done

EcruteakShrineInsideSageText:
	text "Most of us here at"
	line "the shrine train"

	para "Hoothoot and"
	line "Sentret to battle"
	cont "ghosts."

	para "Rei is unique."
	line "She uses Fire and"
	cont "Psychic types."
	done

EcruteakShrineInside_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $b, $5, 1, ECRUTEAK_SHRINE_OUTSIDE
	warp_def $b, $6, 1, ECRUTEAK_SHRINE_OUTSIDE

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 4
	person_event SPRITE_SABRINA, 6, 7, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, EcruteakShrineInsideReiScript, -1
	person_event SPRITE_GRAMPS, 8, 3, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, EcruteakShrineInsideGrampsScript, -1
	person_event SPRITE_SAGE, 5, 10, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, EcruteakShrineInsideSageScript, -1
	person_event SPRITE_FURRET, 2, 10, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
