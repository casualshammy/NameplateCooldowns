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
		-- // reviewed 2021/02/15
		[1850] = 180,							-- Dash https://www.wowhead.com/wotlk/ru/spell=1850
		[20484] = 600,							-- Rebirth https://www.wowhead.com/wotlk/ru/spell=20484
		[22812] = 60,							-- Barkskin https://www.wowhead.com/wotlk/ru/spell=22812
		[50334] = 180,							-- Berserk https://www.wowhead.com/wotlk/ru/spell=50334
		[22570] = 10,							-- Maim https://www.wowhead.com/wotlk/ru/spell=22570
		[61336] = 180,							-- Survival Instincts x2 https://www.wowhead.com/wotlk/ru/spell=61336
		[740] = 480,							-- Tranquility https://www.wowhead.com/wotlk/ru/spell=740
		[5211]	= 60,							-- Mighty Bash https://www.wowhead.com/wotlk/ru/spell=5211
		[22842] = 180,							-- Frenzied Regeneration https://www.wowhead.com/wotlk/ru/spell=22842/frenzied-regeneration
	},
	["PALADIN"] = {
		-- // reviewed 2021/02/12
		[642] = 300,		    		-- Божественный щит https://www.wowhead.com/wotlk/ru/spell=642
		[1044] = 25,					-- Благословенная свобода https://www.wowhead.com/wotlk/ru/spell=1044
		[633] = 1200,					-- Возложение рук https://www.wowhead.com/wotlk/ru/spell=633
		[1022] = 300,					-- Благословение защиты https://www.wowhead.com/wotlk/ru/spell=1022
		[31821] = 120,					-- Владение аурами https://www.wowhead.com/wotlk/ru/spell=31821
		[498] = 180,					-- Божественная защита https://www.wowhead.com/wotlk/ru/spell=498
		[6940] = 120,					-- Жертвенное благословение https://www.wowhead.com/wotlk/ru/spell=6940
		[853] = 60,						-- Молот правосудия https://www.wowhead.com/wotlk/ru/spell=853
		[31884] = 180,					-- Гнев карателя https://www.wowhead.com/wotlk/ru/spell=31884
	},
	["PRIEST"] = {
		-- // reviewed 2021/02/16
		[64044] = 120,		-- Psychic Horror https://www.wowhead.com/wotlk/ru/spell=64044
		[8122] = 30,		-- Psychic Scream [-30sec] https://www.wowhead.com/wotlk/ru/spell=8122
		[15487] = 45,		-- Silence https://www.wowhead.com/wotlk/ru/spell=15487
		[47585] = 120,		-- Dispersion https://www.wowhead.com/wotlk/ru/spell=47585
		[33206] = 180,		-- Pain Suppression [-30sec] https://www.wowhead.com/wotlk/ru/spell=33206
		[10060] = 120,		-- Power Infusion https://www.wowhead.com/wotlk/ru/spell=10060
		[64843] = 480,		-- Divine Hymn https://www.wowhead.com/wotlk/ru/spell=64843
		[19236] = 120,		-- Desperate Prayer https://www.wowhead.com/wotlk/ru/spell=19236
		[47788] = 180,		-- Guardian Spirit [-60%] [max=120sec] https://www.wowhead.com/wotlk/ru/spell=47788
		[32379] = 12,		-- Shadow Word: Death https://www.wowhead.com/wotlk/ru/spell=32379
	},
	["ROGUE"] = {
		-- // reviewed 2021/02/16
		[2094] = 180,				-- Blind https://www.wowhead.com/wotlk/ru/spell=2094
		[1766] = 10,				-- Kick https://www.wowhead.com/wotlk/ru/spell=1766
		[31224] = 90,				-- Cloak of Shadows https://www.wowhead.com/wotlk/ru/spell=31224
		[1856] = 180,				-- Vanish https://www.wowhead.com/wotlk/ru/spell=1856
		[2983] = 180,				-- Sprint" [-9sec] https://www.wowhead.com/wotlk/ru/spell=2983
		[36554] = 30,				-- Shadowstep https://www.wowhead.com/wotlk/ru/spell=36554
		[5277] = 180,				-- Evasion https://www.wowhead.com/wotlk/ru/spell=5277
		[51690] = 120,				-- Killing Spree https://www.wowhead.com/wotlk/ru/spell=51690
		[13750] = 180,				-- Adrenaline Rush [-30sec] https://www.wowhead.com/wotlk/ru/spell=13750
		[408] = 20,					-- Kidney Shot https://www.wowhead.com/wotlk/ru/spell=408/kidney-shot
		[1776] = 10,				-- Gouge https://www.wowhead.com/wotlk/ru/spell=1776/gouge
		[31228] = 60,				-- Cheat Death https://www.wowhead.com/wotlk/spell=31228/cheat-death
		[31229] = 60,				-- Cheat Death https://www.wowhead.com/wotlk/spell=31229/cheat-death
		[31230] = 60,				-- Cheat Death https://www.wowhead.com/wotlk/spell=31230/cheat-death
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
	[15487] = true,		-- // Silence
	[1766] = true,		-- // Kick
	[57994] = true,		-- // Wind Shear
	[6552] = true,		-- // Pummel
	[19647] = true,		-- // Spell Lock https://www.wowhead.com/wotlk/ru/spell=19647
	[34490] = true,		-- Silencing Shot https://www.wowhead.com/wotlk/spell=34490
	[47476] = true,		-- Strangulate
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
		}
	};

end