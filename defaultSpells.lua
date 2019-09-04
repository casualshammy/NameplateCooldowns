if (select(4, GetBuildInfo()) < 80200) then return end

local _, addonTable = ...;
local L = addonTable.L;

addonTable.DefaultSpellsVersion = 8;

addonTable.CDs = {
	-- // other spells
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
	[42292] = 120,				--"PvP Trinket", - присутствует в CLEU как Адаптация
	[195710] = 180,				-- // Почетный медальон
	[208683] = 120,				-- // Медальон гладиатора - присутствует в CLEU
	-- // hunter
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
	[201078] = 120,					-- // Snake Hunter
	-- // warlock
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
	[212459] = 90,				-- // Call Fel Lord
	[212284] = 45,				-- // Firestone
	-- // mage
	[122] = 30,					-- // Frost Nova
	[1953] = 15,				-- // Blink
	[11426] = 25,				-- // Ice Barrier
	[45438] = 240,				-- // Ice Block
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
	[235219] = 300,				-- // Cold Snap
	[198111] = 45,				-- // Temporal Shield (Envelops you in a temporal shield for 6 sec. 100% of all damage taken while shielded will be instantly restored when the shield ends.)
	-- // deathknight
	[47476] 	= 60,				--"Strangulate",
	[108194] 	= 45,				-- Asphyxiate
	[48707] 	= 60,				--"Anti-Magic Shell",
	[49576] 	= 25,				--"Death Grip",	
	[47528] 	= 15,				--"Mind Freeze",
	[108201] 	= 120,				--"Desecrated Ground",
	[108199] 	= 90,				--"Gorefiend's Grasp", (talent: Tightening Grasp)
	[51271] 	= 60,				--"Pillar of Frost",
	[51052] 	= 120,				--"Anti-Magic Zone",
	[49206] 	= 180,				--"Summon Gargoyle",
	[48792] 	= 180,				--"Icebound Fortitude",
	[48743] 	= 120,				--"Death Pact",
	[77606] 	= 60,				-- Dark Simulacrum
	[221562] 	= 45,				-- // Asphyxiate
	[49028] 	= 180,				-- // Dancing Rune Weapon
	[42650] 	= 600,				-- // Army of the Dead
	[63560] 	= 60,				-- // Dark Transformation
	[206977] 	= 120,				-- // Blood Mirror
	[219809] 	= 60,				-- // Tombstone
	[207167] 	= 60, 				-- // Blinding Sleet
	[207319] 	= 60,				-- // Corpse Shield
	[207349] 	= 120,				-- // Dark Arbiter
	[91802] 	= 30,				-- // Shambling Rush https://www.wowhead.com/spell=91802/shambling-rush
	-- // druid
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
	[108238] = 90,				-- // Renewal
	[102543] = 180,				-- // Incarnation: King of the Jungle
	[102558] = 180,				-- // Incarnation: Guardian of Ursoc
	[33891] = 180,				-- // Incarnation: Tree of Life
	[106839] = 15,				-- // Skull Bash
	[5211]		= 50,			-- // Mighty Bash
	[132469]	= 30,			-- // Typhoon https://www.wowhead.com/spell=132469/typhoon
	[102359]	= 30,			-- // Mass Entanglement https://www.wowhead.com/spell=102359/mass-entanglement
	-- // monk
	[202162] = 45,			-- // Guard
	[202370] = 60,			-- // Mighty Ox Kick
	[201318] = 90,			-- // Fortifying Elixir
	[201325] = 180,			-- // Zen Meditation
	[216113] = 45,			-- // Way of the Crane
	[115181] = 15,			-- // Breath of Fire
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
	[198898] = 15,			-- // Song of Chi-Ji
	[115078] = 15,			-- // Paralysis
	[119996] = 25,			-- // Transcendence: Transfer
	[152173] = 90,			-- // Serenity
	[122278] = 120,			-- // Dampen Harm
	[122783] = 90,			-- // Diffuse Magic
	[119381] = 60,			-- // Leg Sweep https://www.wowhead.com/spell=119381/leg-sweep
	[116844] = 45,			-- // Ring of Peace https://www.wowhead.com/spell=116844/ring-of-peace
	-- // paladin
	[642] = 240,			-- // Божественный щит
	[1044] = 25,			-- // Благословенная свобода
	[633] = 600,			-- // Возложение рук
	[216331] = 60,			-- // Рыцарь-мститель
	[228049] = 180,			-- // Страж забытой королевы
	[210256] = 25,			-- // Благословение святилища
	[1022] = 135,			-- // Благословение защиты
	[31821] = 180,			-- // Владение аурами
	[498] = 60,				-- // Божественная защита
	[6940] = 75,			-- // Жертвенное благословение
	[853] = 30,				-- // Молот правосудия https://www.wowhead.com/spell=853/hammer-of-justice
	[190784] = 45,			-- // Божественный скакун
	[31884] = 120,			-- // Гнев карателя
	[86659] = 300,			-- // Защитник древних королей
	[31850] = 110,			-- // Ревностный защитник
	[96231] = 15,			-- // Укор
	[31884] = 120,			-- // Гнев карателя
	[105809] = 90,			-- // Святой каратель
	[204018] = 180,			-- // Благословение защиты от заклинаний
	[204150] = 180,			-- // Эгида Света
	[205191] = 60,			-- // Око за око
	-- // priest
	[64044] = 45,				--"Psychic Horror",
	[8122] = 30,				--"Psychic Scream", [-30sec]
	[15487] = 45,				--"Silence",
	[47585] = 120,				--"Dispersion",
	[33206] = 210,				--"Pain Suppression", [-30sec]
	[123040] = 60,				--"Mindbender",
	[10060] = 120,				--"Power Infusion",
	[88625] = 60,				--"Holy Word: Chastise",
	[64843] = 180,				--"Divine Hymn",
	[73325] = 45,				--"Leap of Faith",
	[19236] = 90,				--"Desperate Prayer",
	[62618] = 120,				--"Power Word: Barrier", [-60sec]
	[47788] = 60,				-- Guardian Spirit [-60%] [max=120sec]
	[215769] = 300,				-- // Дух воздаяния
	[108968] = 300,				-- // Вхождение в Бездну
	[213602] = 30,				-- // Улучшенный уход в тень
	[205369] = 30,				-- // Мыслебомба
	[204263] = 45,				-- // Сияющая мощь
	-- // rogue
	[2094] = 90,				--"Blind",
	[1766] = 15,				--"Kick",
	[31224] = 120,				-- Cloak of Shadows https://www.wowhead.com/spell=31224/cloak-of-shadows#modified-by
	[1856] = 75,				-- Vanish https://www.wowhead.com/spell=1856/vanish
	[1776] = 10,				--"Gouge",
	[2983] = 51,				--"Sprint" [-9sec]
	[36554] = 30,				--"Shadowstep",
	[5277] = 120,				--"Evasion",
	[408] = 20,					--"Kidney Shot",
	[51690] = 120,				--"Killing Spree",
	[79140] = 90,				--"Vendetta", [-30sec]
	[13750] = 150,				-- Adrenaline Rush [-30sec]
	[195457] = 30,				-- // Абордажный крюк
	[199743] = 20,				-- // Парламентер
	[31230] = 360,				-- // Обман смерти
	[207777] = 45,				-- // Долой оружие
	[207736] = 120,				-- // Дуэль в тенях
	[212182] = 180,				-- // Дымовая шашка
	[198529] = 120,				-- // Кража доспехов
	[199804] = 20,				-- // Промеж глаз
	[121471] = 180,				-- // Теневые клинки
	[199754] = 120,				-- // Riposte https://www.wowhead.com/spell=199754/riposte
	-- // shaman
	[57994] = 12,				--"Wind Shear",
	[51490] = 45,				--"Thunderstorm",
	[51485] = 30,				--"Earthbind Totem",
	[108280] = 180,				--"Healing Tide Totem",
	[98008] = 180,				--"Spirit Link Totem",
	[32182] = 60,				--"Heroism",
	[2825] = 60,				--"Bloodlust",
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
	[204437] = 30,				-- // Молния-лассо
	[204336] = 30,				-- // Тотем заземления
	[204331] = 45,				-- // Тотем контрудара
	[192063] = 15,				-- // Порыв ветра
	[196884] = 30,				-- // Свирепый выпад
	[196932] = 30,				-- // Тотем вуду
	[192058] = 45,				-- // Тотем выброса тока
	[207399] = 300,				-- // Тотем защиты Предков
	-- // warrior
	[100] 		= 17,					--"Charge", [-3sec (talent)]
	[6552] 		= 15,				--"Pummel",
	[23920] 	= 25,				--"Spell Reflection",
	[46924] 	= 60,				--"Bladestorm",
	[46968] 	= 40,				--"Shockwave",
	[107574] 	= 90,				--"Avatar",
	[12292] 	= 30, 				--"Bloodbath",
	[5246] 		= 90,				--"Intimidating Shout",
	[871] 		= 240,				--"Shield Wall",	
	[118038] 	= 180,				--"Die by the Sword",
	[1719] 		= 90,				-- // Recklessness https://www.wowhead.com/spell=1719/recklessness
	[6544] 		= 30,				--"Heroic Leap", [-6sec]
	[12975] 	= 180,				--"Last Stand",
	[18499] 	= 60,				-- Berserker Rage
	[107570] 	= 30,				-- Storm Bolt
	[198758] 	= 17,				-- // Intercept [-3sec (talent)]
	[216890] 	= 25,				-- // Spell Reflection
	[213915] 	= 30,				-- // Mass Spell Reflection
	[227847] 	= 60,				-- // Bladestorm
	[184364] 	= 120,				-- // Enraged Regeneration
	[198304] 	= 17,				-- // Intercept [-3sec (talent)]
	[206572] 	= 20,				-- // Dragon Charge
	[236077] 	= 30,				-- // Disarm
	
	[167105] = 45,				-- // Colossus Smash
	[262161] = 45,				-- // Warbreaker
	[236273] = 60,				-- // Duel
	[236320] = 90,				-- // War Banner
	[198817] = 25,				-- // Sharpen Blade
	-- // demonhunter
	[198589] = 60,					-- // Blur
	[179057] = 60,					-- // Chaos Nova
	[183752] = 15,					-- // Consume Magic
	[196718] = 180,					-- // Darkness
	[191427] = 180,					-- // Metamorphosis
	[200166] = 180,					-- // Metamorphosis (leap) (custom icon)
	[188501] = 30,					-- // Spectral Sight
	[187827] = 180,					-- // Metamorphosis
	[202138] = 54,					-- // Sigil of Chains
	[207684] = 36,					-- // Sigil of Misery
	[202137] = 36,					-- // Sigil of Silence
	[211881] = 30,					-- // Fel Eruption
	[206491] = 120,					-- // Nemesis
	[207810] = 120,					-- // Nether Bond
	[196555] = 120,					-- // Netherwalk
	[205629] = 30,					-- // Demonic Trample
	[205604] = 60,					-- // Reverse Magic
	[206803] = 60,					-- // Rain from Above
	[205630] = 60,					-- // Illidan's Grasp
	[206650] = 45,					-- // Глаз Леотераса
	[217832] = 45,					-- // Imprison https://www.wowhead.com/spell=217832/imprison
	[221527] = 45,					-- // Imprison https://www.wowhead.com/spell=221527/imprison
};

local interrupts = {
	47528,	-- Mind Freeze
	106839,	-- Skull Bash
	2139,	-- Counterspell
	96231,	-- Rebuke
	15487,	-- Silence
	1766,	-- Kick
	57994,	-- Wind Shear
	6552,	-- Pummel
	19647,	-- Spell Lock https://ru.wowhead.com/spell=19647
	147362,	-- Counter Shot
	116705, -- Spear Hand Strike
	115781,	-- Optical Blast
	183752,	-- Consume Magic
	187707, -- // Muzzle
	91802,	-- // Shambling Rush https://www.wowhead.com/spell=91802/shambling-rush
};
addonTable.Interrupts = { };
for _, spellID in pairs(interrupts) do
	local spellName = GetSpellInfo(spellID);
	if (spellName ~= nil) then
		addonTable.Interrupts[spellName] = true;
	else
		error("NameplateCooldowns: interrupt spell is not exist: "..tostring(spellID));
	end
end

-- // Trinkets
do

	local trinkets = {
		42292,
		59752,
		7744,
		195710,				-- // Почетный медальон
		208683,				-- // Медальон гладиатора
	};
	addonTable.Trinkets = { };
	for _, spellID in pairs(trinkets) do
		local spellName = GetSpellInfo(spellID);
		addonTable.Trinkets[spellName] = true;
	end

end

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
		[195676] = { -- // Displacement https://ru.wowhead.com/spell=195676/%D1%81%D0%BC%D0%B5%D1%89%D0%B5%D0%BD%D0%B8%D0%B5
			["reduction"] = BIG_REDUCTION,
			["spells"] = { 1953 }, -- // Blink
		},
		[235219] = { -- // Cold Snap https://ru.wowhead.com/spell=235219/%D1%85%D0%BE%D0%BB%D0%BE%D0%B4%D0%BD%D0%B0%D1%8F-%D1%85%D0%B2%D0%B0%D1%82%D0%BA%D0%B0
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
	};

end
