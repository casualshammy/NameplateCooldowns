-- luacheck: no max line length
-- luacheck: globals GetBuildInfo LibStub GetSpellInfo

if (select(4, GetBuildInfo()) < 80200) then return end

local _, addonTable = ...;
local GetSpellInfo = GetSpellInfo;

addonTable.DefaultSpellsVersion = 10;

addonTable.CDs = {
	[addonTable.UNKNOWN_CLASS] = {
		-- // reviewed 2020/10/15
		[336126] = 120,		-- // Медальон гладиатора https://ru.wowhead.com/spell=336126
		[283167] = 60,		-- // Адаптация https://ru.wowhead.com/spell=283167 (336139)
		[28730] = 120,		-- // Arcane Torrent https://ru.wowhead.com/spell=28730
		[50613] = 120,		-- // Arcane Torrent https://ru.wowhead.com/spell=50613
		[80483] = 120,		-- // Arcane Torrent https://ru.wowhead.com/spell=80483
		[25046] = 120,		-- // Arcane Torrent https://ru.wowhead.com/spell=25046
		[69179] = 120,		-- // Arcane Torrent https://ru.wowhead.com/spell=69179
		[20572] = 120,		-- // Blood Fury https://ru.wowhead.com/spell=20572
		[33702] = 120,		-- // Blood Fury https://ru.wowhead.com/spell=33702
		[33697] = 120,		-- // Blood Fury https://ru.wowhead.com/spell=33697
		[59543] = 180,		-- // Gift of the Naaru https://ru.wowhead.com/spell=59543
		[69070] = 90,		-- // Rocket Jump https://ru.wowhead.com/spell=69070
		[26297] = 180,		-- // Berserking https://ru.wowhead.com/spell=26297
		[20594] = 120,		-- // Stoneform https://ru.wowhead.com/spell=20594
		[58984] = 120,		-- // Shadowmeld https://ru.wowhead.com/spell=58984
		[20589] = 60,		-- // Escape Artist https://ru.wowhead.com/spell=20589
		[59752] = 180,		-- // Every Man for Himself https://ru.wowhead.com/spell=59752
		[7744] = 120,		-- // Will of the Forsaken https://ru.wowhead.com/spell=7744
		[68992] = 120,		-- // Darkflight https://ru.wowhead.com/spell=68992
		[69041] = 90,		-- // Rocket Barrage https://ru.wowhead.com/spell=69041
	},
	["HUNTER"] = {
		-- // reviewed 2020/10/15
		[186265] = 144,		-- // Aspect of the Turtle https://ru.wowhead.com/spell=186265
		[209789] = 30,		-- // Freezing Arrow https://ru.wowhead.com/spell=209789
		[213691] = 30,		-- // Scatter Shot https://ru.wowhead.com/spell=213691
		[53271] = 45,		-- // Master's Call https://ru.wowhead.com/spell=53271
		[19574] = 76.5,		-- // Bestial Wrath https://ru.wowhead.com/spell=19574
		[147362] = 24,		-- // Counter Shot https://ru.wowhead.com/spell=147362
		[781] = 20,			-- // Disengage https://ru.wowhead.com/spell=781
		[109304] = 96,		-- // Exhilaration https://ru.wowhead.com/spell=109304
		[187650] = 25,		-- // Freezing Trap - 15% https://ru.wowhead.com/spell=187650
		[187707] = 15,		-- // Muzzle https://ru.wowhead.com/spell=187707
		[109248] = 45,		-- // Binding Shot https://ru.wowhead.com/spell=109248
		[19577] = 60,		-- // Intimidation https://ru.wowhead.com/spell=19577
		[199483] = 60,		-- // Camouflage https://ru.wowhead.com/spell=199483
		[1543] = 20,		-- // Осветительная ракета https://ru.wowhead.com/spell=1543
		[212638] = 25,		-- // Сеть следопыта https://ru.wowhead.com/spell=212638
		[202914] = 45,		-- // Укус паука https://ru.wowhead.com/spell=202914
		[266779] = 96,		-- // Согласованная атака https://ru.wowhead.com/spell=266779
		[190925] = 30,		-- // Гарпун https://ru.wowhead.com/spell=190925
		[201430] = 120,		-- // Звериный натиск https://ru.wowhead.com/spell=201430
	},
	["WARLOCK"] = {
		-- // reviewed 2020/10/15
		[48020] = 30,		-- // Demonic Circle: Teleport https://ru.wowhead.com/spell=48020
		[6789] = 45,		-- // Mortal Coil https://ru.wowhead.com/spell=6789
		[5484] = 40,		-- // Howl of Terror https://ru.wowhead.com/spell=5484
		[108416] = 60,		-- // Dark Pact https://ru.wowhead.com/spell=108416
		[30283] = 45,		-- // Shadowfury https://ru.wowhead.com/spell=30283
		[104773] = 180,		-- // Unending Resolve [-30sec] https://ru.wowhead.com/spell=104773
		[19647] = 24,		-- // Spell Lock https://ru.wowhead.com/spell=19647
		[89766] = 30,		-- // Axe Toss" https://ru.wowhead.com/spell=89766
		[115781] = 24,		-- // Optical Blast https://ru.wowhead.com/spell=115781
		[212295] = 45,		-- // Nether Ward https://ru.wowhead.com/spell=212295
		[1122] = 60,		-- // Summon Infernal [-120sec] https://ru.wowhead.com/spell=1122
		[335175] = 60,		-- // Summon Infernal (level 2) [-120sec] https://ru.wowhead.com/spell=335175
		[212459] = 90,		-- // Call Fel Lord https://ru.wowhead.com/spell=212459
		[221703] = 60,		-- // Круг заклинателей https://ru.wowhead.com/spell=221703
		[212619] = 24,		-- // Вызов охотника Скверны https://ru.wowhead.com/spell=212619
	},
	["MAGE"] = {
		-- // reviewed 2020/10/16
		[122] = 30,			-- // Frost Nova https://ru.wowhead.com/spell=122
		[1953] = 15,		-- // Blink https://ru.wowhead.com/spell=1953
		[45438] = 240 - 30,	-- // Ice Block https://ru.wowhead.com/spell=45438
		[2139] = 24,		-- // Counterspell https://ru.wowhead.com/spell=2139
		[12042] = 120,		-- // Arcane Power https://ru.wowhead.com/spell=12042
		[195676] = 30,		-- // Displacement https://ru.wowhead.com/spell=195676
		[110959] = 120-45,	-- // Greater Invisibility https://ru.wowhead.com/spell=110959
		[190319] = 120,		-- // Combustion https://ru.wowhead.com/spell=190319
		[31661] = 20 - 2,	-- // Dragon's Breath https://ru.wowhead.com/spell=31661
		[66] = 300,			-- // Invisibility https://ru.wowhead.com/spell=66
		[84714] = 60,		-- // Frozen Orb https://ru.wowhead.com/spell=84714
		[12472] = 180,		-- // Icy Veins https://ru.wowhead.com/spell=12472
		[157980] = 25,		-- // Supernova https://ru.wowhead.com/spell=157980
		[235219] = 300-30,	-- // Cold Snap https://ru.wowhead.com/spell=235219
		[198111] = 45,		-- // Temporal Shield https://ru.wowhead.com/spell=198111
		[55342] = 120,		-- // Зеркальное изображение https://ru.wowhead.com/spell=55342
		[198144] = 60,		-- // Ледяной облик https://ru.wowhead.com/spell=198144
		[108978] = 60-30,	-- // Манипуляции со временем https://ru.wowhead.com/spell=108978
		[212653] = 25,		-- // Мерцание https://ru.wowhead.com/spell=212653
		[113724] = 45,		-- // Кольцо мороза https://ru.wowhead.com/spell=113724
	},
	["DEATHKNIGHT"] = {
		-- // deathknight
		-- // reviewed 2020/10/19
		[47476] 	= 60,			-- Strangulate https://ru.wowhead.com/spell=47476
		[108194] 	= 45,			-- Asphyxiate https://ru.wowhead.com/spell=108194
		[48707] 	= 60-20,		-- Anti-Magic Shell https://ru.wowhead.com/spell=48707
		[49576] 	= 25-5,			-- Death Grip	 https://ru.wowhead.com/spell=49576
		[47528] 	= 15,			-- Mind Freeze https://ru.wowhead.com/spell=47528
		[108199] 	= 120-30,		-- Gorefiend's Grasp (talent: Tightening Grasp) https://ru.wowhead.com/spell=108199
		[51052] 	= 120,			-- Anti-Magic Zone https://ru.wowhead.com/spell=51052
		[49206] 	= 180-20,		-- Summon Gargoyle https://ru.wowhead.com/spell=49206
		[48792] 	= 180-15,		-- Icebound Fortitude https://ru.wowhead.com/spell=48792
		[48743] 	= 120,			-- Death Pact https://ru.wowhead.com/spell=48743
		[77606] 	= 20,			-- Dark Simulacrum https://ru.wowhead.com/spell=77606
		[221562] 	= 45,			-- Asphyxiate https://ru.wowhead.com/spell=221562
		[49028] 	= 120-120*0.5,	-- Dancing Rune Weapon https://ru.wowhead.com/spell=49028
		[42650] 	= 480-240,		-- Army of the Dead https://ru.wowhead.com/spell=42650
		[207167] 	= 60, 			-- Blinding Sleet https://ru.wowhead.com/spell=207167
		[91802] 	= 30,			-- Shambling Rush https://www.wowhead.com/spell=91802/shambling-rush
		[48265]		= 45,			-- Поступь смерти https://ru.wowhead.com/spell=48265
		[49039]		= 120,			-- Перерождение https://ru.wowhead.com/spell=49039
		[275699]	= 90-15-45,		-- Апокалипсис https://ru.wowhead.com/spell=275699
	},
	["DRUID"] = {
		-- // reviewed 2020/10/21
		[1850] = 120,							-- Dash https://ru.wowhead.com/spell=1850
		[20484] = 600,							-- Rebirth https://ru.wowhead.com/spell=20484
		[209749] = 30,							-- Faerie Swarm https://ru.wowhead.com/spell=209749
		[202246] = 25,							-- Overrun https://ru.wowhead.com/spell=202246
		[22812] = 60 - 60/100*33 - 60/100*10,	-- Barkskin https://ru.wowhead.com/spell=22812
		[194223] = 180 - 180/100*30,			-- Celestial Alignment https://ru.wowhead.com/spell=194223
		[78675] = 60-20,						-- Solar Beam https://ru.wowhead.com/spell=78675
		[106951] = 180 - 180/100*30,			-- Berserk https://ru.wowhead.com/spell=106951
		[50334] = 180 - 180/100*30,				-- Berserk https://ru.wowhead.com/spell=50334
		[22570] = 20,							-- Maim https://ru.wowhead.com/spell=22570
		[61336] = 180,							-- Survival Instincts x2 https://ru.wowhead.com/spell=61336
		[102342] = 90,							-- Ironbark https://ru.wowhead.com/spell=102342
		[740] = 180 - 180/100*30 - 60,			-- Tranquility https://ru.wowhead.com/spell=740
		[102793] = 60,							-- Ursol's Vortex https://ru.wowhead.com/spell=102793
		[102560] = 180 - 180/100*30,			-- Incarnation: Chosen of Elune https://ru.wowhead.com/spell=102560
		[108238] = 90,							-- Renewal https://ru.wowhead.com/spell=108238
		[102543] = 180 - 180/100*30,			-- Incarnation: King of the Jungle https://ru.wowhead.com/spell=102543
		[102558] = 180 - 180/100*30,			-- Incarnation: Guardian of Ursoc https://ru.wowhead.com/spell=102558
		[33891] = 180 - 180/100*30,				-- Incarnation: Tree of Life https://ru.wowhead.com/spell=33891
		[106839] = 15,							-- Skull Bash https://ru.wowhead.com/spell=106839
		[5211]	= 60 - 60/100*10,				-- Mighty Bash https://ru.wowhead.com/spell=5211
		[132469] = 30,							-- Typhoon https://www.wowhead.com/spell=132469/typhoon https://ru.wowhead.com/spell=132469
		[102359] = 30 - 30/100*10,				-- Mass Entanglement https://www.wowhead.com/spell=102359/mass-entanglement https://ru.wowhead.com/spell=102359
		[99] = 30,								-- Парализующий рык https://ru.wowhead.com/spell=99
		[319454] = 300,							-- Сердце дикой природы https://ru.wowhead.com/spell=319454
	},
	["MONK"] = {
		-- // reviewed 2020/10/22
		[202370] = 30,					-- Mighty Ox Kick https://ru.wowhead.com/spell=202370
		[116705] = 15,					-- Spear Hand Strike https://ru.wowhead.com/spell=116705
		[115176] = 300 - 300/100*75,	-- Zen Meditation https://ru.wowhead.com/spell=115176
		[122470] = 90-30,				-- Touch of Karma https://ru.wowhead.com/spell=122470
		[116849] = 120-25-30,			-- Life Cocoon https://ru.wowhead.com/spell=116849
		[123904] = 120-30,				-- Invoke Xuen, the White Tiger https://ru.wowhead.com/spell=123904
		[198898] = 30,					-- Song of Chi-Ji https://ru.wowhead.com/spell=198898
		[115078] = 45-15,				-- Paralysis https://ru.wowhead.com/spell=115078
		[119996] = 45-20,				-- Transcendence: Transfer https://ru.wowhead.com/spell=119996
		[152173] = 90,					-- Serenity https://ru.wowhead.com/spell=152173
		[122278] = 120,					-- Dampen Harm https://ru.wowhead.com/spell=122278
		[122783] = 90,					-- Diffuse Magic https://ru.wowhead.com/spell=122783
		[119381] = 60-10-5,				-- Leg Sweep https://www.wowhead.com/spell=119381
		[116844] = 45-15,				-- Ring of Peace https://www.wowhead.com/spell=116844
		[322109] = 180-36,				-- Смертельное касание https://ru.wowhead.com/spell=322109
		[233759] = 45,					-- Захват оружия https://ru.wowhead.com/spell=233759
		[209584] = 45,					-- Чай дзен-концентрации https://ru.wowhead.com/spell=209584
	},
	["PALADIN"] = {
		-- // reviewed 2020/10/23
		[642] = 300 - 300/100*60,		-- Божественный щит https://ru.wowhead.com/spell=642
		[1044] = 25 - 25/100*25,		-- Благословенная свобода https://ru.wowhead.com/spell=1044
		[633] = 600-300,				-- Возложение рук https://ru.wowhead.com/spell=633
		[216331] = 120,					-- Рыцарь-мститель https://ru.wowhead.com/spell=216331
		[228049] = 180,					-- Страж забытой королевы https://ru.wowhead.com/spell=228049
		[210256] = 45,					-- Благословение святилища https://ru.wowhead.com/spell=210256
		[1022] = 300 - 300/100*25,		-- Благословение защиты https://ru.wowhead.com/spell=1022
		[31821] = 180,					-- Владение аурами https://ru.wowhead.com/spell=31821
		[498] = 30,						-- Божественная защита https://ru.wowhead.com/spell=498
		[6940] = 120 - 120/100*40,		-- Жертвенное благословение https://ru.wowhead.com/spell=6940
		[853] = 60,						-- Молот правосудия https://www.wowhead.com/spell=853
		[190784] = 60 - 60/100*50,		-- Божественный скакун https://ru.wowhead.com/spell=190784
		[31884] = 180-60,				-- Гнев карателя https://ru.wowhead.com/spell=31884
		[86659] = 300-80-5,				-- Защитник древних королей https://ru.wowhead.com/spell=86659
		[31850] = 120 - 120/100*30,		-- Ревностный защитник https://ru.wowhead.com/spell=31850
		[96231] = 15,					-- Укор https://ru.wowhead.com/spell=96231
		[105809] = 180,					-- Святой каратель https://ru.wowhead.com/spell=105809
		[204018] = 180 - 180/100*40,	-- Благословение защиты от заклинаний https://ru.wowhead.com/spell=204018
		[205191] = 60,					-- Око за око https://ru.wowhead.com/spell=205191
		[231895] = 120,					-- Священная война https://ru.wowhead.com/spell=231895
		[115750] = 90,					-- Слепящий свет https://ru.wowhead.com/spell=115750
	},
	["PRIEST"] = {
		-- // reviewed 2020/10/24
		[64044] = 45,		-- Psychic Horror https://ru.wowhead.com/spell=64044
		[8122] = 60-30,		-- Psychic Scream [-30sec] https://ru.wowhead.com/spell=8122
		[15487] = 45-15,	-- Silence https://ru.wowhead.com/spell=15487
		[47585] = 120-30,	-- Dispersion https://ru.wowhead.com/spell=47585
		[33206] = 180-120,	-- Pain Suppression [-30sec] https://ru.wowhead.com/spell=33206
		[10060] = 120,		-- Power Infusion https://ru.wowhead.com/spell=10060
		[88625] = 60,		-- Holy Word: Chastise https://ru.wowhead.com/spell=88625
		[64843] = 180,		-- Divine Hymn https://ru.wowhead.com/spell=64843
		[73325] = 90,		-- Leap of Faith https://ru.wowhead.com/spell=73325
		[19236] = 90,		-- Desperate Prayer https://ru.wowhead.com/spell=19236
		[62618] = 180-90,	-- Power Word: Barrier [-60sec] https://ru.wowhead.com/spell=62618
		[47788] = 180-60,	-- Guardian Spirit [-60%] [max=120sec] https://ru.wowhead.com/spell=47788
		[108968] = 300,		-- Вхождение в Бездну https://ru.wowhead.com/spell=108968
		[213602] = 45,		-- Улучшенный уход в тень https://ru.wowhead.com/spell=213602
		[205369] = 30,		-- Мыслебомба https://ru.wowhead.com/spell=205369
		[204263] = 45,		-- Сияющая мощь https://ru.wowhead.com/spell=204263
		[316262] = 90,		-- Украденные мысли https://ru.wowhead.com/spell=316262
		[328530] = 60,		-- Божественное вознесение https://ru.wowhead.com/spell=328530
		[213610] = 30,		-- Священный оберег https://ru.wowhead.com/spell=213610
	},
	["ROGUE"] = {
		-- // reviewed 2020/10/25
		[2094] = 120-30,			-- Blind https://ru.wowhead.com/spell=2094
		[1766] = 15,				-- Kick https://ru.wowhead.com/spell=1766
		[31224] = 120,				-- Cloak of Shadows https://www.wowhead.com/spell=31224
		[1856] = 120-45,			-- Vanish https://www.wowhead.com/spell=1856
		[2983] = 120-60,			-- Sprint" [-9sec] https://ru.wowhead.com/spell=2983
		[36554] = 30-5-30/100*10,	-- Shadowstep https://ru.wowhead.com/spell=36554
		[5277] = 120,				-- Evasion https://ru.wowhead.com/spell=5277
		[51690] = 120,				-- Killing Spree https://ru.wowhead.com/spell=51690
		[79140] = 120,				-- Vendetta [-30sec] https://ru.wowhead.com/spell=79140
		[13750] = 180,				-- Adrenaline Rush [-30sec] https://ru.wowhead.com/spell=13750
		[195457] = 30,				-- Абордажный крюк https://ru.wowhead.com/spell=195457
		[31230] = 360,				-- Обман смерти https://ru.wowhead.com/spell=31230
		[207777] = 45,				-- Долой оружие https://ru.wowhead.com/spell=207777
		[207736] = 120,				-- Дуэль в тенях https://ru.wowhead.com/spell=207736
		[212182] = 180,				-- Дымовая шашка https://ru.wowhead.com/spell=212182
		[198529] = 120,				-- Кража доспехов https://ru.wowhead.com/spell=198529
		[121471] = 180,				-- Теневые клинки https://ru.wowhead.com/spell=121471
		[114018] = 360,				-- Скрывающий покров ru.wowhead.com/spell=114018
		[185311] = 30-5,			-- Алый фиал https://ru.wowhead.com/spell=185311
		[185313] = 60,				-- Танец теней https://ru.wowhead.com/spell=185313
		[343142] = 90,				-- Клинки Ужаса https://ru.wowhead.com/spell=343142
	},
	["SHAMAN"] = {
		-- // reviewed 2020/10/28
		[57994] = 12-3,		-- Wind Shear https://ru.wowhead.com/spell=57994
		[51490] = 45-15,	-- Thunderstorm https://ru.wowhead.com/spell=51490
		[51485] = 30,		-- Earthbind Totem https://ru.wowhead.com/spell=51485
		[108280] = 180,		-- Healing Tide Totem https://ru.wowhead.com/spell=108280
		[98008] = 180,		-- Spirit Link Totem https://ru.wowhead.com/spell=98008
		[32182] = 60,		-- Heroism https://ru.wowhead.com/spell=32182
		[2825] = 60,		-- Bloodlust https://ru.wowhead.com/spell=2825
		[51533] = 90,		-- Feral Spirit https://ru.wowhead.com/spell=51533
		[79206] = 120-60,	-- Spiritwalker's Grace https://ru.wowhead.com/spell=79206
		[114050] = 180,		-- Elemental Ascendance https://ru.wowhead.com/spell=114050
		[114051] = 180,		-- Enhancement Ascendance https://ru.wowhead.com/spell=114051
		[114052] = 180,		-- Restoration Ascendance https://ru.wowhead.com/spell=114052
		[108271] = 90,		-- Астральный сдвиг https://ru.wowhead.com/spell=108271
		[51514] = 10,		-- Hex https://ru.wowhead.com/spell=51514
		[210873] = 10,		-- Hex https://ru.wowhead.com/spell=210873
		[211004] = 10,		-- Hex https://ru.wowhead.com/spell=211004
		[211010] = 10,		-- Hex https://ru.wowhead.com/spell=211010
		[211015] = 10,		-- Hex https://ru.wowhead.com/spell=211015
		[269352] = 10,		-- Hex https://ru.wowhead.com/spell=269352
		[277778] = 10,		-- Hex https://ru.wowhead.com/spell=277778
		[277784] = 10,		-- Hex https://ru.wowhead.com/spell=277784
		[309328] = 10,		-- Hex https://ru.wowhead.com/spell=309328
		[210918] = 45,		-- Астральный облик https://ru.wowhead.com/spell=210918
		[204336] = 30,		-- Тотем заземления https://ru.wowhead.com/spell=204336
		[204331] = 45,		-- Тотем контрудара https://ru.wowhead.com/spell=204331
		[196884] = 30,		-- Свирепый выпад https://ru.wowhead.com/spell=196884
		[192058] = 60-1,	-- Тотем выброса тока https://ru.wowhead.com/spell=192058
		[207399] = 300,		-- Тотем защиты Предков https://ru.wowhead.com/spell=207399
		[8143] = 60-1,		-- Тотем трепета https://ru.wowhead.com/spell=8143
		[305483] = 30,		-- Молния-лассо https://ru.wowhead.com/spell=305483
		[192077] = 120,		-- Тотем ветряного порыва https://ru.wowhead.com/spell=192077
		[197214] = 40,		-- Раскол https://ru.wowhead.com/spell=197214
	},
	["WARRIOR"] = {
		-- // reviewed 2020/10/30
		[100] = 20,					-- Charge https://ru.wowhead.com/spell=100
		[6552] = 15,				-- Pummel https://ru.wowhead.com/spell=6552
		[23920] = 25,				-- Spell Reflection https://ru.wowhead.com/spell=23920
		[46924] = 60,				-- Bladestorm https://ru.wowhead.com/spell=46924
		[46968] = 40-15,			-- Shockwave https://ru.wowhead.com/spell=46968
		[107574] = 90,				-- Avatar https://ru.wowhead.com/spell=107574
		[5246] = 90,				-- Intimidating Shout https://ru.wowhead.com/spell=5246
		[871] = 240-40-60,			-- Shield Wall https://ru.wowhead.com/spell=871
		[118038] = 180-60,			-- Die by the Sword https://ru.wowhead.com/spell=118038
		[1719] = 90,				-- Recklessness https://www.wowhead.com/spell=1719
		[6544] = 45-15,				-- Heroic Leap https://ru.wowhead.com/spell=6544
		[12975] = 180-180/100*80,	-- Last Stand https://ru.wowhead.com/spell=12975
		[18499] = 60,				-- Berserker Rage https://ru.wowhead.com/spell=18499
		[107570] = 30,				-- Storm Bolt https://ru.wowhead.com/spell=107570
		[227847] = 90-90/100*33,	-- Bladestorm https://ru.wowhead.com/spell=227847
		[184364] = 180-60,			-- Enraged Regeneration https://ru.wowhead.com/spell=184364
		[206572] = 20,				-- Dragon Charge https://ru.wowhead.com/spell=206572
		[236077] = 45,				-- Disarm https://ru.wowhead.com/spell=236077
		[167105] = 90-45,			-- Colossus Smash https://ru.wowhead.com/spell=167105
		[262161] = 45,				-- Warbreaker https://ru.wowhead.com/spell=262161
		[236273] = 60,				-- Duel https://ru.wowhead.com/spell=236273
		[236320] = 90,				-- War Banner https://ru.wowhead.com/spell=236320
		[198817] = 25,				-- Sharpen Blade https://ru.wowhead.com/spell=198817
		[329038] = 20,				-- Кровавая ярость https://ru.wowhead.com/spell=329038
	},
	["DEMONHUNTER"] = {
		-- // reviewed 2020/10/30
		[198589] = 60-60/100*25,			-- Blur https://ru.wowhead.com/spell=198589
		[179057] = 60-20,					-- Chaos Nova https://ru.wowhead.com/spell=179057
		[183752] = 15,						-- Consume Magic https://ru.wowhead.com/spell=183752
		[191427] = 300-60-120-300/100*15,	-- Metamorphosis https://ru.wowhead.com/spell=191427
		[187827] = 300-60-120-300/100*15,	-- Metamorphosis https://ru.wowhead.com/spell=187827
		[188501] = 60-30,					-- Spectral Sight https://ru.wowhead.com/spell=188501
		[202138] = 90-90/100*25,			-- Sigil of Chains https://ru.wowhead.com/spell=202138
		[207684] = 180-90-180/100*25,		-- Sigil of Misery https://ru.wowhead.com/spell=207684
		[202137] = 120-60-120/100*25,		-- Sigil of Silence https://ru.wowhead.com/spell=202137
		[211881] = 30,						-- Fel Eruption https://ru.wowhead.com/spell=211881
		[196555] = 180,						-- Netherwalk https://ru.wowhead.com/spell=196555
		[205629] = 20,						-- Demonic Trample https://ru.wowhead.com/spell=205629
		[205604] = 60,						-- Reverse Magic https://ru.wowhead.com/spell=205604
		[206803] = 60,						-- Rain from Above https://ru.wowhead.com/spell=206803
		[205630] = 60,						-- Illidan's Grasp https://ru.wowhead.com/spell=205630
		[217832] = 45,						-- Imprison https://www.wowhead.com/spell=217832
		[344867] = 60,						-- Кольцо Хаоса https://www.wowhead.com/spell=344867
		[206649] = 45,						-- Глаз Леотераса https://www.wowhead.com/spell=206649
	},
};

local interrupts = {
	47528,	-- // Mind Freeze
	106839,	-- // Skull Bash
	2139,	-- // Counterspell
	96231,	-- // Rebuke
	15487,	-- // Silence
	1766,	-- // Kick
	57994,	-- // Wind Shear
	6552,	-- // Pummel
	19647,	-- // Spell Lock https://ru.wowhead.com/spell=19647
	147362,	-- // Counter Shot
	116705, -- // Spear Hand Strike
	115781,	-- // Optical Blast
	183752,	-- // Consume Magic
	187707, -- // Muzzle
	91802,	-- // Shambling Rush https://www.wowhead.com/spell=91802/shambling-rush
	212619, -- // Вызов охотника Скверны
	78675,	-- // Столп солнечного света
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
		59752,
		7744,
		336126,
		283167,
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
