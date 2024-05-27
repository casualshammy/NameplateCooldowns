-- luacheck: no max line length
-- luacheck: globals GetBuildInfo LibStub GetSpellInfo

local _, addonTable = ...;

addonTable.HUNTER_FEIGN_DEATH = 5384;
addonTable.SPELL_PVPTRINKET = 42292;

addonTable.CDs = {
	[addonTable.UNKNOWN_CLASS] = {
		-- // reviewed 2021/02/08
		[42292] = 120,		-- // PvP-аксессуар https://www.wowhead.com/cata/ru/spell=42292
		[28730] = 120,		-- // Arcane Torrent https://www.wowhead.com/cata/ru/spell=28730
		[50613] = 120,		-- // Arcane Torrent https://www.wowhead.com/cata/ru/spell=50613
		[25046] = 120,		-- // Arcane Torrent https://www.wowhead.com/cata/ru/spell=25046
		[20572] = 120,		-- // Blood Fury https://www.wowhead.com/cata/ru/spell=20572
		[33702] = 120,		-- // Blood Fury https://www.wowhead.com/cata/ru/spell=33702
		[33697] = 120,		-- // Blood Fury https://www.wowhead.com/cata/ru/spell=33697
		[59543] = 180,		-- // Gift of the Naaru https://www.wowhead.com/cata/ru/spell=59543
		[26297] = 180,		-- // Berserking https://www.wowhead.com/cata/ru/spell=26297
		[20594] = 120,		-- // Stoneform https://www.wowhead.com/cata/ru/spell=20594
		[58984] = 120,		-- // Shadowmeld https://www.wowhead.com/cata/ru/spell=58984
		[20589] = 105,		-- // Escape Artist https://www.wowhead.com/cata/ru/spell=20589
		[59752] = 120,		-- // Every Man for Himself https://www.wowhead.com/cata/ru/spell=59752
		[7744] = 120,		-- // Will of the Forsaken https://www.wowhead.com/cata/ru/spell=7744
	},
	["HUNTER"] = {
		-- // reviewed 2024/05/25
		[53271] = 45, 	-- https://www.wowhead.com/cata/ru/spell=53271
		[3045] = 180, 	-- https://www.wowhead.com/cata/ru/spell=3045
		[1543] = 20, 		-- https://www.wowhead.com/cata/ru/spell=1543
		[13813] = 24, 	-- https://www.wowhead.com/cata/ru/spell=13813
		[82939] = 24, 	-- https://www.wowhead.com/cata/ru/spell=82939
		[13809] = 24, 	-- https://www.wowhead.com/cata/ru/spell=13809
		[82941] = 24, 	-- https://www.wowhead.com/cata/ru/spell=82941
		[13795] = 24, 	-- https://www.wowhead.com/cata/ru/spell=13795
		[82945] = 24, 	-- https://www.wowhead.com/cata/ru/spell=82945
		[34600] = 24, 	-- https://www.wowhead.com/cata/ru/spell=34600
		[82948] = 24, 	-- https://www.wowhead.com/cata/ru/spell=82948
		[1499] = 24, 		-- https://www.wowhead.com/cata/ru/spell=1499
		[60192] = 24, 	-- https://www.wowhead.com/cata/ru/spell=60192
		[19263] = 110, 	-- https://www.wowhead.com/cata/ru/spell=19263
		[781] = 16, 		-- https://www.wowhead.com/cata/ru/spell=781
		[5384] = 25, 		-- https://www.wowhead.com/cata/ru/spell=5384
		[19574] = 64, 	-- https://www.wowhead.com/cata/ru/spell=19574
		[82726] = 120, 	-- https://www.wowhead.com/cata/ru/spell=82726
		[34490] = 20, 	-- https://www.wowhead.com/cata/ru/spell=34490
		[23989] = 180, 	-- https://www.wowhead.com/cata/ru/spell=23989
		[19386] = 54, 	-- https://www.wowhead.com/cata/ru/spell=19386
		[19577] = 40,		-- https://www.wowhead.com/cata/ru/spell=19577
		[53480] = 40, 	-- https://www.wowhead.com/cata/ru/spell=53480
		[19503] = 30, 	-- https://www.wowhead.com/cata/ru/spell=19503
	},
	["WARLOCK"] = {
		-- // reviewed 2022/10/18
		[48020] = 26,		-- Demonic Circle: Teleport https://www.wowhead.com/cata/ru/spell=48020
		[6789] = 120,		-- Death Coil 1 https://www.wowhead.com/cata/ru/spell=6789
		[17925] = 120,		-- Death Coil 2 https://www.wowhead.com/cata/ru/spell=17925
		[17926] = 120,		-- Death Coil 3 https://www.wowhead.com/cata/ru/spell=17926
		[27223] = 120,		-- Death Coil 4 https://www.wowhead.com/cata/ru/spell=27223
		[47859] = 120,		-- Death Coil 5 https://www.wowhead.com/cata/ru/spell=47859
		[47860] = 120,		-- Death Coil 6 https://www.wowhead.com/cata/ru/spell=47860
		[5484] = 32,		-- Howl of Terror 1 https://www.wowhead.com/cata/ru/spell=5484
		[17928] = 32,		-- Howl of Terror 2 https://www.wowhead.com/cata/ru/spell=17928
		[30283] = 20,		-- Shadowfury 1 https://www.wowhead.com/cata/ru/spell=30283
		[30413] = 20,		-- Shadowfury 2 https://www.wowhead.com/cata/ru/spell=30413
		[30414] = 20,		-- Shadowfury 3 https://www.wowhead.com/cata/ru/spell=30414
		[47846] = 20,		-- Shadowfury 4 https://www.wowhead.com/cata/ru/spell=47846
		[47847] = 20,		-- Shadowfury 5 https://www.wowhead.com/cata/ru/spell=47847
		[19647] = 24,		-- Spell Lock https://www.wowhead.com/cata/ru/spell=19647
		[1122] = 600,		-- Summon Infernal https://www.wowhead.com/cata/ru/spell=1122
		[54785] = 45,		-- Demon Charge https://www.wowhead.com/cata/ru/spell=54785
		[47193] = 60,		-- Demonic Empowerment https://www.wowhead.com/cata/ru/spell=47193
		[59672] = 3*60,		-- Metamorphosis https://www.wowhead.com/cata/ru/spell=59672
		[18708] = 2*60,		-- Fel Domination https://www.wowhead.com/cata/ru/spell=18708
	},
	["MAGE"] = {
		-- // reviewed 2024/05/25
		[80353] = 300, -- https://www.wowhead.com/cata/ru/spell=80353
		[1463] = 10, -- https://www.wowhead.com/cata/ru/spell=1463
		[55342] = 180, -- https://www.wowhead.com/cata/ru/spell=55342
		[543] = 30, -- https://www.wowhead.com/cata/ru/spell=543
		[2139] = 22, -- https://www.wowhead.com/cata/ru/spell=2139
		[12051] = 120, -- https://www.wowhead.com/cata/ru/spell=12051
		[1953] = 13, -- https://www.wowhead.com/cata/ru/spell=1953
		[66] = 135, -- https://www.wowhead.com/cata/ru/spell=66
		[82731] = 60, -- https://www.wowhead.com/cata/ru/spell=82731
		[82676] = 120, -- https://www.wowhead.com/cata/ru/spell=82676
		[45438] = 200, -- https://www.wowhead.com/cata/ru/spell=45438
		[122] = 20, -- https://www.wowhead.com/cata/ru/spell=122
		[120] = 8, -- https://www.wowhead.com/cata/ru/spell=120
		[12042] = 90, -- https://www.wowhead.com/cata/ru/spell=12042
		[12043] = 90, -- https://www.wowhead.com/cata/ru/spell=12043
		[11129] = 120, -- https://www.wowhead.com/cata/ru/spell=11129
		[31661] = 17, -- https://www.wowhead.com/cata/ru/spell=31661
		[12472] = 144, -- https://www.wowhead.com/cata/ru/spell=12472
		[44572] = 30, -- https://www.wowhead.com/cata/ru/spell=44572
		[11958] = 288, -- https://www.wowhead.com/cata/ru/spell=11958
		[11426] = 18, -- https://www.wowhead.com/cata/ru/spell=11426
	},
	["DEATHKNIGHT"] = {
		-- // reviewed 2024/05/23
		[77606]	= 60,		-- https://www.wowhead.com/cata/ru/spell=77606
		[45529]	= 30,		-- https://www.wowhead.com/cata/ru/spell=45529
		[48743]	= 120,	-- https://www.wowhead.com/cata/ru/spell=48743
		[47476]	= 60,		-- https://www.wowhead.com/cata/ru/spell=47476
		[48792]	= 180,	-- https://www.wowhead.com/cata/ru/spell=48792
		[47528]	= 10,		-- https://www.wowhead.com/cata/ru/spell=47528
		[48707]	= 45,		-- https://www.wowhead.com/cata/ru/spell=48707
		[49576]	= 20,		-- https://www.wowhead.com/cata/ru/spell=49576
		[42650]	= 600,	-- https://www.wowhead.com/cata/ru/spell=42650
		[46584]	= 120,	-- https://www.wowhead.com/cata/ru/spell=46584
		[49222]	= 60,		-- https://www.wowhead.com/cata/ru/spell=49222
		[49028]	= 90,		-- https://www.wowhead.com/cata/ru/spell=49028
		[55233]	= 60,		-- https://www.wowhead.com/cata/ru/spell=55233
		[49039]	= 120,	-- https://www.wowhead.com/cata/ru/spell=49039
		[49203]	= 60,		-- https://www.wowhead.com/cata/ru/spell=49203
		[51271]	= 60,		-- https://www.wowhead.com/cata/ru/spell=51271
		[49016]	= 180,	-- https://www.wowhead.com/cata/ru/spell=49016
		[49206]	= 180,	-- https://www.wowhead.com/cata/ru/spell=49206
		[51052]	= 120,	-- https://www.wowhead.com/cata/ru/spell=51052
		[47568]	= 300,	-- https://www.wowhead.com/cata/ru/spell=47568
		[61999]	= 600,	-- https://www.wowhead.com/cata/ru/spell=61999
		[48982]	= 30,		-- https://www.wowhead.com/cata/ru/spell=48982
		[47481]	= 60,		-- https://www.wowhead.com/cata/ru/spell=47481
	},
	["DRUID"] = {
		-- // reviewed 2024/05/23
		[29166]	= 132,	-- https://www.wowhead.com/cata/ru/spell=29166
		[22812]	= 60,		-- https://www.wowhead.com/cata/ru/spell=22812
		[16689]	= 60,		-- https://www.wowhead.com/cata/ru/spell=16689
		[77764]	= 120,	-- https://www.wowhead.com/cata/ru/spell=77764
		[16979]	= 14,		-- https://www.wowhead.com/cata/ru/spell=16979
		[80965]	= 10,		-- https://www.wowhead.com/cata/ru/spell=80965
		[5217]	= 27,		-- https://www.wowhead.com/cata/ru/spell=5217
		[49376]	= 28,		-- https://www.wowhead.com/cata/ru/spell=49376
		[80964]	= 10,		-- https://www.wowhead.com/cata/ru/spell=80964
		[22842]	= 180,	-- https://www.wowhead.com/cata/ru/spell=22842
		[1850]	= 144,	-- https://www.wowhead.com/cata/ru/spell=1850
		[77761]	= 120,	-- https://www.wowhead.com/cata/ru/spell=77761
		[5211]	= 50,		-- https://www.wowhead.com/cata/ru/spell=5211
		[5229]	= 60,		-- https://www.wowhead.com/cata/ru/spell=5229
		[20484]	= 300,	-- https://www.wowhead.com/cata/ru/spell=20484
		[740]	= 180,		-- https://www.wowhead.com/cata/ru/spell=740
		[48505]	= 60,		-- https://www.wowhead.com/cata/ru/spell=48505
		[50516]	= 17,		-- https://www.wowhead.com/cata/ru/spell=50516
		[78675]	= 60,		-- https://www.wowhead.com/cata/ru/spell=78675
		[33831]	= 180,	-- https://www.wowhead.com/cata/ru/spell=33831
		[50334]	= 180,	-- https://www.wowhead.com/cata/ru/spell=50334
		[61336]	= 180,	-- https://www.wowhead.com/cata/ru/spell=61336
		[33891]	= 180,	-- https://www.wowhead.com/cata/ru/spell=33891
		[17116]	= 156,	-- https://www.wowhead.com/cata/ru/spell=17116
		[22570] = 10,		-- https://www.wowhead.com/cata/ru/spell=22570
	},
	["PALADIN"] = {
		-- // reviewed 2024/05/25
		[85673] = 15, -- https://www.wowhead.com/cata/ru/spell=85673
		[2812] = 15, -- https://www.wowhead.com/cata/ru/spell=2812
		[54428] = 120, -- https://www.wowhead.com/cata/ru/spell=54428
		[26573] = 30, -- https://www.wowhead.com/cata/ru/spell=26573
		[633] = 180, -- https://www.wowhead.com/cata/ru/spell=633
		[86150] = 180, -- https://www.wowhead.com/cata/ru/spell=86150
		[498] = 30, -- https://www.wowhead.com/cata/ru/spell=498
		[6940] = 66, -- https://www.wowhead.com/cata/ru/spell=6940
		[642] = 300, -- https://www.wowhead.com/cata/ru/spell=642
		[1022] = 180, -- https://www.wowhead.com/cata/ru/spell=1022
		[1044] = 20, -- https://www.wowhead.com/cata/ru/spell=1044
		[853] = 30, -- https://www.wowhead.com/cata/ru/spell=853
		[96231] = 10, -- https://www.wowhead.com/cata/ru/spell=96231
		[31884] = 120, -- https://www.wowhead.com/cata/ru/spell=31884
		[31842] = 165, -- https://www.wowhead.com/cata/ru/spell=31842
		[31821] = 120, -- https://www.wowhead.com/cata/ru/spell=31821
		[70940] = 180, -- https://www.wowhead.com/cata/ru/spell=70940
		[31850] = 180, -- https://www.wowhead.com/cata/ru/spell=31850
		[20925] = 30, -- https://www.wowhead.com/cata/ru/spell=20925
		[85696] = 120, -- https://www.wowhead.com/cata/ru/spell=85696
		[20066] = 60, -- https://www.wowhead.com/cata/ru/spell=20066
		[64205] = 120, -- https://www.wowhead.com/cata/ru/spell=64205
		[20473] = 5, -- https://www.wowhead.com/cata/ru/spell=20473
	},
	["PRIEST"] = {
		-- // reviewed 2024/05/25
		[6346] = 120, -- https://www.wowhead.com/cata/ru/spell=6346
		[73325] = 90, -- https://www.wowhead.com/cata/ru/spell=73325
		[64901] = 360, -- https://www.wowhead.com/cata/ru/spell=64901
		[88625] = 20, -- https://www.wowhead.com/cata/ru/spell=88625
		[64843] = 180, -- https://www.wowhead.com/cata/ru/spell=64843
		[32379] = 10, -- https://www.wowhead.com/cata/ru/spell=32379
		[34433] = 240, -- https://www.wowhead.com/cata/ru/spell=34433
		[586] = 15, -- https://www.wowhead.com/cata/ru/spell=586
		[8122] = 25, -- https://www.wowhead.com/cata/ru/spell=8122
		[10060] = 120, -- https://www.wowhead.com/cata/ru/spell=10060
		[62618] = 180, -- https://www.wowhead.com/cata/ru/spell=62618
		[89485] = 45, -- https://www.wowhead.com/cata/ru/spell=89485
		[33206] = 180, -- https://www.wowhead.com/cata/ru/spell=33206
		[14751] = 30, -- https://www.wowhead.com/cata/ru/spell=14751
		[19236] = 120, -- https://www.wowhead.com/cata/ru/spell=19236
		[47788] = 150, -- https://www.wowhead.com/cata/ru/spell=47788
		[47585] = 75, -- https://www.wowhead.com/cata/ru/spell=47585
		[15487] = 45, -- https://www.wowhead.com/cata/ru/spell=15487
		[64044] = 90, -- https://www.wowhead.com/cata/ru/spell=64044
		[724] = 180, -- https://www.wowhead.com/cata/ru/spell=724
	},
	["ROGUE"] = {
		-- // reviewed 2024/05/27
		[408] = 20, -- https://www.wowhead.com/cata/ru/spell=408
		[51722] = 60, -- https://www.wowhead.com/cata/ru/spell=51722
		[74001] = 90, -- https://www.wowhead.com/cata/ru/spell=74001
		[1776] = 9, -- https://www.wowhead.com/cata/ru/spell=1776
		[1766] = 8, -- https://www.wowhead.com/cata/ru/spell=1766
		[2983] = 60, -- https://www.wowhead.com/cata/ru/spell=2983
		[5277] = 180, -- https://www.wowhead.com/cata/ru/spell=5277
		[76577] = 180, -- https://www.wowhead.com/cata/ru/spell=76577
		[31224] = 90, -- https://www.wowhead.com/cata/ru/spell=31224
		[1856] = 90, -- https://www.wowhead.com/cata/ru/spell=1856
		[2094] = 120, -- https://www.wowhead.com/cata/ru/spell=2094
		[73981] = 60, -- https://www.wowhead.com/cata/ru/spell=73981
		[1725] = 20, -- https://www.wowhead.com/cata/ru/spell=1725
		[79140] = 120, -- https://www.wowhead.com/cata/ru/spell=79140
		[14177] = 120, -- https://www.wowhead.com/cata/ru/spell=14177
		[51690] = 120, -- https://www.wowhead.com/cata/ru/spell=51690
		[13750] = 180, -- https://www.wowhead.com/cata/ru/spell=13750
		[51713] = 60, -- https://www.wowhead.com/cata/ru/spell=51713
		[14185] = 120, -- https://www.wowhead.com/cata/ru/spell=14185
		[36554] = 14, -- https://www.wowhead.com/cata/ru/spell=36554
		[31231] = 60, -- https://www.wowhead.com/cata/ru/spell=31231
		[13877] = 10, -- https://www.wowhead.com/cata/ru/spell=13877
		[14183] = 20, -- https://www.wowhead.com/cata/ru/spell=14183
	},
	["SHAMAN"] = {
		-- // reviewed 2024/05/27
		[79206] = 120, -- https://www.wowhead.com/cata/ru/spell=79206
		[2894] = 300, -- https://www.wowhead.com/cata/ru/spell=2894
		[57994] = 5, -- https://www.wowhead.com/cata/ru/spell=57994
		[5730] = 20, -- https://www.wowhead.com/cata/ru/spell=5730
		[51514] = 35, -- https://www.wowhead.com/cata/ru/spell=51514
		[2484] = 15, -- https://www.wowhead.com/cata/ru/spell=2484
		[2825] = 300, -- https://www.wowhead.com/cata/ru/spell=2825
		[32182] = 300, -- https://www.wowhead.com/cata/ru/spell=32182
		[8177] = 22, -- https://www.wowhead.com/cata/ru/spell=8177
		[2062] = 600, -- https://www.wowhead.com/cata/ru/spell=2062
		[8143] = 60, -- https://www.wowhead.com/cata/ru/spell=8143
		[16166] = 180, -- https://www.wowhead.com/cata/ru/spell=16166
		[30823] = 60, -- https://www.wowhead.com/cata/ru/spell=30823
		[51533] = 120, -- https://www.wowhead.com/cata/ru/spell=51533
		[98008] = 180, -- https://www.wowhead.com/cata/ru/spell=98008
		[16190] = 180, -- https://www.wowhead.com/cata/ru/spell=16190
		[16188] = 96, -- https://www.wowhead.com/cata/ru/spell=16188
	},
	["WARRIOR"] = {
		-- // reviewed 2021/02/12
		[64382] = 5*60,				-- Shattering Throw https://www.wowhead.com/cata/ru/spell=64382
		[1719] = 201,				-- Recklessness https://www.wowhead.com/cata/ru/spell=1719
		[871] = 120,				-- Shield Wall https://www.wowhead.com/cata/ru/spell=871
		[57755] = 60,				-- Heroic Throw https://www.wowhead.com/cata/ru/spell=57755
		[55694] = 3*60,				-- Enraged Regeneration https://www.wowhead.com/cata/ru/spell=55694
		[2565] = 40,				-- Shield Block https://www.wowhead.com/cata/ru/spell=2565
		[3411] = 30,				-- Intervene https://www.wowhead.com/cata/ru/spell=3411
		[20230] = 4*60,				-- Retaliation https://www.wowhead.com/cata/ru/spell=20230
		[18499] = 20,				-- Berserker Rage https://www.wowhead.com/cata/ru/spell=18499
		[2687] = 40,				-- Bloodrage https://www.wowhead.com/cata/ru/spell=2687
		[23920] = 9,				-- Spell Reflection https://www.wowhead.com/cata/ru/spell=23920
		[6552] = 10,				-- Pummel https://www.wowhead.com/cata/ru/spell=6552
		[100] = 15,					-- Charge https://www.wowhead.com/cata/ru/spell=100
		[11578] = 15,				-- Charge https://www.wowhead.com/cata/ru/spell=11578
		[20252] = 20,				-- Intercept https://www.wowhead.com/cata/ru/spell=20252
		[676] = 40,					-- Disarm https://www.wowhead.com/cata/ru/spell=676
		[72] = 12,					-- Shield Bash https://www.wowhead.com/cata/ru/spell=72
		[1161] = 120,				-- Challenging Shout https://www.wowhead.com/cata/ru/spell=1161
		[5246] = 105,				-- Intimidating Shout https://www.wowhead.com/cata/ru/spell=5246
		[46924] = 75,				-- Bladestorm https://www.wowhead.com/cata/ru/spell=46924
		[46968] = 17,				-- Shockwave https://www.wowhead.com/cata/ru/spell=46968
		[12292] = 120,				-- Death Wish https://www.wowhead.com/cata/ru/spell=12292
		[60970] = 45,				-- Heroic Fury https://www.wowhead.com/cata/ru/spell=60970
		[12975] = 120,				-- Last Stand https://www.wowhead.com/cata/ru/spell=12975
		[12809] = 30,				-- Concussion Blow https://www.wowhead.com/cata/ru/spell=12809
		[6544] = 45,				-- Heroic Leap https://www.wowhead.com/cata/ru/spell=6544
	},
};

addonTable.Interrupts = {
	[47528] = true,		-- // Mind Freeze
	[2139] = true,		-- // Counterspell
	[15487] = true,		-- // Silence https://www.wowhead.com/cata/spell=15487
	[1766] = true,		-- // Kick
	[57994] = true,		-- // Wind Shear
	[6552] = true,		-- // Pummel
	[72] = true,		-- Shield Bash https://www.wowhead.com/cata/ru/spell=72
	[19647] = true,		-- // Spell Lock https://www.wowhead.com/cata/ru/spell=19647
	[34490] = true,		-- Silencing Shot https://www.wowhead.com/cata/spell=34490
	[47476] = true,		-- Strangulate
	[16979] = true,		-- Feral Charge - Bear
	[96231] = true,		-- Rebuke
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
		[23989] = { -- Readiness https://www.wowhead.com/cata/spell=23989
			["reduction"] = BIG_REDUCTION,
			["spells"] = allHunterSpells,
		},
		-- [45438] = { -- Ice Block https://www.wowhead.com/cata/ru/spell=45438
		-- 	["reduction"] = BIG_REDUCTION,
		-- 	["spells"] = {
		-- 		122,
		-- 		865,
		-- 		6131,
		-- 		10230,
		-- 		27088,
		-- 		42917,
		-- 	},
		-- },
		[11958] = { -- Cold Snap https://www.wowhead.com/cata/ru/spell=11958
			["reduction"] = BIG_REDUCTION,
			["spells"] = allMageSpells,
		},
		[14185] = { -- Preparation https://www.wowhead.com/cata/ru/spell=14185
			["reduction"] = BIG_REDUCTION,
			["spells"] = {
				51722,
				1766,
				2983,
				76577,
				1856,
				36554
			},
		},
	};

end