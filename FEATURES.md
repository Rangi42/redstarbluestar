# Features

- Graphics from the Space World 1997 Pokémon G/S prototypes:
   - Pokémon [front](pic/swmon/) and [back](pic/swmonback/) sprites
   - [Trainers](pic/swtrainer/)
   - [Map tiles](gfx/tilesets/)
   - [Overworld sprites](gfx/sprites/)
   - SGB borders (Red uses [Gold](gfx/red/sgbborder.png), Blue uses [Silver](gfx/blue/sgbborder.png))
   - Various UIs (battle HUD, Pokémon stats, Pokédex, trainer card, Town Map, etc)
- Features from the Space World prototypes:
   - Shiny Pokémon exist, using their Space World palettes, with the same DVs and encounter chances as G/S (1 in 8,192)
   - Pokémon have genders
   - Battle HUD shows experience bar, gender icons, and caught icon
   - [Swimmer♀](pic/swtrainer/swimmerf.png) and [Soldier](pic/swtrainer/soldier.png) trainer classes
   - Trainers have [individual names](data/trainer_parties.asm) (copied from FR/LG)
   - Trainer classes each have [their own DVs](data/trainer_dvs.asm), instead of all 9/8/8/8
   - Face enemy trainers that see you
   - Running Shoes (2x speed) or Mach Bike (4x bicycle speed) by holding B
   - Talk to Surf water, Cut trees, and Strength boulders to use HMs
   - Items in the Pack have [descriptions](text/item_descriptions.asm)
   - Blinking arrow prompts show on the textbox border
- Features from Yellow:
   - NPCs in Cerulean City, Route 24, and Vermilion City give you Bulbasaur, Charmander, and Squirtle
   - Various [moveset changes](https://github.com/Rangi42/redstarbluestar/commit/3574b8c57826055ec4d6de533a57c1e657ad554f), like Kadabra learning Kinesis
   - The Safari Zone lets you in if you don't have enough money
   - Route 23, Victory Road, and Indigo Plateau disable the Bicycle music
   - Blaine uses a different overworld sprite
- All 151 Pokémon are available:
   - Ekans and Sandshrew: Routes 4, 8, 9, 10, 11, and 23
   - Oddish and Bellsprout: Routes 5, 6, 7, 12, 13, 14, 15, 24, and 25
   - Mankey and Meowth: Routes 5, 6, 7, and 8
   - Growlithe and Vulpix: Routes 7 and 8, and Pokémon Mansion
   - Scyther and Pinsir: Safari Zone
   - Electabuzz: Power Plant
   - Magmar: Pokémon Mansion
   - Machamp, Golem, Alakazam, and Gengar: Cerulean Cave, and evolvable with Heart Stone (sold in Celadon Dept. Store) (trade evolution also still works)
   - Mr. Mime: Game Corner prize (like G/S)
   - Farfetch'd: Route 12 and 13 (like Yellow)
   - Lickitung: Safari Zone (like Yellow)
   - Jynx: Seafoam Islands (like Japanese Blue)
   - Hitmonlee and Hitmonchan: Victory Road
   - Eevee: Celadon Mansion, and a Game Corner prize
   - Kabuto and Omanyte: the fossil not taken in Mt. Moon will be in Cerulean Cave
   - Bulbasaur, Charmander, and Squirtle: NPC gifts (like Yellow)
   - Mew: Use the [Mew glitch](https://bulbapedia.bulbagarden.net/wiki/Mew_glitch) ;)
- Fixed some [bugs in Red and Blue](https://forums.glitchcity.info/index.php?topic=7682.0):
   - [Some DV combinations are unavailable in the wild](https://www.youtube.com/watch?v=BcIxMyf8yHY), including all shiny ones
   - Focus Energy and Dire Hit halve the critical hit rate instead of doubling it
   - Mirror Move versus partial-trapping moves can desync link battles
   - Bide can accumulate damage from a previous turn, a non-active Pokémon, and a previous battle
   - Stat scaling with defending stat lower than 4 freezes the game via division by 0
   - Dual-type effectiveness can show wrong text and sound
   - Level-up moves not learned when a Pokémon grows by two or more levels at once
   - Item evolutions can be triggered by Pokémon with matching IDs battling last
   - Blaine may use a Super Potion with his Pokémon at full health
- Gym Leaders, the Elite 4, and the Champion have [better movesets](data/trainer_parties.asm)
- Default text speed is fast
- Shiny icons in battle, so you won't miss one
- MissingNo has *not* been "fixed"; its Pokédex entry is the Space World placeholder one

There are *no* new Pokémon, maps, moves, or items (except the Heart Stone). This may look like Space World, but its content is purely R/B/Y.


### Higher shiny odds

If you want nearly 2% of wild Pokémon to be shiny like in the Space World demo, then follow the instructions in [INSTALL.md](INSTALL.md) to build your own ROM—but before running `make`, edit [main.asm](main.asm), replacing this:

```
IsMonShiny:
	ld h, d
	ld l, e
	ld a, [hli]
	bit 5, a
	jr z, .notShiny
	and a, $f
	cp 10
	jr nz, .notShiny
	ld a, [hl]
	cp (10 << 4) | 10
	jr nz, .notShiny
	and a
	ret

.notShiny
	xor a
	ret
```

with this:


```
IsMonShiny:
	ld h, d
	ld l, e
	; attack DV >= 10?
	ld a, [hl]
	and $f0
	cp 10 << 4
	jr c, .notShiny
	; defense DV >= 10?
	ld a, [hli]
	and $f
	cp 10
	jr c, .notShiny
	; speed DV >= 10?
	ld a, [hl]
	and $f0
	cp 10 << 4
	jr c, .notShiny
	; special DV >= 10?
	ld a, [hl]
	and $f
	cp 10
	jr c, .notShiny
	and a
	ret

.notShiny
	xor a
	ret
```

Now any Pokémon with all four DVs at 10 or above (out of 15) will be shiny.
