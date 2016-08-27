local _, addonTable = ...;
local L = addonTable.L;
-- // DO-NOT-FORGET: SolarBeam - 30sec; DH's sigils - 40%; Druid's tranq - 60sec; Hunter's freezing trap - 15%; Mage's Greater Invisibility - 45sec; Mage's Displacement - 6sec
-- // Monk's Life Cocoon - 90sec; Monk's Zen Meditation - 50%; Pala's divine shield, Благословение защиты, Жертвенное благословение -50%;Благословение защиты-10%;Ревностный защитник-10sec
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
		[195710] = 180,				-- // Почетный медальон
		[214027] = 60,				-- // Адаптация
		[208683] = 120,				-- // Медальон гладиатора
	},
	[L["HUNTER"]] = { -- // OK
		[186257] = 180,					-- // Aspect of the Cheetah
		[186265] = 180,					-- // Aspect of the Turtle
		[205691] = 120,					-- // Dire Beast: Basilisk
		[209789] = 30,					-- // Freezing Arrow
		[213691] = 20,					-- // Scatter Shot
		[53271] = 45,					-- // Master's Call
		[19574] = 90,					-- // Bestial Wrath
		[147362] = 24,					-- // Counter Shot
		[781] = 20,						-- // Disengage
		[109304] = 120,					-- // Exhilaration
		[186387] = 30,					-- // Bursting Shot
		[193526] = 180,					-- // Trueshot
		[186289] = 120,					-- // Aspect of the Eagle
		[187650] = 25,					-- // Freezing Trap - 15%
		[187707] = 15,					-- // Muzzle
		[109248] = 45,					-- // Binding Shot
		[19577] = 60,					-- // Intimidation
		[19386] = 45,					-- // Wyvern Sting
		[199483] = 60,					-- // Camouflage
		[200108] = 60,					-- // Ranger's Net
		[201078] = 90,					-- // Snake Hunter
	},
	[L["WARLOCK"]] = { -- // OKSOGOOD
		[48020] = 30,				-- // Demonic Circle: Teleport
		[6789] = 45,				-- // Mortal Coil
		[5484] = 40,				--"Howl of Terror",
		[108359] = 120,				--"Dark Regeneration",
		[108416] = 60,				-- // Dark Pact
		[30283] = 30,				--"Shadowfury",
		[104773] = 150,				-- Unending Resolve [-30sec]
		[19647] = 24,				--"Spell Lock",
		[7812] = 60,				--"Sacrifice",
		[89766] = 30,				--"Axe Toss"
		[89751] = 45,				--"Felstorm",
		[115781] = 24,				-- Optical Blast
		[212295] = 45,				-- // Nether Ward
		[1122] = 60,				-- // Summon Infernal [-120sec]
		[18540] = 180,				-- // Summon Doomguard
		[212459] = 90,				-- // Call Fel Lord
		[212284] = 45,				-- // Firestone
	},
	[L["MAGE"]] = { -- // OK
		[122] = 30,					-- // Frost Nova
		[1953] = 15,				-- // Blink
		[11426] = 25,				-- // Ice Barrier
		[45438] = 300,				-- // Ice Block
		[2139] = 24,				-- // Counterspell
		[12042] = 90,				-- // Arcane Power
		[195676] = 24,				-- // Displacement
		[12051] = 90,				-- // Evocation
		[110959] = 75,				-- // Greater Invisibility
		[190319] = 120,				-- // Combustion
		[31661] = 20,				-- // Dragon's Breath
		[66] = 300,					-- // Invisibility
		[84714] = 60,				-- // Frozen Orb
		[12472] = 180,				-- // Icy Veins
		[31687] = 60,				-- // Summon Water Elemental
		[157980] = 25,				-- // Supernova
		[157997] = 25,				-- // Ice Nova
	},
	[L["DEATHKNIGHT"]] = { -- // OK
		[47476] = 60,				--"Strangulate",
		[108194] = 45,				-- Asphyxiate
		[48707] = 60,				--"Anti-Magic Shell",
		[49576] = 25,				--"Death Grip",	
		[47528] = 15,				--"Mind Freeze",
		[108201] = 120,				--"Desecrated Ground",
		[108199] = 180,				--"Gorefiend's Grasp",
		[49039] = 120,				--"Lichborne",
		[51271] = 60,				--"Pillar of Frost",
		[51052] = 120,				--"Anti-Magic Zone",
		[49206] = 180,				--"Summon Gargoyle",
		[48792] = 180,				--"Icebound Fortitude",
		[48743] = 120,				--"Death Pact",
		[77606] = 60,				-- Dark Simulacrum
		[221562] = 45,				-- // Asphyxiate
		[49028] = 180,				-- // Dancing Rune Weapon
		[42650] = 600,				-- // Army of the Dead
		[63560] = 60,				-- // Dark Transformation
		[206977] = 120,				-- // Blood Mirror
		[219809] = 60,				-- // Tombstone
		[207167] = 60, 				-- // Blinding Sleet
		[207319] = 60,				-- // Corpse Shield
		[207349] = 180,				-- // Dark Arbiter
	},
	[L["DRUID"]] = { -- // OK
		[1850] = 180,				-- // Dash
		[20484] = 600,				-- // Rebirth
		[200851] = 90,				-- // Rage of the Sleeper
		[208253] = 90,				-- // Essence of G'Hanir
		[209749] = 30,				-- // Faerie Swarm
		[202246] = 15,				-- // Overrun
		[22812] = 60,				-- // Barkskin
		[194223] = 180,				-- // Celestial Alignment
		[78675] = 30,				-- // Solar Beam
		[106951] = 180,				-- // Berserk
		[22570] = 10,				-- // Maim
		[61336] = 180,				-- // Survival Instincts x2
		[5217] = 30,				-- // Tiger's Fury
		[102342] = 90,				-- // Ironbark
		[740] = 120,				-- // Tranquility
		[102793] = 60,				-- // Ursol's Vortex
		[205636] = 60,				-- // Force of Nature
		[102560] = 180,				-- // Incarnation: Chosen of Elune
		[108238] = 120,				-- // Renewal
		[102543] = 180,				-- // Incarnation: King of the Jungle
		[102558] = 180,				-- // Incarnation: Guardian of Ursoc
		[33891] = 180,				-- // Incarnation: Tree of Life
		[106839] = 15,				-- // Skull Bash
	},
	[L["MONK"]] = { -- // OK
		[202162] = 45,			-- // Guard
		[202370] = 60,			-- // Mighty Ox Kick
		[201318] = 90,			-- // Fortifying Elixir
		[201325] = 180,			-- // Zen Meditation
		[216113] = 45,			-- // Way of the Crane
		[115181] = 15,			-- // Breath of Fire
		[115203] = 420,			-- // Fortifying Brew
		[116705] = 15,			-- // Spear Hand Strike
		[115176] = 150,			-- // Zen Meditation
		[137639] = 90,			-- // Storm, Earth, and Fire
		[115080] = 60,			-- // Touch of Death
		[122470] = 90,			-- // Touch of Karma
		[116849] = 90,			-- // Life Cocoon
		[115310] = 180,			-- // Revival
		[132578] = 180,			-- // Invoke Niuzao, the Black Ox	
		[123904] = 180,			-- // Invoke Xuen, the White Tiger
		[198664] = 180,			-- // Invoke Chi-Ji, the Red Crane
		[198898] = 30,			-- // Song of Chi-Ji
		[115078] = 15,			-- // Paralysis
		[119996] = 25,			-- // Transcendence: Transfer
		[152173] = 90,			-- // Serenity
	},
	[L["PALADIN"]] = { -- // OKSOGOOD
		[642] = 150,			-- // Божественный щит
		[1044] = 25,			-- // Благословенная свобода
		[633] = 600,			-- // Возложение рук
		[216331] = 60,			-- // Рыцарь-мститель
		[228049] = 180,			-- // Страж забытой королевы
		[210256] = 25,			-- // Благословение святилища
		[1022] = 135,			-- // Благословение защиты
		[31821] = 180,			-- // Владение аурами
		[498] = 60,				-- // Божественная защита
		[31842] = 120,			-- // Гнев карателя
		[6940] = 75,			-- // Жертвенное благословение
		[853] = 60,				-- // Молот правосудия
		[190784] = 45,			-- // Божественный скакун
		[31884] = 120,			-- // Гнев карателя
		[86659] = 300,			-- // Защитник древних королей
		[31850] = 110,			-- // Ревностный защитник
		[96231] = 15,			-- // Укор
		[31884] = 120,			-- // Гнев карателя
		[105809] = 90,			-- // Святой каратель
		[204018] = 180,			-- // Благословение защиты от заклинаний
		[204150] = 300,			-- // Эгида Света
		[205191] = 60,			-- // Око за око
		[224668] = 120,			-- // Священная война
	},
	[L["PRIEST"]] = { -- // OKSOGOOD
		[64044] = 45,				--"Psychic Horror",
		[8122] = 30,				--"Psychic Scream", [-30sec]
		[15487] = 45,				--"Silence",
		[47585] = 120,				--"Dispersion",
		[33206] = 210,				--"Pain Suppression", [-30sec]
		[112833] = 30,				-- Призрачный облик
		[123040] = 60,				--"Mindbender",
		[10060] = 120,				--"Power Infusion",
		[88625] = 60,				--"Holy Word: Chastise",
		[586] = 30,					--"Fade",
		[112833] = 30,				--"Spectral Guise",
		[64843] = 180,				--"Divine Hymn",
		[73325] = 90,				--"Leap of Faith",
		[19236] = 90,				--"Desperate Prayer",
		[62618] = 120,				--"Power Word: Barrier", [-60sec]
		[47788] = 96,				-- Guardian Spirit [-60%] [max=120sec]
		[215769] = 300,				-- // Дух воздаяния
		[108968] = 300,				-- // Вхождение в Бездну
		[213602] = 30,				-- // Улучшенный уход в тень
		[205369] = 30,				-- // Мыслебомба
		[204263] = 60,				-- // Сияющая мощь
	},
	[L["ROGUE"]] = { -- // OKSOGOOD
		[2094] = 120,				--"Blind",
		[1766] = 15,				--"Kick",
		[31224] = 81,				--"Cloak of Shadows" [-9sec]
		[1856] = 30,				-- Исчезновение [-90sec]
		[1776] = 10,				--"Gouge",
		[2983] = 51,				--"Sprint" [-9sec]
		[36554] = 30,				--"Shadowstep",
		[5277] = 120,				--"Evasion",
		[408] = 20,					--"Kidney Shot",
		[76577] = 180,				--"Smoke Bomb",
		[51690] = 120,				--"Killing Spree",
		[79140] = 90,				--"Vendetta", [-30sec]
		[13750] = 150,				-- Adrenaline Rush [-30sec]
		[195457] = 30,				-- // Абордажный крюк
		[199743] = 20,				-- // Парламентер
		[31230] = 120,				-- // Обман смерти
		[207777] = 45,				-- // Долой оружие
		[207736] = 120,				-- // Дуэль в тенях
		[212182] = 180,				-- // Дымовая шашка
		[198529] = 120,				-- // Кража доспехов
		[199804] = 20,				-- // Промеж глаз
		[121471] = 180,				-- // Теневые клинки
	},
	[L["SHAMAN"]] = { -- // OKSOGOOD
		[57994] = 12,				--"Wind Shear",
		[51490] = 45,				--"Thunderstorm",
		[51485] = 30,				--"Earthbind Totem",
		[108280] = 180,				--"Healing Tide Totem",
		[98008] = 180,				--"Spirit Link Totem",
		[32182] = 300,				--"Heroism",
		[2825] = 300,				--"Bloodlust",
		[51533] = 120,				--"Feral Spirit",
		[79206] = 60,				--"Spiritwalker's Grace", [-60sec]
		[16166] = 120,				--"Elemental Mastery",
		[114050] = 180,				-- Elemental Ascendance
		[114051] = 180,				-- Enhancement Ascendance
		[114052] = 180,				-- Restoration Ascendance
		[108271] = 90,				-- // Астральный сдвиг
		[51514] = 10,				--"Hex", [-20sec]
		[210873] = 10,				-- // Hex [-20sec]
		[211004] = 10,				-- // Hex [-20sec]
		[211010] = 10,				-- // Hex [-20sec]
		[211015] = 10,				-- // Hex [-20sec]
		[210918] = 45,				-- // Астральный облик
		[204293] = 60,				-- // Духовная связь
		[204437] = 30,				-- // Молния-лассо
		[204336] = 30,				-- // Тотем заземления
		[204331] = 45,				-- // Тотем контрудара
		[192063] = 15,				-- // Порыв ветра
		[196884] = 30,				-- // Свирепый выпад
		[196932] = 30,				-- // Тотем вуду
		[192058] = 45,				-- // Тотем выброса тока
		[207399] = 300,				-- // Тотем защиты Предков
	},
	[L["WARRIOR"]] = { -- // OKSOGOOD
		[100] = 17,					--"Charge", [-3sec (talent)]
		[6552] = 15,				--"Pummel",
		[23920] = 25,				--"Spell Reflection",
		[46924] = 90,				--"Bladestorm",
		[46968] = 40,				--"Shockwave",
		[107574] = 90,				--"Avatar",
		[12292] = 30, 				--"Bloodbath",
		[5246] = 90,				--"Intimidating Shout",
		[871] = 240,				--"Shield Wall",	
		[118038] = 180,				--"Die by the Sword",
		[1719] = 35,				-- // Battle Cry [-10sec (arti)] [-15sec (htalent)]
		[3411] = 30,				--"Intervene",
		[6544] = 39,				--"Heroic Leap", [-6sec]
		[12975] = 180,				--"Last Stand",
		[114028] = 30,				-- Mass Spell Reflection
		[18499] = 60,				-- Berserker Rage
		[107570] = 30,				-- Storm Bolt
		[198758] = 17,				-- // Intercept [-3sec (talent)]
		[216890] = 25,				-- // Spell Reflection
		[213915] = 30,				-- // Mass Spell Reflection
		[227847] = 90,				-- // Bladestorm
		[184364] = 120,				-- // Enraged Regeneration
		[198304] = 17,				-- // Intercept [-3sec (talent)]
		[206572] = 20,				-- // Dragon Charge
	},
	[L["DEMONHUNTER"]] = { -- // OK
		[198589] = 60,					-- // Blur
		[179057] = 60,					-- // Chaos Nova
		[183752] = 15,					-- // Consume Magic
		[196718] = 180,					-- // Darkness
		[191427] = 300,					-- // Metamorphosis
		[188501] = 30,					-- // Spectral Sight
		[218256] = 20,					-- // Empower Wards
		[187827] = 180,					-- // Metamorphosis
		[202138] = 72,					-- // Sigil of Chains
		[207684] = 36,					-- // Sigil of Misery
		[202137] = 36,					-- // Sigil of Silence
		[211048] = 120,					-- // Chaos Blades
		[211881] = 35,					-- // Fel Eruption
		[206491] = 120,					-- // Nemesis
		[207810] = 120,					-- // Nether Bond
		[196555] = 90,					-- // Netherwalk
		[205629] = 30,					-- // Demonic Trample
		[205604] = 60,					-- // Reverse Magic
		[206803] = 60,					-- // Rain from Above
		[205630] = 90,					-- // Illidan's Grasp
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
	24259,	-- Spell Lock
	147362,	-- Counter Shot
	116705, -- Spear Hand Strike
	115781,	-- Optical Blast
	183752,	-- Consume Magic
	187707, -- // Muzzle
};

addonTable.Resets = {
	[195676] = {	-- // Displacement
		1953,			-- // Blink
	},
};

addonTable.Trinkets = {
	42292,
	59752,
	7744,
	195710,				-- // Почетный медальон
	214027,				-- // Адаптация
	208683,				-- // Медальон гладиатора
};