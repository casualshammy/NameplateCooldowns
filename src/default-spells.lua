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
		-- // reviewed 2024/05/25
		[53271] = 45, 	-- https://www.wowhead.com/wotlk/ru/spell=53271
		[3045] = 180, 	-- https://www.wowhead.com/wotlk/ru/spell=3045
		[1543] = 20, 		-- https://www.wowhead.com/wotlk/ru/spell=1543
		[13813] = 24, 	-- https://www.wowhead.com/wotlk/ru/spell=13813
		[82939] = 24, 	-- https://www.wowhead.com/wotlk/ru/spell=82939
		[13809] = 24, 	-- https://www.wowhead.com/wotlk/ru/spell=13809
		[82941] = 24, 	-- https://www.wowhead.com/wotlk/ru/spell=82941
		[13795] = 24, 	-- https://www.wowhead.com/wotlk/ru/spell=13795
		[82945] = 24, 	-- https://www.wowhead.com/wotlk/ru/spell=82945
		[34600] = 24, 	-- https://www.wowhead.com/wotlk/ru/spell=34600
		[82948] = 24, 	-- https://www.wowhead.com/wotlk/ru/spell=82948
		[1499] = 24, 		-- https://www.wowhead.com/wotlk/ru/spell=1499
		[60192] = 24, 	-- https://www.wowhead.com/wotlk/ru/spell=60192
		[19263] = 110, 	-- https://www.wowhead.com/wotlk/ru/spell=19263
		[781] = 16, 		-- https://www.wowhead.com/wotlk/ru/spell=781
		[5384] = 25, 		-- https://www.wowhead.com/wotlk/ru/spell=5384
		[19574] = 64, 	-- https://www.wowhead.com/wotlk/ru/spell=19574
		[82726] = 120, 	-- https://www.wowhead.com/wotlk/ru/spell=82726
		[34490] = 20, 	-- https://www.wowhead.com/wotlk/ru/spell=34490
		[23989] = 180, 	-- https://www.wowhead.com/wotlk/ru/spell=23989
		[19386] = 54, 	-- https://www.wowhead.com/wotlk/ru/spell=19386
		[19577] = 40,		-- https://www.wowhead.com/wotlk/ru/spell=19577
		[53480] = 40, 	-- https://www.wowhead.com/wotlk/ru/spell=53480
		[19503] = 30, 	-- https://www.wowhead.com/wotlk/ru/spell=19503
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
		[30283] = 20,		-- Shadowfury 1 https://www.wowhead.com/wotlk/ru/spell=30283
		[30413] = 20,		-- Shadowfury 2 https://www.wowhead.com/wotlk/ru/spell=30413
		[30414] = 20,		-- Shadowfury 3 https://www.wowhead.com/wotlk/ru/spell=30414
		[47846] = 20,		-- Shadowfury 4 https://www.wowhead.com/wotlk/ru/spell=47846
		[47847] = 20,		-- Shadowfury 5 https://www.wowhead.com/wotlk/ru/spell=47847
		[19647] = 24,		-- Spell Lock https://www.wowhead.com/wotlk/ru/spell=19647
		[1122] = 600,		-- Summon Infernal https://www.wowhead.com/wotlk/ru/spell=1122
		[54785] = 45,		-- Demon Charge https://www.wowhead.com/wotlk/ru/spell=54785
		[47193] = 60,		-- Demonic Empowerment https://www.wowhead.com/wotlk/ru/spell=47193
		[59672] = 3*60,		-- Metamorphosis https://www.wowhead.com/wotlk/ru/spell=59672
		[18708] = 2*60,		-- Fel Domination https://www.wowhead.com/wotlk/ru/spell=18708
	},
	["MAGE"] = {
		-- // reviewed 2024/05/25
		[80353] = 300, -- https://www.wowhead.com/wotlk/ru/spell=80353
		[1463] = 10, -- https://www.wowhead.com/wotlk/ru/spell=1463
		[55342] = 180, -- https://www.wowhead.com/wotlk/ru/spell=55342
		[543] = 30, -- https://www.wowhead.com/wotlk/ru/spell=543
		[2139] = 22, -- https://www.wowhead.com/wotlk/ru/spell=2139
		[12051] = 120, -- https://www.wowhead.com/wotlk/ru/spell=12051
		[1953] = 13, -- https://www.wowhead.com/wotlk/ru/spell=1953
		[66] = 135, -- https://www.wowhead.com/wotlk/ru/spell=66
		[82731] = 60, -- https://www.wowhead.com/wotlk/ru/spell=82731
		[82676] = 120, -- https://www.wowhead.com/wotlk/ru/spell=82676
		[45438] = 200, -- https://www.wowhead.com/wotlk/ru/spell=45438
		[122] = 20, -- https://www.wowhead.com/wotlk/ru/spell=122
		[120] = 8, -- https://www.wowhead.com/wotlk/ru/spell=120
		[12042] = 90, -- https://www.wowhead.com/wotlk/ru/spell=12042
		[12043] = 90, -- https://www.wowhead.com/wotlk/ru/spell=12043
		[11129] = 120, -- https://www.wowhead.com/wotlk/ru/spell=11129
		[31661] = 17, -- https://www.wowhead.com/wotlk/ru/spell=31661
		[12472] = 144, -- https://www.wowhead.com/wotlk/ru/spell=12472
		[44572] = 30, -- https://www.wowhead.com/wotlk/ru/spell=44572
		[11958] = 288, -- https://www.wowhead.com/wotlk/ru/spell=11958
		[11426] = 18, -- https://www.wowhead.com/wotlk/ru/spell=11426
	},
	["DEATHKNIGHT"] = {
		-- // reviewed 2024/05/23
		[77606]	= 60,		-- https://www.wowhead.com/wotlk/ru/spell=77606
		[45529]	= 30,		-- https://www.wowhead.com/wotlk/ru/spell=45529
		[48743]	= 120,	-- https://www.wowhead.com/wotlk/ru/spell=48743
		[47476]	= 60,		-- https://www.wowhead.com/wotlk/ru/spell=47476
		[48792]	= 180,	-- https://www.wowhead.com/wotlk/ru/spell=48792
		[47528]	= 10,		-- https://www.wowhead.com/wotlk/ru/spell=47528
		[48707]	= 45,		-- https://www.wowhead.com/wotlk/ru/spell=48707
		[49576]	= 20,		-- https://www.wowhead.com/wotlk/ru/spell=49576
		[42650]	= 600,	-- https://www.wowhead.com/wotlk/ru/spell=42650
		[46584]	= 120,	-- https://www.wowhead.com/wotlk/ru/spell=46584
		[49222]	= 60,		-- https://www.wowhead.com/wotlk/ru/spell=49222
		[49028]	= 90,		-- https://www.wowhead.com/wotlk/ru/spell=49028
		[55233]	= 60,		-- https://www.wowhead.com/wotlk/ru/spell=55233
		[49039]	= 120,	-- https://www.wowhead.com/wotlk/ru/spell=49039
		[49203]	= 60,		-- https://www.wowhead.com/wotlk/ru/spell=49203
		[51271]	= 60,		-- https://www.wowhead.com/wotlk/ru/spell=51271
		[49016]	= 180,	-- https://www.wowhead.com/wotlk/ru/spell=49016
		[49206]	= 180,	-- https://www.wowhead.com/wotlk/ru/spell=49206
		[51052]	= 120,	-- https://www.wowhead.com/wotlk/ru/spell=51052
		[47568]	= 300,	-- https://www.wowhead.com/wotlk/ru/spell=47568
		[61999]	= 600,	-- https://www.wowhead.com/wotlk/ru/spell=61999
		[48982]	= 30,		-- https://www.wowhead.com/wotlk/ru/spell=48982
		[47481]	= 60,		-- https://www.wowhead.com/wotlk/ru/spell=47481
	},
	["DRUID"] = {
		-- // reviewed 2024/05/23
		[29166]	= 132,	-- https://www.wowhead.com/wotlk/ru/spell=29166
		[22812]	= 60,		-- https://www.wowhead.com/wotlk/ru/spell=22812
		[16689]	= 60,		-- https://www.wowhead.com/wotlk/ru/spell=16689
		[77764]	= 120,	-- https://www.wowhead.com/wotlk/ru/spell=77764
		[16979]	= 14,		-- https://www.wowhead.com/wotlk/ru/spell=16979
		[80965]	= 10,		-- https://www.wowhead.com/wotlk/ru/spell=80965
		[5217]	= 27,		-- https://www.wowhead.com/wotlk/ru/spell=5217
		[49376]	= 28,		-- https://www.wowhead.com/wotlk/ru/spell=49376
		[80964]	= 10,		-- https://www.wowhead.com/wotlk/ru/spell=80964
		[22842]	= 180,	-- https://www.wowhead.com/wotlk/ru/spell=22842
		[1850]	= 144,	-- https://www.wowhead.com/wotlk/ru/spell=1850
		[77761]	= 120,	-- https://www.wowhead.com/wotlk/ru/spell=77761
		[5211]	= 50,		-- https://www.wowhead.com/wotlk/ru/spell=5211
		[5229]	= 60,		-- https://www.wowhead.com/wotlk/ru/spell=5229
		[20484]	= 300,	-- https://www.wowhead.com/wotlk/ru/spell=20484
		[740]	= 180,		-- https://www.wowhead.com/wotlk/ru/spell=740
		[48505]	= 60,		-- https://www.wowhead.com/wotlk/ru/spell=48505
		[50516]	= 17,		-- https://www.wowhead.com/wotlk/ru/spell=50516
		[78675]	= 60,		-- https://www.wowhead.com/wotlk/ru/spell=78675
		[33831]	= 180,	-- https://www.wowhead.com/wotlk/ru/spell=33831
		[50334]	= 180,	-- https://www.wowhead.com/wotlk/ru/spell=50334
		[61336]	= 180,	-- https://www.wowhead.com/wotlk/ru/spell=61336
		[33891]	= 180,	-- https://www.wowhead.com/wotlk/ru/spell=33891
		[17116]	= 156,	-- https://www.wowhead.com/wotlk/ru/spell=17116
		[22570] = 10,		-- https://www.wowhead.com/wotlk/ru/spell=22570
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
		[20473] = 5,					-- Holy Shock 1 https://www.wowhead.com/wotlk/spell=20473
		[20929] = 5,					-- Holy Shock 2 https://www.wowhead.com/wotlk/spell=20929
		[20930] = 5,					-- Holy Shock 3 https://www.wowhead.com/wotlk/spell=20930
		[27174] = 5,					-- Holy Shock 4 https://www.wowhead.com/wotlk/spell=27174
		[33072] = 5,					-- Holy Shock 5 https://www.wowhead.com/wotlk/spell=33072
		[48824] = 5,					-- Holy Shock 6 https://www.wowhead.com/wotlk/spell=48824
		[48825] = 5,					-- Holy Shock 7 https://www.wowhead.com/wotlk/spell=48825
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
		[2825] = 5*60,		-- Bloodlust https://www.wowhead.com/wotlk/spell=2825
		[32182] = 5*60,		-- Heroism https://www.wowhead.com/wotlk/spell=32182
		[57994] = 5,		-- Wind Shear https://www.wowhead.com/wotlk/spell=57994
		[2894] = 5*60,		-- Fire Elemental Totem https://www.wowhead.com/wotlk/spell=2894
		[2062] = 5*60,		-- Earth Elemental Totem https://www.wowhead.com/wotlk/spell=2062
		[51514] = 45,		-- Hex https://www.wowhead.com/wotlk/spell=51514
		[2484] = 15,		-- Earthbind Totem https://www.wowhead.com/wotlk/spell=2484
		[8177] = 13.5,		-- Grounding Totem https://www.wowhead.com/wotlk/spell=8177
		[51533] = 3*60,		-- Feral Spirit https://www.wowhead.com/wotlk/spell=51533
		[16166] = 150,		-- Elemental Mastery https://www.wowhead.com/wotlk/spell=16166
		[51490] = 35,		-- Thunderstorm 1 https://www.wowhead.com/wotlk/spell=51490
		[59156] = 35,		-- Thunderstorm 2 https://www.wowhead.com/wotlk/spell=59156
		[59158] = 35,		-- Thunderstorm 3 https://www.wowhead.com/wotlk/spell=59158
		[59159] = 35,		-- Thunderstorm 4 https://www.wowhead.com/wotlk/spell=59159
		[16190] = 5*60,		-- Mana Tide Totem https://www.wowhead.com/wotlk/spell=16190
		[30823] = 60,		-- Shamanistic Rage https://www.wowhead.com/wotlk/spell=30823
		[16188] = 96,		-- Nature's Swiftness https://www.wowhead.com/wotlk/spell=16188
	},
	["WARRIOR"] = {
		-- // reviewed 2021/02/12
		[64382] = 5*60,				-- Shattering Throw https://www.wowhead.com/wotlk/ru/spell=64382
		[1719] = 201,				-- Recklessness https://www.wowhead.com/wotlk/ru/spell=1719
		[871] = 120,				-- Shield Wall https://www.wowhead.com/wotlk/ru/spell=871
		[57755] = 60,				-- Heroic Throw https://www.wowhead.com/wotlk/ru/spell=57755
		[55694] = 3*60,				-- Enraged Regeneration https://www.wowhead.com/wotlk/ru/spell=55694
		[2565] = 40,				-- Shield Block https://www.wowhead.com/wotlk/ru/spell=2565
		[3411] = 30,				-- Intervene https://www.wowhead.com/wotlk/ru/spell=3411
		[20230] = 4*60,				-- Retaliation https://www.wowhead.com/wotlk/ru/spell=20230
		[18499] = 20,				-- Berserker Rage https://www.wowhead.com/wotlk/ru/spell=18499
		[2687] = 40,				-- Bloodrage https://www.wowhead.com/wotlk/ru/spell=2687
		[23920] = 9,				-- Spell Reflection https://www.wowhead.com/wotlk/ru/spell=23920
		[6552] = 10,				-- Pummel https://www.wowhead.com/wotlk/ru/spell=6552
		[100] = 15,					-- Charge https://www.wowhead.com/wotlk/ru/spell=100
		[11578] = 15,				-- Charge https://www.wowhead.com/wotlk/ru/spell=11578
		[20252] = 20,				-- Intercept https://www.wowhead.com/wotlk/ru/spell=20252
		[676] = 40,					-- Disarm https://www.wowhead.com/wotlk/ru/spell=676
		[72] = 12,					-- Shield Bash https://www.wowhead.com/wotlk/ru/spell=72
		[1161] = 120,				-- Challenging Shout https://www.wowhead.com/wotlk/ru/spell=1161
		[5246] = 105,				-- Intimidating Shout https://www.wowhead.com/wotlk/ru/spell=5246
		[46924] = 75,				-- Bladestorm https://www.wowhead.com/wotlk/ru/spell=46924
		[46968] = 17,				-- Shockwave https://www.wowhead.com/wotlk/ru/spell=46968
		[12292] = 120,				-- Death Wish https://www.wowhead.com/wotlk/ru/spell=12292
		[60970] = 45,				-- Heroic Fury https://www.wowhead.com/wotlk/ru/spell=60970
		[12975] = 120,				-- Last Stand https://www.wowhead.com/wotlk/ru/spell=12975
		[12809] = 30,				-- Concussion Blow https://www.wowhead.com/wotlk/ru/spell=12809
		[6544] = 45,				-- Heroic Leap https://www.wowhead.com/wotlk/ru/spell=6544
	},
};

addonTable.Interrupts = {
	[47528] = true,		-- // Mind Freeze
	[2139] = true,		-- // Counterspell
	[15487] = true,		-- // Silence https://www.wowhead.com/wotlk/spell=15487
	[1766] = true,		-- // Kick
	[57994] = true,		-- // Wind Shear
	[6552] = true,		-- // Pummel
	[72] = true,		-- Shield Bash https://www.wowhead.com/wotlk/ru/spell=72
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

	local allHunterSpells = {};
	for spellId in pairs(addonTable.CDs["HUNTER"]) do
		table.insert(allHunterSpells, spellId);
	end

	local allMageSpells = {};
	for spellId in pairs(addonTable.CDs["MAGE"]) do
		table.insert(allMageSpells, spellId);
	end

	addonTable.Reductions = {
		[23989] = { -- Readiness https://www.wowhead.com/wotlk/spell=23989
			["reduction"] = BIG_REDUCTION,
			["spells"] = allHunterSpells,
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
			["spells"] = allMageSpells,
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