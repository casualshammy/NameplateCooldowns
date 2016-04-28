local _, addonTable = ...;
local L = addonTable.L;

addonTable.CDs = {
	[L["MISC"]] = {
		[28730] = 120,				--"Arcane Torrent",
		[50613] = 120,				--"Arcane Torrent",
		[80483] = 120,				--"Arcane Torrent",
		[25046] = 120,				--"Arcane Torrent",
		[69179] = 120,				--"Arcane Torrent",
		[20572] = 120,				--"Blood Fury",
		[33702] = 120,				--"Blood Fury",
		[33697] = 120,				--"Blood Fury",
		[59543] = 180,				--"Gift of the Naaru",
		[69070] = 120,				--"Rocket Jump",
		[26297] = 180,				--"Berserking",
		[20594] = 120,				--"Stoneform",
		[58984] = 120,				--"Shadowmeld",
		[20589] = 90,				--"Escape Artist",
		[59752] = 120,				--"Every Man for Himself",
		[7744] = 120,				--"Will of the Forsaken",
		[68992] = 120,				--"Darkflight",
		[50613] = 120,				--"Arcane Torrent",
		[11876] = 120,				--"War Stomp",
		[69041] = 120,				--"Rocket Barrage",
		[42292] = 120,				--"PvP Trinket",
	},
	[L["HUNTER"]] = {
		[19386] = 45,				--"Wyvern Sting",
		[19263] = 180,				--"Deterrence",
		[147362] = 24,				--"Counter Shot"
		[120697] = 90,				--"Lynx Rush",
		[120679] = 30,				--"Dire Beast",
		[109248] = 45,				--"Binding Shot",
		[1499] = 15,				--"Freezing Trap",
		[60192] = 12,				--"Freezing Trap (launcher)",
		[82726] = 30,				--"Fervor",
		[3045] = 180,				--"Rapid Fire",
		[53351] = 10,				--"Kill Shot",
		[53271] = 45, 				--"Master's Call",
		[51753] = 60,				--"Camouflage",
		[19574] = 60,				--"Bestial Wrath",
		[61685] = 25,				--"Charge",
		[50519] = 60,				--"Sonic Blast",
		[50433] = 10,				--"Ankle Crack",
		[90355] = 360,				--"Ancient Hysteria",
		[90361] = 40,				--"Spirit Mend",
		[55709] = 480,				--"Heart of the Phoenix",
		[53480] = 60,				--"Roar of Sacrifice",
		[53478] = 360,				--"Last Stand",
	},
	[L["WARLOCK"]] = {
		[6789] = 45,				--"Death Coil",
		[5484] = 40,				--"Howl of Terror",
		[111397] = 30,				--"Blood Horror",
		[110913] = 180,				--"Dark Bargain",
		[108482] = 60,				--"Unbound Will",
		[108359] = 120,				--"Dark Regeneration",
		[108416] = 60,				--"Sacrificial Pact",
		[30283] = 30,				--"Shadowfury",
		[48020] = 30,				--"Demonic Circle: Teleport",
		[104773] = 120,				-- Unending Resolve
		[19647] = 24,				--"Spell Lock",
		[7812] = 60,				--"Sacrifice",
		[89766] = 30,				--"Axe Toss"
		[89751] = 45,				--"Felstorm",
		[115781] = 24,				-- Optical Blast
	},
	[L["MAGE"]] = {
		[2139] = 22,				--"Counterspell",
		[45438] = 300,				--"Ice Block",
		[110959] = 90,				--"Greater Invisibility",
		[102051] = 20,				--"Frostjaw",
		[44572] = 30,				--"Deep Freeze",
		[11958] = 180,				--"Cold Snap",	
		[12042] = 90,				--"Arcane Power",		
		[12051] = 120,				--"Evocation", 
		[122] = 25,					--"Frost Nova",	
		[11426] = 25,				--"Ice Barrier", 
		[12472] = 180,				--"Icy Veins",
		[55342] = 180,				--"Mirror Image", 
		[66] = 300,					--"Invisibility",
		[113724] = 45,				--"Ring of Frost",
		[80353] = 300, 				--"Time Warp",
		[12043] = 90,				--"Presence of Mind",
		[11129] = 45,				--"Combustion",
		[31661] = 20,				--"Dragon's Breath",
		[1953] = 15,				-- Blink
		[33395] = 25,				--"Freeze",
	},
	[L["DEATHKNIGHT"]] = {
		[47476] = 60,				--"Strangulate",
		[108194] = 30,				-- Asphyxiate
		[48707] = 45,				--"Anti-Magic Shell",
		[49576] = 25,				--"Death Grip",	
		[47528] = 13,				--"Mind Freeze",
		[108200] = 60,				--"Remorseless Winter",
		[108201] = 120,				--"Desecrated Ground",
		[108199] = 60,				--"Gorefiend's Grasp",
		[49039] = 120,				--"Lichborne",
		[49222] = 60,				--"Bone Shield",
		[51271] = 60,				--"Pillar of Frost",
		[51052] = 120,				--"Anti-Magic Zone",
		[49206] = 180,				--"Summon Gargoyle",
		[48792] = 180,				--"Icebound Fortitude",
		[48743] = 120,				--"Death Pact",
		[77606] = 60,				-- Dark Simulacrum
	},
	[L["DRUID"]] = {
		[78675] = 60,				--"Solar Beam",
		[5211] = 50,				--"Bash",
		[106839] = 15,				-- Skull Bash
		[132469] = 30,				-- Тайфун
		[124974] = 90,				--"Nature's Vigil",
		[102359] = 30,				--"Mass Entanglement",
		[99] = 30,					--"Disorienting Roar",
		[102280] = 30,				--"Displacer Beast",
		[22812] = 60,				--"Barkskin",
		[132158] = 60,				--"Nature's Swiftness",
		[33891] = 180,				--"Tree of Life",
		[16979] = 15,				--"Wild Charge - Bear",
		[49376] = 15,				--"Wild Charge - Cat",
		[61336] = 180,				--"Survival Instincts",
		[50334] = 180,				--"Berserk",
		[22570] = 10,				--"Maim",
		[18562] = 15,				--"Swiftmend",
		[48505] = 90,				--"Starfall",
		[740] = 480,				--"Tranquility",
		[78674] = 15,				--"Starsurge",
		[102543] = 180,				-- Incarnation: King of the Jungle
		[102560] = 180,				-- Incarnation: Chosen of Elune
	},
	[L["MONK"]] = {
		[116705] = 15, 				--Spear Hand Strike (interrupt)
		[115078] = 15, 				--Paralysis
		[119381] = 45, 				--Leg Sweep (mass stun)
		[123904] = 180,				--"Invoke Xuen, the White Tiger",
		[101643] = 45,				--"Transcendence",
		[119996] = 25,				--"Transcendence: Transfer",
		[115176] = 180,				--"Zen Meditation",
		[115310] = 180,				--"Revival",
		[122278] = 90, 				--"Dampen Harm",
		[122783] = 90,				--"Diffuse Magic",
		[116844] = 45,				--"Ring of Peace",
		[116849] = 120,				--"Life Cocoon",
		[137562] = 120,				--"Nimble Brew",
		[122470] = 90,				--"Touch of Karma",
		[101545] = 25,				--"Flying Serpent Kick",
		[116841] = 30,				--"Tiger's Lust",
		[113656] = 25,				--"Fists of Fury",
	},
	[L["PALADIN"]] = {
		[853] = 60,					--"Hammer of Justice" (stun)
		[115750] = 120,				--Blinding Light (blind (sic!))
		[105593] = 30,				-- Fist of Justice
		[96231] = 15,				--"Rebuke",
		[642] = 300,				--"Divine Shield",
		[85499] = 45,				--"Speed of Light",
		[1044] = 25,				--"Hand of Freedom",
		[31884] = 180,				--"Avenging Wrath",
		[31935] = 15,				--"Avenger's Shield",
		[633] = 600,				--"Lay on Hands",
		[1022] = 300,				--"Hand of Protection",
		[498] = 60,					--"Divine Protection",
		[6940] = 120,				--"Hand of Sacrifice",
		[31842] = 180,				--"Divine Favor",
		[31821] = 180,				--"Devotion Aura",
		[20066] = 15,				--"Repentance",
		[31850] = 180,				--"Ardent Defender",
	},
	[L["PRIEST"]] = {
		[64044] = 45,				--"Psychic Horror",
		[8122] = 30,				--"Psychic Scream",
		[15487] = 45,				--"Silence",
		[47585] = 105,				--"Dispersion",
		[33206] = 180,				--"Pain Suppression",
		[108920] = 30,				-- Void Tendrils
		[112833] = 30,				-- Призрачный облик
		[123040] = 60,				--"Mindbender",
		[10060] = 120,				--"Power Infusion",
		[88625] = 30,				--"Holy Word: Chastise",
		[586] = 30,					--"Fade",
		[112833] = 30,				--"Spectral Guise",
		[6346] = 120,				--"Fear Ward",
		[64843] = 180,				--"Divine Hymn",
		[73325] = 90,				--"Leap of Faith",
		[19236] = 120,				--"Desperate Prayer",
		[724] = 180,				--"Lightwell",
		[62618] = 180,				--"Power Word: Barrier",
		[47788] = 180,				-- Guardian Spirit
	},
	[L["ROGUE"]] = {
		[2094] = 90,				--"Blind",
		[1766] = 13,				--"Kick",
		[31224] = 60,				--"Cloak of Shadows",
		[1856] = 120,				-- Исчезновение
		[1776] = 10,				--"Gouge",
		[2983] = 60,				--"Sprint",
		[14185] = 300,				--"Preparation",
		[36554] = 20,				--"Shadowstep",
		[5277] = 120,				--"Evasion",
		[408] = 20,					--"Kidney Shot",
		[76577] = 180,				--"Smoke Bomb",
		[51690] = 120,				--"Killing Spree",
		[51713] = 60, 				--"Shadow Dance",
		[79140] = 120,				--"Vendetta",
		[13750] = 180,				-- Adrenaline Rush
	},
	[L["SHAMAN"]] = {
		[8177] = 25,				--"Grounding Totem",
		[57994] = 12,				--"Wind Shear",
		[51490] = 35,				--"Thunderstorm",
		[51485] = 30,				--"Earthbind Totem",
		[8143] = 60,				--"Tremor Totem",
		[51514] = 35,				--"Hex",
		[108269] = 45,				--"Capacitor Totem",
		[108270] = 60,				--"Stone Bulwark Totem",
		[108280] = 180,				--"Healing Tide Totem",
		[98008] = 180,				--"Spirit Link Totem",
		[32182] = 300,				--"Heroism",
		[2825] = 300,				--"Bloodlust",
		[51533] = 120,				--"Feral Spirit",
		[30823] = 60,				--"Shamanistic Rage",
		[2484] = 30,				--"Earthbind Totem",
		[79206] = 120,				--"Spiritwalker's Grace",
		[16166] = 90,				--"Elemental Mastery",
		[16188] = 90,				--"Ancestral Swiftness",
		[108273] =	60,				-- Windwalk Totem
		[108285] = 	180,			-- Call of the Elements
		[114050] = 180,				-- Elemental Ascendance
		[114051] = 180,				-- Enhancement Ascendance
		[114052] = 180,				-- Restoration Ascendance
	},
	[L["WARRIOR"]] = {
		[102060] = 40,				--"Разрушительный крик"
		[100] = 12,					--"Charge",
		[6552] = 15,				--"Pummel",
		[23920] = 20,				--"Spell Reflection",
		[46924] = 60,				--"Bladestorm",
		[46968] = 40,				--"Shockwave",
		[107574] = 180,				--"Avatar",
		[12292] = 60, 				--"Bloodbath",
		[86346] = 20,				--"Colossus Smash",
		[5246] = 90,				--"Intimidating Shout",
		[871] = 180,				--"Shield Wall",	
		[118038] = 120,				--"Die by the Sword",
		[1719] = 180,				--"Recklessness",
		[3411] = 30,				--"Intervene",
		[64382] = 300,				--"Shattering Throw",
		[6544] = 30,				--"Heroic Leap",
		[12975] = 180,				--"Last Stand",
		[114028] = 60,				-- Mass Spell Reflection
		[18499] = 30,				-- Berserker Rage
		[107570] = 30,				-- Storm Bolt
	},
};

addonTable.Interrupts = {
	47528,	-- Mind Freeze
	80964,	-- Skull Bash (bear)
	80965,	-- Skull Bash (cat)
	2139,	-- Counterspell
	96231,	-- Rebuke
	15487,	-- Silence
	1766,	-- Kick
	57994,	-- Wind Shear
	6552,	-- Pummel
	102060,	-- Disrupting Shout
	24259,	-- Spell Lock
	147362,	-- Counter Shot
	116705, -- Spear Hand Strike
	115781,	-- Optical Blast
};

addonTable.Resets = {
	[11958] = {
		45438,		-- Ice Block
		122,		-- Frost Nova
		120,		-- Cone of Cold
	},
	[14185] = {
		2983,		-- Sprint
		1856,		-- Vanish
		5277,		-- Evasion
		51722,		-- Dismantle
	},
	[108285] = {
		108269,		-- Capacitor Totem
		8177,		-- Grounding Totem
		51485,		-- Earthgrab Totem
		8143,		-- Tremor Totem
		108270,		-- Stone Bulwark Totem
		108273,		-- Windwalk Totem
	},
};