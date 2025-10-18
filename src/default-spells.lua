-- luacheck: no max line length
-- luacheck: globals GetBuildInfo LibStub

local _, addonTable = ...;

addonTable.HUNTER_FEIGN_DEATH = 5384;

addonTable.CDs = {
	[addonTable.UNKNOWN_CLASS] = {
		-- // reviewed 2025/06/14
		[336126] = 120,		-- // Gladiator's Medallion https://www.wowhead.com/spell=336126
		[42292] = 120,		-- // PvP Trinket https://www.wowhead.com/spell=42292
		[283167] = 60,		-- // PvP Trinket 2 https://www.wowhead.com/spell=283167
		[25046] = 120,		-- // Arcane Torrent (Blood Elf: Rogue) https://www.wowhead.com/spell=25046
		[129591] = 120,		-- // Arcane Torrent (Blood Elf: Monk) https://www.wowhead.com/spell=129591
		[232633] = 120,		-- // Arcane Torrent (Blood Elf: Piest) https://www.wowhead.com/spell=232633
		[80483] = 120,		-- // Arcane Torrent (Blood Elf: Hunter) https://www.wowhead.com/spell=80483
		[69179] = 120,		-- // Arcane Torrent (Blood Elf: Warrior) https://www.wowhead.com/spell=69179
		[155145] = 120,		-- // Arcane Torrent (Blood Elf: Paladin) https://www.wowhead.com/spell=155145
		[50613] = 120,		-- // Arcane Torrent (Blood Elf: Death Knight) https://www.wowhead.com/spell=50613
		[202719] = 120,		-- // Arcane Torrent (Blood Elf: Denon Hunter) https://www.wowhead.com/spell=202719
		[28730] = 120,		-- // Arcane Torrent (Blood Elf: Mage, Warlock) https://www.wowhead.com/spell=28730
		[33697] = 120,		-- // Blood Fury (Orc: Shaman, Monk) https://www.wowhead.com/spell=33697
		[33702] = 120,		-- // Blood Fury (Orc: Mage, Priest, Warlock) https://www.wowhead.com/spell=33702
		[20572] = 120,		-- // Blood Fury (Orc: Warior, Hunter, Rogue, Death Knight) https://www.wowhead.com/spell=20572
		[59548] = 180,		-- // Gift of the Naaru (Draenei: Mage) https://www.wowhead.com/spell=59548
		[121093] = 180,		-- // Gift of the Naaru (Draenei: Monk) https://www.wowhead.com/spell=121093
		[59544] = 180,		-- // Gift of the Naaru (Draenei: Priest) https://www.wowhead.com/spell=59544
		[59543] = 180,		-- // Gift of the Naaru (Draenei: Hunter) https://www.wowhead.com/spell=59543
		[370626] = 180,		-- // Gift of the Naaru (Draenei: Rogue) https://www.wowhead.com/spell=370626
		[59547] = 180,		-- // Gift of the Naaru (Draenei: Shaman) https://www.wowhead.com/spell=59547
		[59542] = 180,		-- // Gift of the Naaru (Draenei: Paladin) https://www.wowhead.com/spell=59542
		[28880] = 180,		-- // Gift of the Naaru (Draenei: Warrior) https://www.wowhead.com/spell=28880
		[416250] = 180,		-- // Gift of the Naaru (Draenei: Warlock) https://www.wowhead.com/spell=416250
		[59545] = 180,		-- // Gift of the Naaru (Draenei: Death Knight) https://www.wowhead.com/spell=59545
		[20594] = 120,		-- // Stoneform (Dwarf) https://www.wowhead.com/spell=20594
		[20549] = 90,     -- // War Stomp (Tauren) https://www.wowhead.com/spell=20549
		[26297] = 180,		-- // Berserking (Troll) https://www.wowhead.com/spell=26297
		[20577] = 120,    -- // Cannibalize (Undead) https://www.wowhead.com/spell=7744
		[68992] = 90,			-- // Darkflight (Worgen) https://www.wowhead.com/spell=68992
		[69070] = 90,			-- // Rocket Jump (Goblin) https://www.wowhead.com/spell=69070
		[20589] = 60,			-- // Escape Artist (Gnome) https://www.wowhead.com/spell=20589
		[287712] = 150,		-- // Haymaker (Kul Tiran) https://www.wowhead.com/spell=287712
		[58984] = 120,		-- // Shadowmeld (Night Elf) https://www.wowhead.com/spell=58984
		[59752] = 180,		-- // Will to Survive (Human) https://www.wowhead.com/spell=59752
		[357214] = 120,		-- // Wing Buffet (Dracthyr) https://www.wowhead.com/spell=357214
		[69041] = 90,			-- // Rocket Barrage (Goblin) https://www.wowhead.com/spell=69041
		[256948] = 180,		-- // Spatial Rift (Void Elf) https://www.wowhead.com/spell=256948
		[107079] = 120,   -- // Quaking Palm (Pandaren) https://www.wowhead.com/spell=107079
		[260364] = 180,   -- // Arcane Pulse (Nightborne) https://www.wowhead.com/spell=260364
		[7744] = 120,			-- // Will of the Forsaken (Undead) https://www.wowhead.com/spell=7744
		[274738] = 120,   -- // Ancestral Call (Mag'har Orc) https://www.wowhead.com/spell=274738
		[291944] = 180,   -- // Regeneratin' (Zandalari Troll) https://www.wowhead.com/spell=291944
		[255654] = 120,   -- // Bull Rush (Highmountain Tauren) https://www.wowhead.com/spell=255654
		[265221] = 120,		-- // Fireblood (Dark Iron Dwarf) https://www.wowhead.com/spell=265221/fireblood
	},
	["HUNTER"] = {
		-- // reviewed 2025/06/12
		[53271] = 22.5,					-- Master's Call https://wowhead.com/spell=53271
		[186265] = 150,		      -- Aspect of the Turtle https://www.wowhead.com/spell=186265
		[187650] = 25,		      -- Freezing Trap https://www.wowhead.com/spell=187650
		[5384] = 30,						-- Feign Death https://www.wowhead.com/spell=5384
		[186257] = 75,			    -- Aspect of the Cheetah https://www.wowhead.com/spell=186257
		[1543] = 20,						-- Flare https://www.wowhead.com/spell=1543
		[109304] = 120,					-- Exhilaration https://www.wowhead.com/spell=109304
		[781] = 20,							-- Disengage https://www.wowhead.com/spell=781
		[288613] = 120,			    -- Trueshot (-cd: 260404, 451546, 450369) https://www.wowhead.com/spell=288613
		[212431] = 30,				  -- Explosive Shot (-cd: 473522) https://www.wowhead.com/spell=212431
		[199483] = 60,					-- Camouflage https://www.wowhead.com/spell=199483
		[147362] = 24-2,				-- Counter Shot https://www.wowhead.com/spell=147362
		[19574] = 90-49,			  -- Bestial Wrath (-cd: 231548, 217200, 359844, 193532) https://www.wowhead.com/spell=19574
		[264735] = 90,		      -- Survival of the Fittest https://www.wowhead.com/spell=264735
		[109248] = 45-5,				-- Binding Shot (-cd: 459533, 19434, 56641, 459794) https://www.wowhead.com/spell=109248
		[213691] = 25,					-- Scatter Shot (-cd: 378771) https://www.wowhead.com/spell=213691
		[236776] = 40-5,				-- High Explosive Trap https://www.wowhead.com/spell=236776
		[19577] = 50-5,					-- Intimidation (-cd: 459533, 19434, 56641) https://www.wowhead.com/spell=19577
		[359844] = 120,					-- Call of the Wild https://www.wowhead.com/spell=359844
		[186387] = 25,					-- Bursting Shot (-cd: 378771) https://www.wowhead.com/spell=186387
		[190925] = 30-10,				-- Harpoon https://www.wowhead.com/spell=190925
		[187707] = 15-2,				-- Muzzle https://www.wowhead.com/spell=187707
		[205691] = 120,					-- Dire Beast: Basilisk https://www.wowhead.com/spell=205691
		[356719] = 60,					-- Chimaeral Sting https://www.wowhead.com/spell=356719
		[53480] = 60,						-- Roar of Sacrifice https://www.wowhead.com/spell=53480
		[212638] = 25,					-- Tracker's Net https://www.wowhead.com/spell=212638
		[360952] = 120-60,      -- Coordinated Assault (-cd: 451546, 450369) https://www.wowhead.com/spell=360952
		[375891] = 45,					-- Death Chakram https://www.wowhead.com/spell=375891
		[462031] = 60-5,        -- Implosive Trap https://www.wowhead.com/spell=462031
		[212640] = 25,          -- Mending Bandage https://www.wowhead.com/spell=212640
		[19801] = 5,            -- Tranquilizing Shot https://www.wowhead.com/spell=19801
	},
	["WARLOCK"] = {
		-- // reviewed 2025/06/12
		[48020] = 30,				-- Demonic Circle: Teleport https://www.wowhead.com/spell=48020
		[104773] = 135,			-- Unending Resolve https://www.wowhead.com/spell=104773
		[19647] = 24,				-- Spell Lock https://www.wowhead.com/spell=19647
		[132409] = 24,			-- Spell Lock (demon sacrificed) https://www.wowhead.com/spell=132409
		[333889] = 30,      -- Fel Domination https://www.wowhead.com/spell=333889
		[6358] = 20,        -- Seduction https://www.wowhead.com/spell=6358
		[119909] = 20,      -- Seduction https://www.wowhead.com/spell=119909
		[89766] = 30,       -- Axe Toss https://www.wowhead.com/spell=89766
		[119914] = 30,      -- Axe Toss https://www.wowhead.com/spell=119914
		[80240] = 30,				-- Havoc https://www.wowhead.com/spell=80240/havoc
		[265187] = 60,	    -- Summon Demonic Tyrant https://www.wowhead.com/spell=265187
		[205180] = 120,     -- Summon Darkglare https://www.wowhead.com/spell=205180
		[1122] = 120,				-- Summon Infernal https://www.wowhead.com/spell=1122
		[6789] = 45,				-- Mortal Coil https://www.wowhead.com/spell=6789
		[108416] = 60-15,   -- Dark Pact https://www.wowhead.com/spell=108416
		[111898] = 120,			-- Grimoire: Felguard https://www.wowhead.com/spell=111898
		[30283] = 45,				-- Shadowfury https://www.wowhead.com/spell=30283
		[5484] = 40-15,			-- Howl of Terror https://www.wowhead.com/spell=5484
		[113858] = 120,			-- Dark Soul: Instability https://www.wowhead.com/spell=113858
		[212295] = 45,			-- Nether Ward https://www.wowhead.com/spell=212295
		[353294] = 60,			-- Shadow Rift https://www.wowhead.com/spell=353294
		[212459] = 120,			-- Call Fel Lord https://www.wowhead.com/spell=212459
		[19505] = 15-5,     -- Devour Magic https://www.wowhead.com/spell=19505
		[205179] = 45,      -- Phantom Singularity https://www.wowhead.com/spell=205179
		[410598] = 60,      -- Soul Rip https://www.wowhead.com/spell=410598
	},
	["MAGE"] = {
		-- // reviewed 2025/06/12
		[122] = 21,					-- Frost Nova (-cd 205036) https://www.wowhead.com/spell=122
		[414658] = 180,     -- Ice Cold https://www.wowhead.com/spell=414658
		[1953] = 15-4,			-- Blink (-cd: 342249, 342245) https://www.wowhead.com/spell=1953
		[45438] = 180,	    -- Ice Block https://www.wowhead.com/spell=45438
		[2139] = 24,				-- Counterspell https://www.wowhead.com/spell=2139
		[389713] = 45,			-- Displacement https://www.wowhead.com/spell=389713
		[31661] = 26.5,	    -- Dragon's Breath https://www.wowhead.com/spell=31661
		[84714] = 60,				-- Frozen Orb (-cd: 236662, 417493) https://www.wowhead.com/spell=84714
		[12472] = 120,			-- Icy Veins https://www.wowhead.com/spell=12472
		[157980] = 45,			-- Supernova https://www.wowhead.com/spell=157980
		[449700] = 40,      -- Gravity Lapse https://www.wowhead.com/spell=449700
		[55342] = 120-40,		-- Mirror Image (-cd: 382569, 444784) https://www.wowhead.com/spell=55342
		[342245] = 60-10,		-- Alter Time https://www.wowhead.com/spell=342245
		[113724] = 26.5,    -- Ring of Frost https://www.wowhead.com/spell=113724
		[365350] = 90,			-- Arcane Surge https://www.wowhead.com/spell=365350
		[190319] = 118.5,		-- Combustion (-cd: 155148, 416506) https://www.wowhead.com/spell=190319
		[12051] = 90,				-- Evocation https://www.wowhead.com/spell=12051
		[157997] = 17.5,    -- Ice Nova https://www.wowhead.com/spell=157997
		[212653] = 25-4,		-- Shimmer https://www.wowhead.com/spell=212653
		[11426] = 25,				-- Ice Barrier (-cd: 382800) https://www.wowhead.com/spell=11426
		[157981] = 17.5,		-- Blast Wave https://www.wowhead.com/spell=157981
		[235219] = 300,			-- Cold Snap https://www.wowhead.com/spell=235219
		[66] = 300,					-- Invisibility https://www.wowhead.com/spell=66
		[110959] = 75,	    -- Greater Invisibility https://www.wowhead.com/spell=110959
		[414664] = 60,			-- Mass Invisibility https://www.wowhead.com/spell=414664
		[383121] = 60,			-- Mass Polymorph https://www.wowhead.com/spell=383121
		[353082] = 31.5,		-- Ring of Fire https://www.wowhead.com/spell=353082
		[389794] = 45,			-- Snowdrift https://www.wowhead.com/spell=389794
		[352278] = 90,			-- Ice Wall https://www.wowhead.com/spell=352278
		[198144] = 60,			-- Ice Form https://www.wowhead.com/spell=198144
		[414660] = 180,     -- Mass Barrier https://www.wowhead.com/spell=414660
		[475] = 8,          -- Remove Curse https://www.wowhead.com/spell=475
		[203286] = 15,      -- Greater Pyroblast https://www.wowhead.com/spell=203286
		[353128] = 45,      -- Arcanosphere https://www.wowhead.com/spell=353128
	},
	["DEATHKNIGHT"] = {
		-- // reviewed 2025/06/13
		[91802] 	= 30,			-- Shambling Rush https://www.wowhead.com/spell=91802
		[47481]   = 90,   	-- Gnaw https://www.wowhead.com/spell=47481
		[275699]	= 30,	    -- Apocalypse https://www.wowhead.com/spell=275699
		[48265]		= 45,			-- Death's Advance https://www.wowhead.com/spell=48265
		[444347]    = 45,   -- Death Charge https://www.wowhead.com/spell=444347
		[49576] 	= 25,			-- Death Grip	 https://www.wowhead.com/spell=49576
		[49039]		= 90,		  -- Lichborne https://www.wowhead.com/spell=49039
		[51052] 	= 90,	    -- Anti-Magic Zone https://www.wowhead.com/spell=51052
		[42650] 	= 180,		-- Army of the Dead https://www.wowhead.com/spell=42650
		[49206] 	= 180,		-- Summon Gargoyle https://www.wowhead.com/spell=49206
		[212552]	= 60,			-- Wraith Walk https://www.wowhead.com/spell=212552
		[49028] 	= 90,	    -- Dancing Rune Weapon (-cd: 377637) https://www.wowhead.com/spell=49028
		[207289] 	= 90,			-- Unholy Assault https://www.wowhead.com/spell=207289
		[221562] 	= 45,			-- Asphyxiate https://www.wowhead.com/spell=221562
		[108199] 	= 90,		  -- Gorefiend's Grasp https://www.wowhead.com/spell=108199
		[207167] 	= 60, 		-- Blinding Sleet https://www.wowhead.com/spell=207167
		[48792] 	= 120,		-- Icebound Fortitude (-cd: 434136) https://www.wowhead.com/spell=48792
		[48707] 	= 30,		  -- Anti-Magic Shell https://www.wowhead.com/spell=48707
		[383269]	= 120,		-- Abomination Limb https://www.wowhead.com/spell=383269
		[47528] 	= 15-3,		-- Mind Freeze (-cd: 378848) https://www.wowhead.com/spell=47528
		[55233] 	= 90,			-- Vampiric Blood (-cd: 205723) https://www.wowhead.com/spell=55233
		[47568] 	= 120,		-- Empower Rune Weapon https://www.wowhead.com/spell=47568
		[48743] 	= 120,		-- Death Pact https://www.wowhead.com/spell=48743
		[455395] 	= 90,			-- Raise Abomination https://www.wowhead.com/spell=455395
		[77606] 	= 20,			-- Dark Simulacrum https://www.wowhead.com/spell=77606
		[47476] 	= 45,			-- Strangulate https://www.wowhead.com/spell=47476
		[51271]     = 45,   -- Pillar of Frost https://www.wowhead.com/spell=51271
		[279302]    = 90,   -- Frostwyrm's Fury https://www.wowhead.com/spell=279302
		[194679]    = 25,  	-- Rune Tap https://www.wowhead.com/spell=194679
	},
	["DRUID"] = {
		-- // reviewed 2025/06/13
		[1850] = 120,							-- Dash https://www.wowhead.com/spell=1850
		[252216] = 45,						-- Tiger Dash https://www.wowhead.com/spell=252216
		[16979] = 15,							-- Wild Charge (Bear) https://www.wowhead.com/spell=16979
		[49376] = 15,							-- Wild Charge (Cat) https://www.wowhead.com/spell=49376
		[102383] = 15,						-- Wild Charge (Moonkin) https://www.wowhead.com/spell=102383
		[102401] = 15,						-- Wild Charge (Travel) https://www.wowhead.com/spell=102401
		[20484] = 600,						-- Rebirth https://www.wowhead.com/spell=20484
		[383410] = 120,						-- Celestial Alignment (ID change from 390378) https://www.wowhead.com/spell=383410
		[194223] = 90,						-- Celestial Alignment (ID change from 468743, -cd: 429420) https://www.wowhead.com/spell=194223
		[390414] = 120,						-- Incarnation: Chosen of Elune - Celestial Alignment (ID change from 390378) https://www.wowhead.com/spell=390414
		[102560] = 90,						-- Incarnation: Chosen of Elune - Celestial Alignment (ID change from 468743, -cd: 429420) https://www.wowhead.com/spell=102560
		[106951] = 120,						-- Berserk https://www.wowhead.com/spell=106951
		[50334] = 180,						-- Berserk (Guardian) https://www.wowhead.com/spell=50334
		[102543] = 120,					  -- Incarnation: Avatar of Ashamane (Feral) https://www.wowhead.com/spell=102543
		[102558] = 180,					  -- Incarnation: Guardian of Ursoc (Guardian) https://www.wowhead.com/spell=102558
		[22570] = 20,							-- Maim https://www.wowhead.com/spell=22570
		[61336] = 158.4,					-- Survival Instincts (-cd: 328767) https://www.wowhead.com/spell=61336
		[102793] = 60,						-- Ursol's Vortex https://www.wowhead.com/spell=102793
		[108238] = 90,						-- Renewal https://www.wowhead.com/spell=108238
		[33891] = 180-15,					-- Incarnation: Tree of Life (-cd: 393371, 392356) https://www.wowhead.com/spell=33891
		[106839] = 15,						-- Skull Bash https://www.wowhead.com/spell=106839
		[132469] = 30-5,					-- Typhoon https://www.wowhead.com/spell=132469
		[99] = 30,								-- Incapacitating Roar https://www.wowhead.com/spell=99
		[319454] = 300,						-- Heart of the Wild https://www.wowhead.com/spell=319454
		[391528] = 60,					  -- Convoke the Spirits https://www.wowhead.com/spell=391528
		[22842] = 36-5,						-- Frenzied Regeneration (-cd: 426784) https://www.wowhead.com/spell=22842/frenzied-regeneration
		[88423] = 8,							-- Nature's Cure https://www.wowhead.com/spell=88423/natures-cure
		[78675] = 60-15,					-- Solar Beam (-cd: 202918) https://www.wowhead.com/spell=78675
		[102359] = 30,						-- Mass Entanglement https://www.wowhead.com/spell=102359
		[5211]	= 60,							-- Mighty Bash https://www.wowhead.com/spell=5211
		[102342] = 70,						-- Ironbark https://www.wowhead.com/spell=102342
		[740] = 180-30,						-- Tranquility https://www.wowhead.com/spell=740
		[22812] = 52.8,						-- Barkskin https://www.wowhead.com/spell=22812
		[205636] = 60-15,					-- Force of Nature https://www.wowhead.com/spell=205636
		[2782] = 8,								-- Remove Corruption https://www.wowhead.com/spell=2782
		[106898] = 60,						-- Stampeding Roar (base ID, w/o form) https://www.wowhead.com/spell=106898
		[77761] = 60,							-- Stampeding Roar (use from Bear form) https://www.wowhead.com/spell=77761
		[77764] = 60,							-- Stampeding Roar (use from Cat form) https://www.wowhead.com/spell=77764
		[201664] = 30,            -- Demoralizing Roar https://www.wowhead.com/spell=201664
		[329042] = 120,						-- Emerald Slumber https://www.wowhead.com/spell=329042
		[209749] = 30,						-- Faerie Swarm https://www.wowhead.com/spell=209749
		[202246] = 25,						-- Overrun https://www.wowhead.com/spell=202246
		[354654] = 60,						-- Grove Protection https://www.wowhead.com/spell=354654
		[132158] = 60-12,		      -- Nature's Swiftness (-cd: 470540) https://www.wowhead.com/spell=132158
		[200851] = 60,            -- Rage of the Sleeper https://www.wowhead.com/spell=200851
		[473909] = 90,            -- Ancient of Lore https://www.wowhead.com/spell=473909
		[80313] = 35,             -- Pulverize https://www.wowhead.com/spell=80313
	},
	["MONK"] = {
		-- // reviewed 2025/06/13
		[119996] = 30,					-- Transcendence: Transfer https://www.wowhead.com/spell=119996
		[119381] = 55,					-- Leg Sweep https://www.wowhead.com/spell=119381
		[322109] = 90,					-- Touch of Death (-cd:391330) https://www.wowhead.com/spell=322109
		[169340] = 90,					-- Touch of Fatality https://www.wowhead.com/spell=169340
		[218164] = 8,						-- Detox (WW/BM) https://www.wowhead.com/spell=218164
		[115450] = 8,						-- Detox (MW) https://www.wowhead.com/spell=115450
		[137639] = 90,					-- Storm, Earth, and Fire (-cd: 280197) https://www.wowhead.com/spell=137639
		[115078] = 32,					-- Paralysis (-cd: 450631) https://www.wowhead.com/spell=115078
		[122783] = 90,					-- Diffuse Magic https://www.wowhead.com/spell=122783
		[116849] = 75,					-- Life Cocoon (-cd: 443294) https://www.wowhead.com/spell=116849
		[122470] = 90,					-- Touch of Karma https://www.wowhead.com/spell=122470
		[113656] = 20,					-- Fists of Fury (-cd: 392993) https://www.wowhead.com/spell=113656
		[123904] = 90,			    -- Invoke Xuen, the White Tiger https://www.wowhead.com/spell=123904
		[116844] = 40,				  -- Ring of Peace https://www.wowhead.com/spell=116844
		[107428] = 8.3,         -- Rising Sun Kick (-CD: 443294, 173841, 116680) https://www.wowhead.com/mop-classic/spell=107428
		[115310] = 151.2,			  -- Revival (-cd: 388551) https://www.wowhead.com/spell=115310
		[115176] = 150,					-- Zen Meditation https://www.wowhead.com/spell=115176
		[122278] = 120,					-- Dampen Harm https://www.wowhead.com/spell=122278
		[116841] = 30,					-- Tiger's Lust https://www.wowhead.com/spell=116841
		[116705] = 15,					-- Spear Hand Strike https://www.wowhead.com/spell=116705
		[198898] = 30,					-- Song of Chi-Ji https://www.wowhead.com/spell=198898
		[388615] = 151.2,			  -- Restoral https://www.wowhead.com/spell=388615
		[324312] = 60,					-- Clash https://www.wowhead.com/spell=324312
		[233759] = 45,					-- Grapple Weapon https://www.wowhead.com/spell=233759
		[116680] = 30,					-- Thunder Focus Tea https://www.wowhead.com/spell=116680
		[202370] = 30,					-- Mighty Ox Kick https://www.wowhead.com/spell=202370
		[354540] = 90,					-- Nimble Brew https://www.wowhead.com/spell=354540
		[115203] = 120,         -- Fortifying Brew https://www.wowhead.com/spell=115203
		[325197] = 60,          -- Invoke Chi-Ji, the Red Crane https://www.wowhead.com/spell=325197
		[322118] = 60,          -- Invoke Yu'lon, the Jade Serpent https://www.wowhead.com/spell=322118
    [443028] = 90,          -- Celestial Conduit https://www.wowhead.com/spell=443028
		[202162] = 45,          -- Avert Harm https://www.wowhead.com/spell=202162
	},
	["PALADIN"] = {
		-- // reviewed 2025/06/13
		[642] = 178.5,					-- Divine Shield (-cd: 385422) https://www.wowhead.com/spell=642
		[31884] = 120,					-- Avenging Wrath https://www.wowhead.com/spell=31884
		[853] = 30,							-- Hammer of Justice https://www.wowhead.com/spell=853
		[4987] = 8,							-- Cleanse https://www.wowhead.com/spell=4987
		[216331] = 60,					-- Avenging Crusader https://www.wowhead.com/spell=216331
		[1022] = 136.7,					-- Blessing of Protection https://www.wowhead.com/spell=1022
		[498] = 42,							-- Divine Protection https://www.wowhead.com/spell=498
		[6940] = 40.2,					-- Blessing of Sacrifice https://www.wowhead.com/spell=6940
		[31821] = 90,						-- Aura Mastery https://www.wowhead.com/spell=31821
		[231895] = 120,					-- Crusade https://www.wowhead.com/spell=231895
		[20066] = 15,						-- Repentance https://www.wowhead.com/spell=20066
		[633] = 348.5,					-- Lay on Hands (-cd: 392928) https://www.wowhead.com/spell=633
		[184662] = 63,					-- Shield of Vengeance https://www.wowhead.com/spell=184662
		[1044] = 25,						-- Blessing of Freedom https://www.wowhead.com/spell=1044
		[31850] = 84,						-- Ardent Defender (-cd: 385422) https://www.wowhead.com/spell=31850
		[86659] = 300,					-- Guardian of Ancient Kings (-cd: 378279, 204074) https://www.wowhead.com/spell=86659
		[96231] = 15,						-- Rebuke https://www.wowhead.com/spell=96231
		[204018] = 136.7,				-- Blessing of Spellwarding https://www.wowhead.com/spell=204018
		[190784] = 36,					-- Divine Steed (-cd: 230332) https://www.wowhead.com/spell=190784
		[115750] = 76.5,				-- Blinding Light https://www.wowhead.com/spell=115750
		[389539] = 120,					-- Sentinel https://www.wowhead.com/spell=389539
		[213644] = 8,						-- Cleanse Toxins https://www.wowhead.com/spell=213644
		[210256] = 60,					-- Blessing of Sanctuary https://www.wowhead.com/spell=210256
		[228049] = 300,					-- Guardian of the Forgotten Queen https://www.wowhead.com/spell=228049
		[375576] = 45,					-- Divine Toll https://www.wowhead.com/spell=375576
		[343721] = 60,					-- Final Reckoning https://www.wowhead.com/spell=343721
		[391054] = 600,         -- Intercession https://www.wowhead.com/spell=391054
		[327193] = 90,          -- Moment of Glory https://www.wowhead.com/spell=327193
		[414273] = 90,          -- Hand of Divinity https://www.wowhead.com/spell=414273
		[410126] = 45,         	-- Searing Glare https://www.wowhead.com/spell=410126
		[215652] = 45,          -- Shield of Virtue https://www.wowhead.com/spell=215652
	},
	["PRIEST"] = {
		-- // reviewed 2025/06/15
		[32375] = 60,				-- Mass Dispel https://www.wowhead.com/spell=32375
		[200183] = 120,     -- Apotheosis (-cd: 391387) https://www.wowhead.com/spell=200183
		[372760] = 60,      -- Divine Word https://www.wowhead.com/spell=372760
		[19236] = 90-20,    -- Desperate Prayer https://www.wowhead.com/spell=19236
		[8122] = 30,				-- Psychic Scream https://www.wowhead.com/spell=8122
		[527] = 8,					-- Purify (-cd: 196439) https://www.wowhead.com/spell=527
		[10060] = 120,			-- Power Infusion https://www.wowhead.com/spell=10060
		[33206] = 180,			-- Pain Suppression (-cd: 373035) https://www.wowhead.com/spell=33206
		[47788] = 180,			-- Guardian Spirit (-cd: 200209) https://www.wowhead.com/spell=47788
		[64843] = 120,			-- Divine Hymn https://www.wowhead.com/spell=64843
		[73325] = 120,			-- Leap of Faith (-cd: 440669) https://www.wowhead.com/spell=73325
		[62618] = 180,			-- Power Word: Barrier https://www.wowhead.com/spell=62618
		[271466] = 180,     -- Luminous Barrier https://www.wowhead.com/spell=271466
		[373481] = 12,			-- Power Word: Life https://www.wowhead.com/spell=373481
		[15487] = 30,				-- Silence https://www.wowhead.com/spell=15487
		[2050] = 45,				-- Holy Word: Serenity (-cd: 235587, 196985, 428933, 200183) https://www.wowhead.com/spell=2050
		[375901] = 45,			-- Mindgames https://www.wowhead.com/spell=375901
		[64901] = 180,      -- Symbol of Hope https://www.wowhead.com/spell=64901
		[108968] = 300,			-- Void Shift https://www.wowhead.com/spell=108968
		[120517] = 60,			-- Halo (Holy, DC) https://www.wowhead.com/spell=120517
		[120644] = 60,			-- Halo (Shadow) https://www.wowhead.com/spell=120517
		[88625] = 45,				-- Holy Word: Chastise (-cd: 200183) https://www.wowhead.com/spell=88625
		[213634] = 8,				-- Purify Disease (Shadow) https://www.wowhead.com/spell=213634
		[47585] = 120-30,		-- Dispersion https://www.wowhead.com/spell=47585
		[205364] = 30,			-- Dominate Mind https://www.wowhead.com/spell=205364
		[372835] = 120,			-- Lightwell https://www.wowhead.com/spell=372835
		[64044] = 45,				-- Psychic Horror https://www.wowhead.com/spell=64044
		[316262] = 90,			-- Thoughtsteal https://www.wowhead.com/spell=316262
		[289666] = 12,			-- Greater Heal https://www.wowhead.com/spell=289666
		[197268] = 90,      -- Ray of Hope https://www.wowhead.com/spell=197268
		[328530] = 60,      -- Divine Ascension https://www.wowhead.com/spell=328530
		[228260] = 120,			-- Void Eruption https://www.wowhead.com/spell=228260
		[586] = 20,					-- Fade https://www.wowhead.com/spell=586
		[421453] = 240,     -- Ultimate Penitence https://www.wowhead.com/spell=421453
		[451235] = 180,     -- Voidwraith https://www.wowhead.com/spell=451235
		[391109] = 60,      -- Dark Ascension https://www.wowhead.com/spell=391109
		[15286] = 90,       -- Vampiric Embrace https://www.wowhead.com/spell=15286
		[108920] = 60,      -- Void Tendrils https://www.wowhead.com/spell=108920
		[213610] = 45,      -- Holy Ward https://www.wowhead.com/spell=213610
	},
	["ROGUE"] = {
		-- // reviewed 2023/06/13
		[36554] = 20.1,				-- Shadowstep (-cd: 394931, 457057) https://www.wowhead.com/spell=36554
		[185313] = 60,				-- Shadow Dance (-cd: 185314, 394930) https://www.wowhead.com/spell=185313
		[315341] = 45,				-- Between the Eyes (-cd: 424254) https://www.wowhead.com/spell=315341/between-the-eyes
		[1856] = 96,					-- Vanish (-cd:382513) https://www.wowhead.com/spell=1856
		[114018] = 162,				-- Shroud of Concealment https://www.wowhead.com/spell=114018
		[408] = 30,						-- Kidney Shot https://www.wowhead.com/spell=408
		[1766] = 15,					-- Kick https://www.wowhead.com/spell=1766
		[1966] = 12,          -- Feint (-cd:423647, 354897) https://www.wowhead.com/spell=1966
		[2983] = 30,					-- Sprint https://www.wowhead.com/spell=2983
		[13750] = 180,				-- Adrenaline Rush https://www.wowhead.com/spell=13750
		[31224] = 120,				-- Cloak of Shadows https://www.wowhead.com/spell=31224
		[2094] = 40.5,				-- Blind https://www.wowhead.com/spell=2094
		[5277] = 120,					-- Evasion (-cd:354897) https://www.wowhead.com/spell=5277
		[1776] = 25,					-- Gouge https://www.wowhead.com/spell=1776
		[51690] = 81,					-- Killing Spree https://www.wowhead.com/spell=51690
		[121471] = 72,				-- Shadow Blades https://www.wowhead.com/spell=121471
		[271877] = 45,				-- Blade Rush https://www.wowhead.com/spell=271877
		[195457] = 30,				-- Grappling Hook (-cd: 454433, 394931) https://www.wowhead.com/spell=195457
		[212182] = 180,				-- Smoke Bomb (Outlaw, Assassination) https://www.wowhead.com/spell=212182
		[359053] = 120,				-- Smoke Bomb (Subtlety) https://www.wowhead.com/spell=359053
		[207777] = 45,				-- Dismantle https://www.wowhead.com/spell=207777
		[185311] = 30,        -- Crimson Vial https://www.wowhead.com/spell=185311
		[360194] = 120,       -- Deathmark https://www.wowhead.com/spell=360194
	},
	["SHAMAN"] = {
		-- // reviewed 2023/06/14
		[79206] = 90,			-- Spiritwalker's Grace https://www.wowhead.com/spell=79206
		[196884] = 30,		-- Feral Lunge https://www.wowhead.com/spell=196884
		[375982] = 30,		-- Primordial Wave https://www.wowhead.com/spell=375982
		[51514] = 15,			-- Hex https://www.wowhead.com/spell=51514
		[210873] = 15,		-- Hex https://www.wowhead.com/spell=210873
		[211004] = 15,		-- Hex https://www.wowhead.com/spell=211004
		[211010] = 15,		-- Hex https://www.wowhead.com/spell=211010
		[211015] = 15,		-- Hex https://www.wowhead.com/spell=211015
		[269352] = 15,		-- Hex https://www.wowhead.com/spell=269352
		[277778] = 15,		-- Hex https://www.wowhead.com/spell=277778
		[277784] = 15,		-- Hex https://www.wowhead.com/spell=277784
		[309328] = 15,		-- Hex https://www.wowhead.com/spell=309328
		[114050] = 120,		-- Elemental Ascendance https://www.wowhead.com/spell=114050
		[114051] = 120,		-- Enhancement Ascendance https://www.wowhead.com/spell=114051
		[114052] = 120,		-- Restoration Ascendance https://www.wowhead.com/spell=114052
		[198838] = 54,		-- Earthen Wall Totem https://www.wowhead.com/spell=198838
		[108280] = 124,		-- Healing Tide Totem (-cd: 382030) https://www.wowhead.com/spell=108280
		[98008] = 174,		-- Spirit Link Totem https://www.wowhead.com/spell=98008
		[51485] = 24-5,		-- Earthgrab Totem (-cd: 445027) https://www.wowhead.com/spell=51485
		[8143] = 54-5,		-- Tremor Totem (-cd: 445027) https://www.wowhead.com/spell=8143
		[192058] = 54-20-5,	-- Capacitor Totem (-cd: 265046, 445027) https://www.wowhead.com/spell=192058
		[192077] = 84,		-- Wind Rush Totem https://www.wowhead.com/spell=192077
		[204336] = 24,		-- Grounding Totem https://www.wowhead.com/spell=204336
		[204331] = 39,		-- Counterstrike Totem https://www.wowhead.com/spell=204331
		[355580] = 84,		-- Static Field Totem https://www.wowhead.com/spell=355580
		[383013] = 114-5, -- Poison Cleansing Totem (-cd: 445027) https://www.wowhead.com/spell=383013
		[207399] = 294,		-- Ancestral Protection Totem https://www.wowhead.com/spell=207399
		[108285] = 120,   -- Totemic Recall https://www.wowhead.com/spell=108285
		[108287] = 10,    -- Totemic Projection https://www.wowhead.com/spell=108287
		[204362] = 60,		-- Heroism (PvP) https://www.wowhead.com/spell=204362
		[204361] = 60,		-- Bloodlust (PvP) https://www.wowhead.com/spell=204361
		[77130] = 8,			-- Purify Spirit (Heal) https://www.wowhead.com/spell=77130
		[51886] = 8,			-- Cleanse Spirit (Talent for DD) https://www.wowhead.com/spell=51886
		[378773] = 12,    -- Greater Purge https://www.wowhead.com/spell=378773
		[51533] = 90,			-- Feral Spirit (-cd: 384447) https://www.wowhead.com/spell=51533
		[108271] = 90,		-- Astral Shift https://www.wowhead.com/spell=108271
		[191634] = 60,		-- Stormkeeper (-cd: 468571) https://www.wowhead.com/spell=191634
		[192063] = 20,		-- Gust of Wind https://www.wowhead.com/spell=192063
		[57994] = 12,			-- Wind Shear https://www.wowhead.com/spell=57994
		[197214] = 30,		-- Sundering https://www.wowhead.com/spell=197214
		[378081] = 60,		-- Nature's Swiftness https://www.wowhead.com/spell=378081
		[51490] = 25,			-- Thunderstorm https://www.wowhead.com/spell=51490
		[305483] = 45,		-- Lightning Lasso https://www.wowhead.com/spell=305483
		[58875] = 60,			-- Spirit Walk https://www.wowhead.com/spell=58875
		[409293] = 120,  	-- Burrow https://www.wowhead.com/spell=409293
		[443454] = 30,    -- Ancestral Swiftness https://www.wowhead.com/spell=443454
		[356736] = 30,    -- Unleash Shield https://www.wowhead.com/spell=356736

	},
	["WARRIOR"] = {
		-- // reviewed 2025/06/14
		[100] = 17,						-- Charge (-cd: 103827) https://www.wowhead.com/spell=100
		[6552] = 13.3,				-- Pummel https://www.wowhead.com/spell=6552
		[1719] = 90,					-- Recklessness (-cd: 152278) https://www.wowhead.com/spell=1719
		[23920] = 23.7,				-- Spell Reflection https://www.wowhead.com/spell=23920
		[227847] = 90,				-- Bladestorm (-cd: 382953, 152278) https://www.wowhead.com/spell=227847
		[167105] = 45,				-- Colossus Smash (-cd: 152278) https://www.wowhead.com/spell=167105
		[118038] = 85.5,			-- Die by the Sword https://www.wowhead.com/spell=118038
		[5246] = 75,					-- Intimidating Shout https://www.wowhead.com/spell=5246
		[316593] = 75,				-- Intimidating Shout (with Menace 275338 talent) https://www.wowhead.com/spell=316593
		[6544] = 30,					-- Heroic Leap https://www.wowhead.com/spell=6544
		[107574] = 90,				-- Avatar (-cd: 152278) https://www.wowhead.com/spell=107574
		[871] = 120,					-- Shield Wall (-cd: 152278) https://www.wowhead.com/spell=871
		[107570] = 28.5,		  -- Storm Bolt https://www.wowhead.com/spell=107570
		[12975] = 120,				-- Last Stand https://www.wowhead.com/spell=12975
		[262161] = 45,				-- Warbreaker (-cd: 152278) https://www.wowhead.com/spell=262161
		[3411] = 28.5,				-- Intervene (-cd: 424654) https://www.wowhead.com/spell=3411/intervene
		[18499] = 60,					-- Berserker Rage https://www.wowhead.com/spell=18499
		[46968] = 40-20,			-- Shockwave (-cd: 275339) https://www.wowhead.com/spell=46968
		[184364] = 114,				-- Enraged Regeneration https://www.wowhead.com/spell=184364
		[392966] = 90,				-- Spell Block https://www.wowhead.com/spell=392966
		[384318] = 45,				-- Thunderous Roar https://www.wowhead.com/spell=384318
		[383762] = 180,				-- Bitter Immunity https://www.wowhead.com/spell=383762
		[385952] = 45,				-- Shield Charge https://www.wowhead.com/spell=385952
		[64382] = 90,					-- Shattering Throw https://www.wowhead.com/spell=64382
		[386071] = 90,				-- Disrupting Shout https://www.wowhead.com/spell=386071
		[384100] = 60,				-- Berserker Shout https://www.wowhead.com/spell=384100
		[236077] = 45,				-- Disarm https://www.wowhead.com/spell=236077
		[206572] = 30,				-- Dragon Charge https://www.wowhead.com/spell=206572
		[97462] = 60,					-- Rallying Cry https://www.wowhead.com/spell=97462
		[376079] = 90,        -- Champion's Spear https://www.wowhead.com/spell=376079
		[436358] = 45,        -- Demolish https://www.wowhead.com/spell=436358
		[236273] = 60,        -- Duel https://www.wowhead.com/spell=236273
		[1160] = 30-18,       -- Demoralizing Shout (-cd: 385840, 6343) https://www.wowhead.com/spell=1160
	},
	["DEMONHUNTER"] = {
		-- // reviewed 2025/06/14
		[191427] = 120,			-- Metamorphosis (Havoc) https://www.wowhead.com/spell=191427
		[187827] = 120,			-- Metamorphosis (Vengeance) https://www.wowhead.com/spell=187827
		[183752] = 15,			-- Disrupt https://www.wowhead.com/spell=183752
		[188501] = 25,			-- Spectral Sight https://www.wowhead.com/spell=188501
		[195072] = 8,				-- Fel Rush (-cd: 320416) https://www.wowhead.com/spell=195072
		[198589] = 60,			-- Blur (-cd: 205411) https://www.wowhead.com/spell=198589
		[189110] = 8,				-- Infernal Strike (-cd: 320416) https://www.wowhead.com/spell=189110
		[198793] = 20,			-- Vengeful Retreat (-cd: 444929) https://www.wowhead.com/spell=198793
		[207684] = 67.5,		-- Sigil of Misery https://www.wowhead.com/spell=207684
		[217832] = 45,			-- Imprison https://www.wowhead.com/spell=217832
		[204021] = 48,			-- Fiery Brand (-cd: 389732) https://www.wowhead.com/spell=204021
		[196718] = 180,			-- Darkness https://www.wowhead.com/spell=196718
		[211881] = 30,			-- Fel Eruption https://www.wowhead.com/spell=211881
		[179057] = 45,			-- Chaos Nova https://www.wowhead.com/spell=179057
		[196555] = 180,			-- Netherwalk https://www.wowhead.com/spell=196555
		[202137] = 67.5,		-- Sigil of Silence https://www.wowhead.com/spell=202137
		[263648] = 30,			-- Soul Barrier https://www.wowhead.com/spell=263648
		[206803] = 90,			-- Rain from Above https://www.wowhead.com/spell=206803
		[205604] = 60,			-- Reverse Magic https://www.wowhead.com/spell=205604
		[205630] = 60,			-- Illidan's Grasp https://www.wowhead.com/spell=205630
		[205629] = 10,			-- Demonic Trample https://www.wowhead.com/spell=205629
		[202138] = 45,			-- Sigil of Chains https://www.wowhead.com/spell=202138
		[198013] = 40-20,		-- Eye Beam (-cd: 388112) https://www.wowhead.com/spell=198013/eye-beam
		[278326] = 10,      -- Consume Magic https://www.wowhead.com/spell=278326
		[370965] = 90,      -- The Hunt https://www.wowhead.com/spell=370965
	},
	["EVOKER"] = {
		-- // reviewed 2025/06/14
		[357210] = 60,					-- Deep Breath (-cd: 371806) https://www.wowhead.com/spell=357210/deep-breath
		[390386] = 270,					-- Fury of the Aspects (-cd: 412713) https://www.wowhead.com/spell=390386
		[358267] = 27,				  -- Hover (-cd: 365933, 412713) https://www.wowhead.com/spell=358267
		[375087] = 120,					-- Dragonrage https://www.wowhead.com/spell=375087
		[360995] = 21.6,				-- Verdant Embrace (-cd: 412713) https://www.wowhead.com/spell=360995
		[370665] = 60,					-- Rescue https://www.wowhead.com/spell=370665
		[363534] = 180,					-- Rewind (-cd: 376210) https://www.wowhead.com/spell=363534
		[370553] = 108,					-- Tip the Scales (-cd: 412713) https://www.wowhead.com/spell=370553
		[351338] = 18,					-- Quell (-cd: 412713) https://www.wowhead.com/spell=351338
		[374348] = 54,					-- Renewing Blaze (-cd: 412713) https://www.wowhead.com/spell=374348
		[357170] = 60,					-- Time Dilation (-cd: 376204) https://www.wowhead.com/spell=357170
		[370537] = 90,					-- Stasis https://www.wowhead.com/spell=370537
		[374251] = 54,					-- Cauterizing Flame (-cd: 412713) https://www.wowhead.com/spell=374251
		[406971] = 81,					-- Oppressing Roar (-cd: 412713) https://www.wowhead.com/spell=406971
		[374968] = 108,					-- Time Spiral (-cd: 412713) https://www.wowhead.com/spell=374968
		[363916] = 81,					-- Obsidian Scales (-cd: 375406, 412713) https://www.wowhead.com/spell=363916
		[374227] = 108,					-- Zephyr (-cd: 412713) https://www.wowhead.com/spell=374227
		[359816] = 120,					-- Dream Flight (-cd: 371806) https://www.wowhead.com/spell=359816
		[358385] = 40.5,				-- Landslide (-cd: 412713) https://www.wowhead.com/spell=358385
		[370960] = 180,					-- Emerald Communion https://www.wowhead.com/spell=370960
		[378464] = 81,					-- Nullifying Shroud (-cd: 412713) https://www.wowhead.com/spell=378464
		[377509] = 60,					-- Dream Projection https://www.wowhead.com/spell=377509
		[383005] = 40.5,				-- Chrono Loop (-cd: 412713) https://www.wowhead.com/spell=383005
		[370388] = 81,					-- Swoop Up (-cd: 412713) https://www.wowhead.com/spell=370388
		[378441] = 40.5,			  -- Time Stop (-cd: 412713) https://www.wowhead.com/spell=378441
		[368970] = 162,         -- Tail Swipe (-cd: 412713) https://www.wowhead.com/spell=368970
		[360823] = 8,           -- Naturalize https://www.wowhead.com/spell=360823
		[406732] = 270,         -- Spatial Paradox (-cd: 412713) https://www.wowhead.com/spell=406732
		[365585] = 7.2,         -- Expunge (DD, -cd: 412713) https://www.wowhead.com/spell=365585
		[403631] = 108,         -- Breath of Eons (-cd: 371806, 441206, 412713) https://www.wowhead.com/spell=403631
		[412713] = 162,         -- Interwoven Threads - Time Skip (replaces Time Skip name and ID if this talent is selected)  https://www.wowhead.com/spell=412713
	},
};

addonTable.Interrupts = {
	[47528] = true,	    -- Mind Freeze (-cd: 378848) https://www.wowhead.com/spell=47528
	[106839] = true,		-- Skull Bash https://www.wowhead.com/spell=106839
	[2139] = true,	    -- Counterspell https://www.wowhead.com/spell=2139
	[96231] = true,	    -- Rebuke https://www.wowhead.com/spell=96231
	[15487] = true,	    -- Silence https://www.wowhead.com/spell=15487
	[1766] = true,	    -- Kick https://www.wowhead.com/spell=1766
	[57994] = true,	    -- Wind Shear https://www.wowhead.com/spell=57994
	[6552] = true,	    -- Pummel https://www.wowhead.com/spell=6552
	[19647] = true,	    -- Spell Lock https://www.wowhead.com/spell=19647
	[132409] = true,    -- Spell Lock (demon sacrificed) https://www.wowhead.com/spell=132409
	[116705] = true,    -- Spear Hand Strike https://www.wowhead.com/spell=116705
	[183752] = true,		-- Disrupt https://www.wowhead.com/spell=183752
	[187707] = true,    -- Muzzle https://www.wowhead.com/spell=187707
	[91802] = true,	    -- Shambling Rush https://www.wowhead.com/spell=91802
	[78675] = true,	    -- Solar Beam (-cd: 202918) https://www.wowhead.com/spell=78675
	[351338] = true,		-- Quell https://www.wowhead.com/spell=351338
	[147362] = true,		-- Counter Shot https://www.wowhead.com/spell=147362
};

addonTable.Trinkets = {
	[59752] = true,
	[7744] = true,
	[336126] = true,
	[283167] = true,
};

-- // spells that reduce cooldown of other spells
do

	local BIG_REDUCTION = 4*1000*1000;

	addonTable.Reductions = {
		[342245] = { -- // Alter Time https://www.wowhead.com/spell=342245
			["reduction"] = BIG_REDUCTION,
			["spells"] = {
				1953,		-- // Blink https://www.wowhead.com/spell=1953
				212653	-- // Shimmer https://www.wowhead.com/spell=212653
			},
		},
		[115191] = { -- // Stealth
			["reduction"] = BIG_REDUCTION,
			["spells"] = { 315341 }, -- Between the Eyes (-cd: 424254) https://www.wowhead.com/spell=315341
		},
		[191427] = { -- // Metamorphosis (Havoc) https://www.wowhead.com/spell=191427
			["reduction"] = BIG_REDUCTION,
			["spells"] = { 198013 }, -- Eye Beam (-cd: 388112) https://www.wowhead.com/spell=198013
		},
		[235219] = { -- // Cold Snap https://www.wowhead.com/spell=235219
			["reduction"] = BIG_REDUCTION,
			["spells"] = {
				11426,			-- // Ice Barrier https://www.wowhead.com/spell=11426
				122,				-- // Frost Nova https://www.wowhead.com/spell=122
				120,				-- // Cone of Cold https://www.wowhead.com/spell=120
				414658,     -- // Ice Cold https://www.wowhead.com/spell=414658
				45438,			-- // Ice Block https://www.wowhead.com/spell=45438
			},
		},
		[50334] = { -- // Berserk (Guardian) https://www.wowhead.com/spell=50334
			["reduction"] = BIG_REDUCTION,
			["spells"] = {
				22842,			-- // Frenzied Regeneration https://www.wowhead.com/spell=22842
			},
		},
		[107428] = {	-- Rising Sun Kick (-CD: 443294, 173841, 116680) https://www.wowhead.com/mop-classic/spell=107428
			["reduction"] = 1,
			["spells"] = {
				115310,	-- Revival (-cd: 388551) https://www.wowhead.com/spell=115310
			},
		},
		[188196] = {	-- Lightning Bolt https://www.wowhead.com/spell=188196
			["reduction"] = 2,
			["spells"] = {
				191634,	-- Stormkeeper https://www.wowhead.com/spell=191634
			},
		},
		[364343] = {	-- Echo https://www.wowhead.com/spell=364343
			["reduction"] = 2,
			["spells"] = {
				357170,	-- Time Dilation https://www.wowhead.com/spell=357170
			},
		},
		[355913] = {	-- Emerald Blossom https://www.wowhead.com/spell=355913
			["reduction"] = 2,
			["spells"] = {
				357170,	-- Time Dilation https://www.wowhead.com/spell=357170
			},
		},
		[188443] = {	-- Chain Lightning https://www.wowhead.com/spell=188443
			["reduction"] = 2,
			["spells"] = {
				191634,	-- Stormkeeper https://www.wowhead.com/spell=191634
			},
		},
		[17] = {	-- Power Word: Shield https://www.wowhead.com/spell=17
			["reduction"] = 3,
			["spells"] = {
				33206,	-- Pain Suppression (-cd: 373035) https://www.wowhead.com/spell=33206
			},
		},
		[33076] = {	-- Prayer of Mending https://www.wowhead.com/spell=33076
			["reduction"] = 5,
			["spells"] = {
				33206,	-- Holy Word: Serenity (-cd: 235587, 196985, 428933) https://www.wowhead.com/spell=2050
			},
		},
		[373481] = {	-- Power Word: Life https://www.wowhead.com/spell=373481
			["reduction"] = 5,
			["spells"] = {
				33206,	-- Holy Word: Serenity (-cd: 235587, 196985, 428933) https://www.wowhead.com/spell=2050
			},
		},
		[2060] = {	-- Heal https://www.wowhead.com/spell=2060
			["reduction"] = 7,
			["spells"] = {
				33206,	-- Holy Word: Serenity (-cd: 235587, 196985, 428933) https://www.wowhead.com/spell=2050
			},
		},
		[2061] = {	-- Flash Heal https://www.wowhead.com/spell=2061
			["reduction"] = 7,
			["spells"] = {
				33206,	-- Holy Word: Serenity (-cd: 235587, 196985, 428933) https://www.wowhead.com/spell=2050
			},
		},
		[585] = {	-- Smite https://www.wowhead.com/spell=585
			["reduction"] = 5,
			["spells"] = {
				88625,	-- Holy Word: Chastise https://www.wowhead.com/spell=88625
			},
		},
		[132157] = {	-- Holy Nova https://www.wowhead.com/spell=132157
			["reduction"] = 5,
			["spells"] = {
				88625,	-- Holy Word: Chastise https://www.wowhead.com/spell=88625
			},
		},
		[200183] = {	-- Apotheosis https://www.wowhead.com/spell=200183
			["reduction"] = BIG_REDUCTION,
			["spells"] = {
				2050,	-- Holy Word: Serenity https://www.wowhead.com/spell=2050
				88625,	-- Holy Word: Chastise https://www.wowhead.com/spell=88625
			},
		},
	};

end
