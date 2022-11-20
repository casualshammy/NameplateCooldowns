-- luacheck: no max line length
-- luacheck: globals GetBuildInfo LibStub GetSpellInfo

local _, addonTable = ...;

addonTable.HUNTER_FEIGN_DEATH = 5384;
addonTable.SPELL_PVPTRINKET = 42292;

addonTable.CDs = {
	[addonTable.UNKNOWN_CLASS] = {
		-- // reviewed 2021/02/08
		[42292] = 120,		-- // PvP-аксессуар https://www.wowhead.com/wotlk/ru/spell=42292
		[28730] = 120,		-- // Arcane Torrent https://www.wowhead.com/wotlk/ru/spell=28730
		[50613] = 120,		-- // Arcane Torrent https://www.wowhead.com/wotlk/ru/spell=50613
		[25046] = 120,		-- // Arcane Torrent https://www.wowhead.com/wotlk/ru/spell=25046
		[20572] = 120,		-- // Blood Fury https://www.wowhead.com/wotlk/ru/spell=20572
		[33702] = 120,		-- // Blood Fury https://www.wowhead.com/wotlk/ru/spell=33702
		[33697] = 120,		-- // Blood Fury https://www.wowhead.com/wotlk/ru/spell=33697
		[59543] = 180,		-- // Gift of the Naaru https://www.wowhead.com/wotlk/ru/spell=59543
		[26297] = 180,		-- // Berserking https://www.wowhead.com/wotlk/ru/spell=26297
		[20594] = 120,		-- // Stoneform https://www.wowhead.com/wotlk/ru/spell=20594
		[58984] = 120,		-- // Shadowmeld https://www.wowhead.com/wotlk/ru/spell=58984
		[20589] = 105,		-- // Escape Artist https://www.wowhead.com/wotlk/ru/spell=20589
		[59752] = 120,		-- // Every Man for Himself https://www.wowhead.com/wotlk/ru/spell=59752
		[7744] = 120,		-- // Will of the Forsaken https://www.wowhead.com/wotlk/ru/spell=7744
	},
	["HUNTER"] = {
		-- // reviewed 2022/10/16
		[53271] = 60,					-- // Master's Call https://www.wowhead.com/wotlk/ru/spell=53271
		[19574] = 60,					-- // Bestial Wrath https://www.wowhead.com/wotlk/ru/spell=19574
		[19577] = 40,					-- // Intimidation https://www.wowhead.com/wotlk/ru/spell=19577
		[5384] = 25,					-- Feign Death https://www.wowhead.com/wotlk/ru/spell=5384/feign-death
		[53480] = 60,					-- Roar of Sacrifice https://www.wowhead.com/wotlk/ru/spell=53480/roar-of-sacrifice
		[34026] = 30,					-- Kill Command https://www.wowhead.com/wotlk/spell=34026/kill-command
		[1513] = 30,					-- Scare Beast 1 https://www.wowhead.com/wotlk/spell=1513
		[14326] = 30,					-- Scare Beast 2 https://www.wowhead.com/wotlk/spell=14326
		[14327] = 30,					-- Scare Beast 3 https://www.wowhead.com/wotlk/spell=14327
		[3045] = 3*60,					-- Rapid Fire https://www.wowhead.com/wotlk/spell=3045
		[1543] = 20,					-- Flare https://www.wowhead.com/wotlk/spell=1543
		[19263] = 80,					-- Deterrence https://www.wowhead.com/wotlk/spell=19263
		[60192] = 30,					-- Freezing Arrow https://www.wowhead.com/wotlk/spell=60192
		[1499] = 20,					-- Freezing Trap 1 https://www.wowhead.com/wotlk/spell=1499
		[14310] = 20,					-- Freezing Trap 2 https://www.wowhead.com/wotlk/spell=14310
		[14311] = 20,					-- Freezing Trap 3 https://www.wowhead.com/wotlk/spell=14311
		[13809] = 20,					-- Frost Trap https://www.wowhead.com/wotlk/spell=13809
		[34490] = 20,					-- Silencing Shot https://www.wowhead.com/wotlk/spell=34490
		[23989] = 3*60,					-- Readiness https://www.wowhead.com/wotlk/spell=23989
		[19503] = 30,					-- Scatter Shot https://www.wowhead.com/wotlk/spell=19503
	},
	["WARLOCK"] = {
		-- // reviewed 2022/10/18
		[48020] = 26,		-- Demonic Circle: Teleport https://www.wowhead.com/wotlk/ru/spell=48020
		[6789] = 120,		-- Death Coil 1 https://www.wowhead.com/wotlk/ru/spell=6789
		[17925] = 120,		-- Death Coil 2 https://www.wowhead.com/wotlk/ru/spell=17925
		[17926] = 120,		-- Death Coil 3 https://www.wowhead.com/wotlk/ru/spell=17926
		[27223] = 120,		-- Death Coil 4 https://www.wowhead.com/wotlk/ru/spell=27223
		[47859] = 120,		-- Death Coil 5 https://www.wowhead.com/wotlk/ru/spell=47859
		[47860] = 120,		-- Death Coil 6 https://www.wowhead.com/wotlk/ru/spell=47860
		[5484] = 32,		-- Howl of Terror 1 https://www.wowhead.com/wotlk/ru/spell=5484
		[17928] = 32,		-- Howl of Terror 2 https://www.wowhead.com/wotlk/ru/spell=17928
		[30283] = 20,		-- Shadowfury https://www.wowhead.com/wotlk/ru/spell=30283
		[19647] = 24,		-- Spell Lock https://www.wowhead.com/wotlk/ru/spell=19647
		[1122] = 600,		-- Summon Infernal https://www.wowhead.com/wotlk/ru/spell=1122
		[54785] = 45,		-- Demon Charge https://www.wowhead.com/wotlk/ru/spell=54785
		[47193] = 60,		-- Demonic Empowerment https://www.wowhead.com/wotlk/ru/spell=47193
		[59672] = 3*60,		-- Metamorphosis https://www.wowhead.com/wotlk/ru/spell=59672
		[18708] = 2*60,		-- Fel Domination https://www.wowhead.com/wotlk/ru/spell=18708
	},
	["MAGE"] = {
		-- // reviewed 2022/10/19
		[122] = 20,			-- Frost Nova 1 https://www.wowhead.com/wotlk/ru/spell=122
		[865] = 20,			-- Frost Nova 2 https://www.wowhead.com/wotlk/ru/spell=865
		[6131] = 20,		-- Frost Nova 3 https://www.wowhead.com/wotlk/ru/spell=6131
		[10230] = 20,		-- Frost Nova 4 https://www.wowhead.com/wotlk/ru/spell=10230
		[27088] = 20,		-- Frost Nova 5 https://www.wowhead.com/wotlk/ru/spell=27088
		[42917] = 20,		-- Frost Nova 6 https://www.wowhead.com/wotlk/ru/spell=42917
		[120] = 8,			-- Cone of Cold 1 https://www.wowhead.com/wotlk/ru/spell=120
		[8492] = 8,			-- Cone of Cold 2 https://www.wowhead.com/wotlk/ru/spell=8492
		[10159] = 8,		-- Cone of Cold 3 https://www.wowhead.com/wotlk/ru/spell=10159
		[10160] = 8,		-- Cone of Cold 4 https://www.wowhead.com/wotlk/ru/spell=10160
		[10161] = 8,		-- Cone of Cold 5 https://www.wowhead.com/wotlk/ru/spell=10161
		[27087] = 8,		-- Cone of Cold 6 https://www.wowhead.com/wotlk/ru/spell=27087
		[42930] = 8,		-- Cone of Cold 7 https://www.wowhead.com/wotlk/ru/spell=42930
		[42931] = 8,		-- Cone of Cold 8 https://www.wowhead.com/wotlk/ru/spell=42931
		[6143] = 30,		-- Frost Ward 1 https://www.wowhead.com/wotlk/ru/spell=6143
		[8461] = 30,		-- Frost Ward 2 https://www.wowhead.com/wotlk/ru/spell=8461
		[8462] = 30,		-- Frost Ward 3 https://www.wowhead.com/wotlk/ru/spell=8462
		[10177] = 30,		-- Frost Ward 4 https://www.wowhead.com/wotlk/ru/spell=10177
		[28609] = 30,		-- Frost Ward 5 https://www.wowhead.com/wotlk/ru/spell=28609
		[32796] = 30,		-- Frost Ward 6 https://www.wowhead.com/wotlk/ru/spell=32796
		[43012] = 30,		-- Frost Ward 7 https://www.wowhead.com/wotlk/ru/spell=43012
		[1953] = 13,		-- Blink https://www.wowhead.com/wotlk/ru/spell=1953
		[45438] = 4*60,		-- Ice Block https://www.wowhead.com/wotlk/ru/spell=45438
		[2139] = 22,		-- Counterspell https://www.wowhead.com/wotlk/ru/spell=2139
		[12042] = 80,		-- Arcane Power https://www.wowhead.com/wotlk/ru/spell=12042
		[31661] = 20,		-- Dragon's Breath https://www.wowhead.com/wotlk/ru/spell=31661
		[66] = 2*60,		-- Invisibility https://www.wowhead.com/wotlk/ru/spell=66
		[55342] = 180,		-- Зеркальное изображение https://www.wowhead.com/wotlk/ru/spell=55342
		[12051] = 2*60,		-- Evocation https://www.wowhead.com/wotlk/ru/spell=12051
		[12043] = 80,		-- Presence of Mind https://www.wowhead.com/wotlk/ru/spell=12043
		[11129] = 120,		-- Combustion https://www.wowhead.com/wotlk/ru/spell=11129
		[12472] = 144,		-- Icy Veins https://www.wowhead.com/wotlk/ru/spell=12472
		[44572] = 30,		-- Deep Freeze https://www.wowhead.com/wotlk/ru/spell=44572
		[11958] = 384,		-- Cold Snap https://www.wowhead.com/wotlk/ru/spell=11958
	},
	["DEATHKNIGHT"] = {
		-- // reviewed 2022/10/22
		[47476]		= 100,			-- Strangulate https://www.wowhead.com/wotlk/ru/spell=47476
		[48743]		= 120,			-- Death Pact https://www.wowhead.com/wotlk/ru/spell=48743
		[48792]		= 120,			-- Icebound Fortitude https://www.wowhead.com/wotlk/ru/spell=48792
		[47568]		= 5*60,			-- Empower Rune Weapon https://www.wowhead.com/wotlk/ru/spell=47568
		[47528]		= 10,			-- Mind Freeze https://www.wowhead.com/wotlk/ru/spell=47528
		[42650]		= 6*60,			-- Army of the Dead https://www.wowhead.com/wotlk/ru/spell=42650
		[48707]		= 45,			-- Anti-Magic Shell https://www.wowhead.com/wotlk/ru/spell=48707
		[46584]		= 90,			-- Raise Dead https://www.wowhead.com/wotlk/ru/spell=46584
		[49576]		= 20,			-- Death Grip https://www.wowhead.com/wotlk/ru/spell=49576
		[61999]		= 10*60,		-- Raise Ally https://www.wowhead.com/wotlk/ru/spell=61999
		[49016]		= 3*60,			-- Unholy Frenzy https://www.wowhead.com/wotlk/ru/spell=49016
		[55233]		= 50,			-- Vampiric Blood https://www.wowhead.com/wotlk/ru/spell=55233
		[49028]		= 90,			-- Dancing Rune Weapon https://www.wowhead.com/wotlk/ru/spell=49028
		[49005]		= 3*60,			-- Mark of Blood https://www.wowhead.com/wotlk/ru/spell=49005
		[48982]		= 30,			-- Rune Tap https://www.wowhead.com/wotlk/ru/spell=48982
		[49039]		= 120,			-- Lichborne https://www.wowhead.com/wotlk/ru/spell=49039
		[51271]		= 50,			-- Unbreakable Armor https://www.wowhead.com/wotlk/ru/spell=51271
		[49206]		= 3*60,			-- Summon Gargoyle https://www.wowhead.com/wotlk/ru/spell=49206
		[49222]		= 50,			-- Bone Shield https://www.wowhead.com/wotlk/ru/spell=49222
		[51052]		= 120,			-- Anti-Magic Zone https://www.wowhead.com/wotlk/ru/spell=51052
	},
	["DRUID"] = {
		-- // reviewed 2022/10/27
		[22570] = 10,							-- Maim https://www.wowhead.com/wotlk/ru/spell=22570
		[29166] = 132,							-- Innervate https://www.wowhead.com/wotlk/ru/spell=29166
		[22812] = 48,							-- Barkskin https://www.wowhead.com/wotlk/ru/spell=22812
		[22842] = 3*60,							-- Frenzied Regeneration https://www.wowhead.com/wotlk/ru/spell=22842
		[5229] = 60,							-- Enrage https://www.wowhead.com/wotlk/ru/spell=5229
		[5217] = 27,							-- Tiger's Fury 1 https://www.wowhead.com/wotlk/ru/spell=5217
		[6793] = 27,							-- Tiger's Fury 2 https://www.wowhead.com/wotlk/ru/spell=6793
		[9845] = 27,							-- Tiger's Fury 3 https://www.wowhead.com/wotlk/ru/spell=9845
		[9846] = 27,							-- Tiger's Fury 4 https://www.wowhead.com/wotlk/ru/spell=9846
		[50212] = 27,							-- Tiger's Fury 5 https://www.wowhead.com/wotlk/ru/spell=50212
		[50213] = 27,							-- Tiger's Fury 6 https://www.wowhead.com/wotlk/ru/spell=50213
		[49376] = 30,							-- Feral Charge - Cat https://www.wowhead.com/wotlk/ru/spell=49376
		[5211] = 30,							-- Bash https://www.wowhead.com/wotlk/ru/spell=5211
		[6798] = 30,							-- Bash https://www.wowhead.com/wotlk/ru/spell=6798
		[8983] = 30,							-- Bash https://www.wowhead.com/wotlk/ru/spell=8983
		[16979] = 15,							-- Feral Charge - Bear https://www.wowhead.com/wotlk/ru/spell=16979
		[1850] = 144,							-- Dash 1 https://www.wowhead.com/wotlk/ru/spell=1850
		[9821] = 144,							-- Dash 2 https://www.wowhead.com/wotlk/ru/spell=9821
		[33357] = 144,							-- Dash 3 https://www.wowhead.com/wotlk/ru/spell=33357
		[20484] = 5*60,							-- Rebirth 1 https://www.wowhead.com/wotlk/ru/spell=20484
		[20739] = 5*60,							-- Rebirth 2 https://www.wowhead.com/wotlk/ru/spell=20739
		[20742] = 5*60,							-- Rebirth 3 https://www.wowhead.com/wotlk/ru/spell=20742
		[20747] = 5*60,							-- Rebirth 4 https://www.wowhead.com/wotlk/ru/spell=20747
		[20748] = 5*60,							-- Rebirth 5 https://www.wowhead.com/wotlk/ru/spell=20748
		[26994] = 5*60,							-- Rebirth 6 https://www.wowhead.com/wotlk/ru/spell=26994
		[48477] = 5*60,							-- Rebirth 7 https://www.wowhead.com/wotlk/ru/spell=48477
		[740] = 192,							-- Tranquility 1 https://www.wowhead.com/wotlk/ru/spell=740
		[8918] = 192,							-- Tranquility 2 https://www.wowhead.com/wotlk/ru/spell=8918
		[9862] = 192,							-- Tranquility 3 https://www.wowhead.com/wotlk/ru/spell=9862
		[9863] = 192,							-- Tranquility 4 https://www.wowhead.com/wotlk/ru/spell=9863
		[26983] = 192,							-- Tranquility 5 https://www.wowhead.com/wotlk/ru/spell=26983
		[48446] = 192,							-- Tranquility 6 https://www.wowhead.com/wotlk/ru/spell=48446
		[48447] = 192,							-- Tranquility 7 https://www.wowhead.com/wotlk/ru/spell=48447
		[48505] = 90,							-- Starfall 1 https://www.wowhead.com/wotlk/ru/spell=48505
		[53199] = 90,							-- Starfall 1 https://www.wowhead.com/wotlk/ru/spell=53199
		[53200] = 90,							-- Starfall 1 https://www.wowhead.com/wotlk/ru/spell=53200
		[53201] = 90,							-- Starfall 1 https://www.wowhead.com/wotlk/ru/spell=53201
		[33831] = 180,							-- Force of Nature https://www.wowhead.com/wotlk/ru/spell=33831
		[50516] = 20,							-- Typhoon 1 https://www.wowhead.com/wotlk/ru/spell=50516
		[53223] = 20,							-- Typhoon 2 https://www.wowhead.com/wotlk/ru/spell=53223
		[53225] = 20,							-- Typhoon 3 https://www.wowhead.com/wotlk/ru/spell=53225
		[53226] = 20,							-- Typhoon 4 https://www.wowhead.com/wotlk/ru/spell=53226
		[61384] = 20,							-- Typhoon 5 https://www.wowhead.com/wotlk/ru/spell=61384
		[50334] = 180,							-- Berserk https://www.wowhead.com/wotlk/ru/spell=50334
		[61336] = 180,							-- Survival Instincts https://www.wowhead.com/wotlk/ru/spell=61336
		[17116] = 156,							-- Nature's Swiftness https://www.wowhead.com/wotlk/ru/spell=17116
	},
	["PALADIN"] = {
		-- // reviewed 2022/10/28
		[54428] = 60,					-- Divine Plea https://www.wowhead.com/wotlk/spell=54428
		[2812] = 30,					-- Holy Wrath 1 https://www.wowhead.com/wotlk/spell=2812
		[10318] = 30,					-- Holy Wrath 2 https://www.wowhead.com/wotlk/spell=10318
		[27139] = 30,					-- Holy Wrath 3 https://www.wowhead.com/wotlk/spell=27139
		[48816] = 30,					-- Holy Wrath 4 https://www.wowhead.com/wotlk/spell=48816
		[48817] = 30,					-- Holy Wrath 5 https://www.wowhead.com/wotlk/spell=48817
		[633] = 11*60,					-- Lay on Hands 1 https://www.wowhead.com/wotlk/spell=633
		[2800] = 11*60,					-- Lay on Hands 2 https://www.wowhead.com/wotlk/spell=2800
		[10310] = 11*60,				-- Lay on Hands 3 https://www.wowhead.com/wotlk/spell=10310
		[27154] = 11*60,				-- Lay on Hands 4 https://www.wowhead.com/wotlk/spell=27154
		[48788] = 11*60,				-- Lay on Hands 5 https://www.wowhead.com/wotlk/spell=48788
		[6940] = 2*60,					-- Hand of Sacrifice https://www.wowhead.com/wotlk/spell=6940
		[498] = 2*60,					-- Divine Protection https://www.wowhead.com/wotlk/spell=498
		[642] = 4*60,					-- Divine Shield https://www.wowhead.com/wotlk/spell=642
		[853] = 30,						-- Hammer of Justice 1 https://www.wowhead.com/wotlk/spell=853
		[5588] = 30,					-- Hammer of Justice 2 https://www.wowhead.com/wotlk/spell=5588
		[5589] = 30,					-- Hammer of Justice 3 https://www.wowhead.com/wotlk/spell=5589
		[10308] = 30,					-- Hammer of Justice 4 https://www.wowhead.com/wotlk/spell=10308
		[1044] = 25,					-- Hand of Freedom https://www.wowhead.com/wotlk/spell=1044
		[1022] = 3*60,					-- Hand of Protection 1 https://www.wowhead.com/wotlk/spell=1022
		[5599] = 3*60,					-- Hand of Protection 2 https://www.wowhead.com/wotlk/spell=5599
		[10278] = 3*60,					-- Hand of Protection 3 https://www.wowhead.com/wotlk/spell=10278
		[31884] = 3*60,					-- Avenging Wrath https://www.wowhead.com/wotlk/spell=31884
		[31821] = 2*60,					-- Aura Mastery https://www.wowhead.com/wotlk/spell=31821
		[31842] = 3*60,					-- Divine Illumination https://www.wowhead.com/wotlk/spell=31842
		[20216] = 105,					-- Divine Favor https://www.wowhead.com/wotlk/spell=20216
		[64205] = 120,					-- Divine Sacrifice https://www.wowhead.com/wotlk/spell=64205
		[20066] = 60,					-- Repentance https://www.wowhead.com/wotlk/spell=20066
	},
	["PRIEST"] = {
		-- // reviewed 2022/10/29
		[6346] = 2*60,		-- Fear Ward https://www.wowhead.com/wotlk/spell=6346
		[64901] = 6*60,		-- Hymn of Hope https://www.wowhead.com/wotlk/spell=64901
		[64843] = 8*60,		-- Divine Hymn https://www.wowhead.com/wotlk/spell=64843
		[34433] = 3*60,		-- Shadowfiend https://www.wowhead.com/wotlk/spell=34433
		[586] = 15,			-- Fade https://www.wowhead.com/wotlk/spell=586
		[8122] = 26,		-- Psychic Scream 1 https://www.wowhead.com/wotlk/spell=8122
		[8124] = 26,		-- Psychic Scream 2 https://www.wowhead.com/wotlk/spell=8124
		[10888] = 26,		-- Psychic Scream 3 https://www.wowhead.com/wotlk/spell=10888
		[10890] = 26,		-- Psychic Scream 4 https://www.wowhead.com/wotlk/spell=10890
		[10060] = 96,		-- Power Infusion https://www.wowhead.com/wotlk/spell=10060
		[33206] = 144,		-- Pain Suppression https://www.wowhead.com/wotlk/spell=33206
		[14751] = 144,		-- Inner Focus https://www.wowhead.com/wotlk/spell=14751
		[47788] = 3*60,		-- Guardian Spirit https://www.wowhead.com/wotlk/spell=47788
		[724] = 3*60,		-- Lightwell 1 https://www.wowhead.com/wotlk/spell=724
		[27870] = 3*60,		-- Lightwell 2 https://www.wowhead.com/wotlk/spell=27870
		[27871] = 3*60,		-- Lightwell 3 https://www.wowhead.com/wotlk/spell=27871
		[28275] = 3*60,		-- Lightwell 4 https://www.wowhead.com/wotlk/spell=28275
		[48086] = 3*60,		-- Lightwell 5 https://www.wowhead.com/wotlk/spell=48086
		[48087] = 3*60,		-- Lightwell 6 https://www.wowhead.com/wotlk/spell=48087
		[47585] = 75,		-- Dispersion https://www.wowhead.com/wotlk/spell=47585
		[64044] = 120,		-- Psychic Horror https://www.wowhead.com/wotlk/spell=64044
		[15487] = 45,		-- Silence https://www.wowhead.com/wotlk/spell=15487
		[19236] = 120,		-- Desperate Prayer 1 https://www.wowhead.com/wotlk/spell=19236
		[19238] = 120,		-- Desperate Prayer 1 https://www.wowhead.com/wotlk/spell=19238
		[19240] = 120,		-- Desperate Prayer 1 https://www.wowhead.com/wotlk/spell=19240
		[19241] = 120,		-- Desperate Prayer 1 https://www.wowhead.com/wotlk/spell=19241
		[19242] = 120,		-- Desperate Prayer 1 https://www.wowhead.com/wotlk/spell=19242
		[19243] = 120,		-- Desperate Prayer 1 https://www.wowhead.com/wotlk/spell=19243
		[25437] = 120,		-- Desperate Prayer 1 https://www.wowhead.com/wotlk/spell=25437
		[48172] = 120,		-- Desperate Prayer 1 https://www.wowhead.com/wotlk/spell=48172
		[48173] = 120,		-- Desperate Prayer 1 https://www.wowhead.com/wotlk/spell=48173
	},
	["ROGUE"] = {
		-- // reviewed 2022/11/20
		[31228] = 60,				-- Cheat Death https://www.wowhead.com/wotlk/spell=31228/cheat-death
		[31229] = 60,				-- Cheat Death https://www.wowhead.com/wotlk/spell=31229/cheat-death
		[31230] = 60,				-- Cheat Death https://www.wowhead.com/wotlk/spell=31230/cheat-death
		[51722] = 60,				-- Dismantle https://www.wowhead.com/wotlk/spell=51722
		[31224] = 60,				-- Cloak of Shadows https://www.wowhead.com/wotlk/spell=31224
		[2094] = 120,				-- Blind https://www.wowhead.com/wotlk/spell=2094
		[1776] = 9,					-- Gouge https://www.wowhead.com/wotlk/spell=1776
		[1766] = 9.5,				-- Kick https://www.wowhead.com/wotlk/spell=1766
		[1856] = 90,				-- Vanish 1 https://www.wowhead.com/wotlk/spell=1856
		[1857] = 90,				-- Vanish 2 https://www.wowhead.com/wotlk/spell=1857
		[26889] = 90,				-- Vanish 3 https://www.wowhead.com/wotlk/spell=26889
		[408] = 20,					-- Kidney Shot 1 https://www.wowhead.com/wotlk/spell=408
		[8643] = 20,				-- Kidney Shot 2 https://www.wowhead.com/wotlk/spell=8643
		[5277] = 120,				-- Evasion 1 https://www.wowhead.com/wotlk/spell=5277
		[26669] = 120,				-- Evasion 2 https://www.wowhead.com/wotlk/spell=26669
		[2983] = 120,				-- Sprint 1 https://www.wowhead.com/wotlk/spell=2983
		[8696] = 120,				-- Sprint 2 https://www.wowhead.com/wotlk/spell=8696
		[11305] = 120,				-- Sprint 3 https://www.wowhead.com/wotlk/spell=11305
		[51690] = 120,				-- Killing Spree https://www.wowhead.com/wotlk/spell=51690
		[13877] = 120,				-- Blade Flurry https://www.wowhead.com/wotlk/spell=13877
		[51713] = 60,				-- Shadow Dance https://www.wowhead.com/wotlk/spell=51713
		[14177] = 180,				-- Cold Blood https://www.wowhead.com/wotlk/spell=14177
		[13750] = 180,				-- Adrenaline Rush https://www.wowhead.com/wotlk/spell=13750
		[36554] = 20,				-- Shadowstep https://www.wowhead.com/wotlk/spell=36554
		[14185] = 5*60,				-- Preparation https://www.wowhead.com/wotlk/spell=14185
		[14183] = 20,				-- Premeditation https://www.wowhead.com/wotlk/spell=14183
	},
	["SHAMAN"] = {
		-- // reviewed 2021/02/17
		[57994] = 6,		-- Wind Shear https://www.wowhead.com/wotlk/ru/spell=57994
		[51490] = 45,		-- Thunderstorm https://www.wowhead.com/wotlk/ru/spell=51490
		[32182] = 300,		-- Heroism https://www.wowhead.com/wotlk/ru/spell=32182
		[2825] = 300,		-- Bloodlust https://www.wowhead.com/wotlk/ru/spell=2825
		[51533] = 180,		-- Feral Spirit https://www.wowhead.com/wotlk/ru/spell=51533
		[51514] = 45,		-- Hex https://www.wowhead.com/wotlk/ru/spell=51514
	},
	["WARRIOR"] = {
		-- // reviewed 2021/02/12
		[100] = 15,					-- Charge https://www.wowhead.com/wotlk/ru/spell=100
		[6552] = 10,				-- Pummel https://www.wowhead.com/wotlk/ru/spell=6552
		[23920] = 10,				-- Spell Reflection https://www.wowhead.com/wotlk/ru/spell=23920
		[46924] = 90,				-- Bladestorm https://www.wowhead.com/wotlk/ru/spell=46924
		[46968] = 20,				-- Shockwave https://www.wowhead.com/wotlk/ru/spell=46968
		[5246] = 120,				-- Intimidating Shout https://www.wowhead.com/wotlk/ru/spell=5246
		[871] = 300,				-- Shield Wall https://www.wowhead.com/wotlk/ru/spell=871
		[1719] = 300,				-- Recklessness https://www.wowhead.com/wotlk/ru/spell=1719
		[6544] = 45,				-- Heroic Leap https://www.wowhead.com/wotlk/ru/spell=6544
		[12975] = 180,				-- Last Stand https://www.wowhead.com/wotlk/ru/spell=12975
		[18499] = 30,				-- Berserker Rage https://www.wowhead.com/wotlk/ru/spell=18499
		[3411] = 30,				-- Intervene https://www.wowhead.com/wotlk/ru/spell=3411/intervene
	},
};

addonTable.Interrupts = {
	[47528] = true,		-- // Mind Freeze
	[2139] = true,		-- // Counterspell
	[15487] = true,		-- // Silence https://www.wowhead.com/wotlk/spell=15487
	[1766] = true,		-- // Kick
	[57994] = true,		-- // Wind Shear
	[6552] = true,		-- // Pummel
	[19647] = true,		-- // Spell Lock https://www.wowhead.com/wotlk/ru/spell=19647
	[34490] = true,		-- Silencing Shot https://www.wowhead.com/wotlk/spell=34490
	[47476] = true,		-- Strangulate
	[16979] = true,		-- Feral Charge - Bear
};

addonTable.Trinkets = {
	[59752] = true,
	[7744] = true,
	[42292] = true,
};

-- // spells that reduce cooldown of other spells
do

	local BIG_REDUCTION = 4*1000*1000;

	addonTable.Reductions = {
		-- [275773] = { -- // holy paladin's judgment https://www.wowhead.com/spell=275773/judgment
			-- ["reduction"] = 10,
			-- ["spells"] = { 853 },
		-- },
		-- [275779] = { -- // protection paladin's judgment https://www.wowhead.com/spell=275779/judgment
			-- ["reduction"] = 6,
			-- ["spells"] = { 853 },
		-- },
		[195676] = { -- // Displacement https://www.wowhead.com/wotlk/ru/spell=195676/%D1%81%D0%BC%D0%B5%D1%89%D0%B5%D0%BD%D0%B8%D0%B5
			["reduction"] = BIG_REDUCTION,
			["spells"] = { 1953 }, -- // Blink
		},
		[235219] = { -- // Cold Snap https://www.wowhead.com/wotlk/ru/spell=235219/%D1%85%D0%BE%D0%BB%D0%BE%D0%B4%D0%BD%D0%B0%D1%8F-%D1%85%D0%B2%D0%B0%D1%82%D0%BA%D0%B0
			["reduction"] = BIG_REDUCTION,
			["spells"] = {
				122,			-- // Frost Nova
				120,			-- // Cone of Cold
				11426,			-- // Ice Barrier
				45438,			-- // Ice Block
			},
		},
		[115203] = { -- // Fortifying Brew https://www.wowhead.com/spell=115203/fortifying-brew
			["reduction"] = -120,
			["spells"] = {
				243435,			-- // Fortifying Brew https://www.wowhead.com/spell=243435/fortifying-brew
			},
		},
		[585] = {	-- Кара https://www.wowhead.com/wotlk/ru/spell=585/%D0%BA%D0%B0%D1%80%D0%B0
			["reduction"] = -4,
			["spells"] = {
				88625,	-- Holy Word: Chastise https://www.wowhead.com/wotlk/ru/spell=88625
			},
		},
		[23989] = { -- Readiness https://www.wowhead.com/wotlk/spell=23989
			["reduction"] = BIG_REDUCTION,
			["spells"] = {
				53271,
				19577,
				5384,
				53480,
				34026,
				1513,
				14326,
				14327,
				3045,
				1543,
				19263,
				60192,
				1499,
				14310,
				14311,
				13809,
				34490,
				19503,
			},
		},
		[45438] = { -- Ice Block https://www.wowhead.com/wotlk/ru/spell=45438
			["reduction"] = BIG_REDUCTION,
			["spells"] = {
				122,
				865,
				6131,
				10230,
				27088,
				42917,
			},
		},
		[11958] = { -- Cold Snap https://www.wowhead.com/wotlk/ru/spell=11958
			["reduction"] = BIG_REDUCTION,
			["spells"] = {
				122,
				865,
				6131,
				10230,
				27088,
				42917,
				120,
				8492,
				10159,
				10160,
				10161,
				27087,
				42930,
				42931,
				6143,
				8461,
				8462,
				10177,
				28609,
				32796,
				43012,
				45438,
				12472,
				44572,
			},
		},
		[14185] = { -- Preparation https://www.wowhead.com/wotlk/ru/spell=14185
			["reduction"] = BIG_REDUCTION,
			["spells"] = {
				5277,
				26669,
				2983,
				8696,
				11305,
				1856,
				1857,
				26889,
				14177,
				36554,
			},
		},
	};

end