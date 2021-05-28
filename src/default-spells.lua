-- luacheck: no max line length
-- luacheck: globals GetBuildInfo LibStub GetSpellInfo

local _, addonTable = ...;

addonTable.CDs = {
	[addonTable.UNKNOWN_CLASS] = {
		-- // reviewed 2021/02/08
		[28730] = 120,		-- // Arcane Torrent https://ru.tbc.wowhead.com/spell=28730
		[25046] = 120,		-- // Arcane Torrent https://ru.tbc.wowhead.com/spell=25046
		[20572] = 120,		-- // Blood Fury https://ru.tbc.wowhead.com/spell=20572
		[33702] = 120,		-- // Blood Fury https://ru.tbc.wowhead.com/spell=33702
		[33697] = 120,		-- // Blood Fury https://ru.tbc.wowhead.com/spell=33697
		[26297] = 180,		-- // Berserking https://ru.tbc.wowhead.com/spell=26297
		[20594] = 120,		-- // Stoneform https://ru.tbc.wowhead.com/spell=20594
		[20589] = 60,		-- // Escape Artist https://ru.tbc.wowhead.com/spell=20589
		[7744] = 120,		-- // Will of the Forsaken https://ru.tbc.wowhead.com/spell=7744
	},
	["HUNTER"] = {
		-- // reviewed 2021/05/24
		[1543] = 20,		-- Осветительная ракета https://ru.tbc.wowhead.com/spell=1543
		[1499] = 30-4-6,	-- Замораживающая ловушка https://ru.tbc.wowhead.com/spell=1499
		[14311] = 30-4-6,	-- Замораживающая ловушка https://ru.tbc.wowhead.com/spell=14311
		[14310] = 30-4-6,	-- Замораживающая ловушка https://ru.tbc.wowhead.com/spell=14310
		[34600] = 30-4-6,	-- Змеиная ловушка https://ru.tbc.wowhead.com/spell=34600
		[3045] = 300-120,	-- Быстрая стрельба https://ru.tbc.wowhead.com/spell=3045
		[13795] = 30-4-6,	-- Обжигающая ловушка https://ru.tbc.wowhead.com/spell=13795
		[14302] = 30-4-6,	-- Обжигающая ловушка https://ru.tbc.wowhead.com/spell=14302
		[14303] = 30-4-6,	-- Обжигающая ловушка https://ru.tbc.wowhead.com/spell=14303
		[14304] = 30-4-6,	-- Обжигающая ловушка https://ru.tbc.wowhead.com/spell=14304
		[14305] = 30-4-6,	-- Обжигающая ловушка https://ru.tbc.wowhead.com/spell=14305
		[27023] = 30-4-6,	-- Обжигающая ловушка https://ru.tbc.wowhead.com/spell=27023
		[1513] = 30,		-- Отпугивание зверя https://ru.tbc.wowhead.com/spell=1513
		[14326] = 30,		-- Отпугивание зверя https://ru.tbc.wowhead.com/spell=14326
		[14327] = 30,		-- Отпугивание зверя https://ru.tbc.wowhead.com/spell=14327
		[13813] = 30-6-4,	-- Взрывная ловушка https://ru.tbc.wowhead.com/spell=13813
		[14316] = 30-6-4,	-- Взрывная ловушка https://ru.tbc.wowhead.com/spell=14316
		[14317] = 30-6-4,	-- Взрывная ловушка https://ru.tbc.wowhead.com/spell=14317
		[19574] = 120,		-- Звериный гнев https://ru.tbc.wowhead.com/spell=19574
		[34490] = 20,		-- Глушащий выстрел https://ru.tbc.wowhead.com/spell=34490
		[19503] = 30,		-- Дезориентирующий выстрел https://ru.tbc.wowhead.com/spell=19503
		[19577] = 60,		-- Устрашение https://ru.tbc.wowhead.com/spell=19577
		[19386] = 120,		-- Жало виверны https://ru.tbc.wowhead.com/spell=19386
		[24132] = 120,		-- Жало виверны https://ru.tbc.wowhead.com/spell=24132
		[24133] = 120,		-- Жало виверны https://ru.tbc.wowhead.com/spell=24133
		[27068] = 120,		-- Жало виверны https://ru.tbc.wowhead.com/spell=27068
		[23989] = 300,		-- Готовность https://ru.tbc.wowhead.com/spell=23989
		[19263] = 300,		-- Сдерживание https://ru.tbc.wowhead.com/spell=19263
		[5384] = 30-2,		-- Feign Death https://ru.tbc.wowhead.com/spell=5384/feign-death
	},
	["WARLOCK"] = {
		-- // reviewed 2021/05/25
		[6789] = 120-120/100*15,	-- Лик смерти https://ru.tbc.wowhead.com/spell=6789
		[17925] = 120-120/100*15,	-- Лик смерти https://ru.tbc.wowhead.com/spell=17925
		[17926] = 120-120/100*15,	-- Лик смерти https://ru.tbc.wowhead.com/spell=17926
		[27223] = 120-120/100*15,	-- Лик смерти https://ru.tbc.wowhead.com/spell=27223
		[6353] = 60,				-- Ожог души https://ru.tbc.wowhead.com/spell=6353
		[17924] = 60,				-- Ожог души https://ru.tbc.wowhead.com/spell=17924
		[27211] = 60,				-- Ожог души https://ru.tbc.wowhead.com/spell=27211
		[30545] = 60,				-- Ожог души https://ru.tbc.wowhead.com/spell=30545
		[5484] = 40,				-- Вой ужаса https://ru.tbc.wowhead.com/spell=5484
		[17928] = 40,				-- Вой ужаса https://ru.tbc.wowhead.com/spell=17928
		[17877] = 15,				-- Ожог Тьмы https://ru.tbc.wowhead.com/spell=17877
		[18867] = 15,				-- Ожог Тьмы https://ru.tbc.wowhead.com/spell=18867
		[18868] = 15,				-- Ожог Тьмы https://ru.tbc.wowhead.com/spell=18868
		[18869] = 15,				-- Ожог Тьмы https://ru.tbc.wowhead.com/spell=18869
		[18870] = 15,				-- Ожог Тьмы https://ru.tbc.wowhead.com/spell=18870
		[18871] = 15,				-- Ожог Тьмы https://ru.tbc.wowhead.com/spell=18871
		[27263] = 15,				-- Ожог Тьмы https://ru.tbc.wowhead.com/spell=27263
		[30546] = 15,				-- Ожог Тьмы https://ru.tbc.wowhead.com/spell=30546
		[30283] = 20,				-- Неистовство Тьмы https://ru.tbc.wowhead.com/spell=30283
		[30413] = 20,				-- Неистовство Тьмы https://ru.tbc.wowhead.com/spell=30413
		[30414] = 20,				-- Неистовство Тьмы https://ru.tbc.wowhead.com/spell=30414
		[19244] = 24,				-- Запрет чар https://ru.tbc.wowhead.com/spell=19244
		[19647] = 24,				-- Запрет чар https://ru.tbc.wowhead.com/spell=19647
		[1122] = 3600,				-- Summon Infernal https://ru.tbc.wowhead.com/spell=1122
	},
	["MAGE"] = {
		-- reviewed 2021/05/25
		[45438] = 300 - 300*0.2 - 40,	-- Ледяная глыба https://ru.tbc.wowhead.com/spell=45438
		[66] = 300,						-- Невидимость https://ru.tbc.wowhead.com/spell=66
		[1953] = 15 - 2,				-- Скачок https://ru.tbc.wowhead.com/spell=1953
		[12051] = 480 - 60,				-- Прилив сил https://ru.tbc.wowhead.com/spell=12051
		[2139] = 24 - 2,				-- Антимагия https://ru.tbc.wowhead.com/spell=2139
		[543] = 30,						-- Защита от огня https://ru.tbc.wowhead.com/spell=543
		[8457] = 30,					-- Защита от огня https://ru.tbc.wowhead.com/spell=8457
		[8458] = 30,					-- Защита от огня https://ru.tbc.wowhead.com/spell=8458
		[10223] = 30,					-- Защита от огня https://ru.tbc.wowhead.com/spell=10223
		[10225] = 30,					-- Защита от огня https://ru.tbc.wowhead.com/spell=10225
		[27128] = 30,					-- Защита от огня https://ru.tbc.wowhead.com/spell=27128
		[122] = 25 - 4,					-- Кольцо льда https://ru.tbc.wowhead.com/spell=122
		[865] = 25 - 4,					-- Кольцо льда https://ru.tbc.wowhead.com/spell=865
		[6131] = 25 - 4,				-- Кольцо льда https://ru.tbc.wowhead.com/spell=6131
		[10230] = 25 - 4,				-- Кольцо льда https://ru.tbc.wowhead.com/spell=10230
		[27088] = 25 - 4,				-- Кольцо льда https://ru.tbc.wowhead.com/spell=27088
		[31687] = 300,					-- Призыв элементаля воды https://ru.tbc.wowhead.com/spell=31687
		[12472] = 180,					-- Стылая кровь https://ru.tbc.wowhead.com/spell=12472
		[11426] = 30 - 30*0.2,			-- Ледяная преграда https://ru.tbc.wowhead.com/spell=11426
		[13031] = 30 - 30*0.2,			-- Ледяная преграда https://ru.tbc.wowhead.com/spell=13031
		[13032] = 30 - 30*0.2,			-- Ледяная преграда https://ru.tbc.wowhead.com/spell=13032
		[13033] = 30 - 30*0.2,			-- Ледяная преграда https://ru.tbc.wowhead.com/spell=13033
		[27134] = 30 - 30*0.2,			-- Ледяная преграда https://ru.tbc.wowhead.com/spell=27134
		[33405] = 30 - 30*0.2,			-- Ледяная преграда https://ru.tbc.wowhead.com/spell=33405
		[11129] = 180,					-- Возгорание https://ru.tbc.wowhead.com/spell=11129
		[31661] = 20,					-- Дыхание дракона https://ru.tbc.wowhead.com/spell=31661
		[33041] = 20,					-- Дыхание дракона https://ru.tbc.wowhead.com/spell=33041
		[33042] = 20,					-- Дыхание дракона https://ru.tbc.wowhead.com/spell=33042
		[33043] = 20,					-- Дыхание дракона https://ru.tbc.wowhead.com/spell=33043
		[12042] = 180,					-- Мощь тайной магии https://ru.tbc.wowhead.com/spell=12042
		[12043] = 180 - 24,				-- Присутствие разума https://ru.tbc.wowhead.com/spell=12043
		[11113] = 30 - 4,				-- Взрывная волна https://ru.tbc.wowhead.com/spell=11113
		[13018] = 30 - 4,				-- Взрывная волна https://ru.tbc.wowhead.com/spell=13018
		[13019] = 30 - 4,				-- Взрывная волна https://ru.tbc.wowhead.com/spell=13019
		[13020] = 30 - 4,				-- Взрывная волна https://ru.tbc.wowhead.com/spell=13020
		[13021] = 30 - 4,				-- Взрывная волна https://ru.tbc.wowhead.com/spell=13021
		[27133] = 30 - 4,				-- Взрывная волна https://ru.tbc.wowhead.com/spell=27133
		[33933] = 30 - 4,				-- Взрывная волна https://ru.tbc.wowhead.com/spell=33933
	},
	["DRUID"] = {
		-- // reviewed 2021/05/26
		[22812] = 60,			-- Дубовая кожа https://ru.tbc.wowhead.com/spell=22812
		[5211] = 60,			-- Оглушить https://ru.tbc.wowhead.com/spell=5211
		[6798] = 60,			-- Оглушить https://ru.tbc.wowhead.com/spell=6798
		[8983] = 60,			-- Оглушить https://ru.tbc.wowhead.com/spell=8983
		[20484] = 1200 - 300,	-- Возрождение https://ru.tbc.wowhead.com/spell=20484
		[20739] = 1200 - 300,	-- Возрождение https://ru.tbc.wowhead.com/spell=20739
		[20742] = 1200 - 300,	-- Возрождение https://ru.tbc.wowhead.com/spell=20742
		[20747] = 1200 - 300,	-- Возрождение https://ru.tbc.wowhead.com/spell=20747
		[20748] = 1200 - 300,	-- Возрождение https://ru.tbc.wowhead.com/spell=20748
		[26994] = 1200 - 300,	-- Возрождение https://ru.tbc.wowhead.com/spell=26994
		[740] = 600 - 300,		-- Спокойствие https://ru.tbc.wowhead.com/spell=740
		[8918] = 600 - 300,		-- Спокойствие https://ru.tbc.wowhead.com/spell=8918
		[9862] = 600 - 300,		-- Спокойствие https://ru.tbc.wowhead.com/spell=9862
		[9863] = 600 - 300,		-- Спокойствие https://ru.tbc.wowhead.com/spell=9863
		[26983] = 600 - 300,	-- Спокойствие https://ru.tbc.wowhead.com/spell=26983
		[22842] = 180,			-- Неистовое восстановление	https://ru.tbc.wowhead.com/spell=22842
		[22895] = 180,			-- Неистовое восстановление	https://ru.tbc.wowhead.com/spell=22895
		[22896] = 180,			-- Неистовое восстановление	https://ru.tbc.wowhead.com/spell=22896
		[26999] = 180,			-- Неистовое восстановление	https://ru.tbc.wowhead.com/spell=26999
		[33831] = 180,			-- Сила Природы https://ru.tbc.wowhead.com/spell=33831
		[16979] = 15,			-- Звериная атака https://ru.tbc.wowhead.com/spell=16979
		[17116] = 180 - 24,		-- Природная стремительность https://ru.tbc.wowhead.com/spell=17116
		[16689] = 60,			-- Природный захват https://ru.tbc.wowhead.com/spell=16689
		[16810] = 60,			-- Природный захват https://ru.tbc.wowhead.com/spell=16810
		[16811] = 60,			-- Природный захват https://ru.tbc.wowhead.com/spell=16811
		[16812] = 60,			-- Природный захват https://ru.tbc.wowhead.com/spell=16812
		[16813] = 60,			-- Природный захват https://ru.tbc.wowhead.com/spell=16813
		[17329] = 60,			-- Природный захват https://ru.tbc.wowhead.com/spell=17329
		[27009] = 60,			-- Природный захват https://ru.tbc.wowhead.com/spell=27009
		[1850] = 300,			-- Порыв https://ru.tbc.wowhead.com/spell=1850
		[9821] = 300,			-- Порыв https://ru.tbc.wowhead.com/spell=9821
		[33357] = 300,			-- Порыв https://ru.tbc.wowhead.com/spell=33357
	},
	["PALADIN"] = {
		-- // reviewed 2021/05/27
		[31884] = 180,					-- Гнев карателя https://ru.tbc.wowhead.com/spell=31884
		[19752] = 3600,					-- Божественное вмешательство https://ru.tbc.wowhead.com/spell=19752
		[642] = 300 - 60,				-- Божественный щит https://ru.tbc.wowhead.com/spell=642
		[1020] = 300 - 60,				-- Божественный щит https://ru.tbc.wowhead.com/spell=1020
		[1044] = 25,					-- Благословение cвободы https://ru.tbc.wowhead.com/spell=1044
		[498] = 300,					-- Божественная защита https://ru.tbc.wowhead.com/spell=498
		[5573] = 300,					-- Божественная защита https://ru.tbc.wowhead.com/spell=5573
		[1022] = 300 - 120,				-- Благословение защиты https://ru.tbc.wowhead.com/spell=1022
		[5599] = 300 - 120,				-- Благословение защиты https://ru.tbc.wowhead.com/spell=5599
		[10278] = 300 - 120,			-- Благословение защиты https://ru.tbc.wowhead.com/spell=10278
		[10326] = 30,					-- Изгнание зла https://ru.tbc.wowhead.com/spell=10326
		[6940] = 30,					-- Благословение жертвенности https://ru.tbc.wowhead.com/spell=6940
		[20729] = 30,					-- Благословение жертвенности https://ru.tbc.wowhead.com/spell=20729
		[27147] = 30,					-- Благословение жертвенности https://ru.tbc.wowhead.com/spell=27147
		[27148] = 30,					-- Благословение жертвенности https://ru.tbc.wowhead.com/spell=27148
		[853] = 60 - 15 - 10,			-- Молот правосудия https://ru.tbc.wowhead.com/spell=853
		[5588] = 60 - 15 - 10,			-- Молот правосудия https://ru.tbc.wowhead.com/spell=5588
		[5589] = 60 - 15 - 10,			-- Молот правосудия https://ru.tbc.wowhead.com/spell=5589
		[10308] = 60 - 15 - 10,			-- Молот правосудия https://ru.tbc.wowhead.com/spell=10308
		[633] = 3600 - 20*60 - 12*60,	-- Возложение рук https://ru.tbc.wowhead.com/spell=633
		[2800] = 3600 - 20*60 - 12*60,	-- Возложение рук https://ru.tbc.wowhead.com/spell=2800
		[10310] = 3600 - 20*60 - 12*60,	-- Возложение рук https://ru.tbc.wowhead.com/spell=10310
		[27154] = 3600 - 20*60 - 12*60,	-- Возложение рук https://ru.tbc.wowhead.com/spell=27154
		[2878] = 30,					-- Изгнание нежити https://ru.tbc.wowhead.com/spell=2878
		[5627] = 30,					-- Изгнание нежити https://ru.tbc.wowhead.com/spell=5627
		[20066] = 60,					-- Покаяние https://ru.tbc.wowhead.com/spell=20066
	},
	["PRIEST"] = {
		-- // reviewed 2021/05/28
		[6346] = 180,			-- Защита от страха https://ru.tbc.wowhead.com/spell=6346
		[34433] = 300,			-- Исчадие Тьмы https://ru.tbc.wowhead.com/spell=34433
		[2651] = 180,			-- Благодать Элуны https://ru.tbc.wowhead.com/spell=2651
		[44041] = 30,			-- Воздаяние https://ru.tbc.wowhead.com/spell=44041
		[44043] = 30,			-- Воздаяние https://ru.tbc.wowhead.com/spell=44043
		[44044] = 30,			-- Воздаяние https://ru.tbc.wowhead.com/spell=44044
		[44045] = 30,			-- Воздаяние https://ru.tbc.wowhead.com/spell=44045
		[44046] = 30,			-- Воздаяние https://ru.tbc.wowhead.com/spell=44046
		[44047] = 30,			-- Воздаяние https://ru.tbc.wowhead.com/spell=44047
		[586] = 30 - 2 - 6,		-- Уход в тень https://ru.tbc.wowhead.com/spell=586
		[9578] = 30 - 2 - 6,	-- Уход в тень https://ru.tbc.wowhead.com/spell=9578
		[9579] = 30 - 2 - 6,	-- Уход в тень https://ru.tbc.wowhead.com/spell=9579
		[9592] = 30 - 2 - 6,	-- Уход в тень https://ru.tbc.wowhead.com/spell=9592
		[10941] = 30 - 2 - 6,	-- Уход в тень https://ru.tbc.wowhead.com/spell=10941
		[10942] = 30 - 2 - 6,	-- Уход в тень https://ru.tbc.wowhead.com/spell=10942
		[25429] = 30 - 2 - 6,	-- Уход в тень https://ru.tbc.wowhead.com/spell=25429
		[13908] = 600,			-- Молитва отчаяния https://ru.tbc.wowhead.com/spell=13908
		[19236] = 600,			-- Молитва отчаяния https://ru.tbc.wowhead.com/spell=19236
		[19238] = 600,			-- Молитва отчаяния https://ru.tbc.wowhead.com/spell=19238
		[19240] = 600,			-- Молитва отчаяния https://ru.tbc.wowhead.com/spell=19240
		[19241] = 600,			-- Молитва отчаяния https://ru.tbc.wowhead.com/spell=19241
		[19242] = 600,			-- Молитва отчаяния https://ru.tbc.wowhead.com/spell=19242
		[19243] = 600,			-- Молитва отчаяния https://ru.tbc.wowhead.com/spell=19243
		[25437] = 600,			-- Молитва отчаяния https://ru.tbc.wowhead.com/spell=25437
		[8122] = 30 - 3,		-- Ментальный крик https://ru.tbc.wowhead.com/spell=8122
		[8124] = 30 - 3,		-- Ментальный крик https://ru.tbc.wowhead.com/spell=8124
		[10888] = 30 - 3,		-- Ментальный крик https://ru.tbc.wowhead.com/spell=10888
		[10890] = 30 - 3,		-- Ментальный крик https://ru.tbc.wowhead.com/spell=10890
		[13896] = 180,			-- Ответная реакция https://ru.tbc.wowhead.com/spell=13896
		[19271] = 180,			-- Ответная реакция https://ru.tbc.wowhead.com/spell=19271
		[19273] = 180,			-- Ответная реакция https://ru.tbc.wowhead.com/spell=19273
		[19274] = 180,			-- Ответная реакция https://ru.tbc.wowhead.com/spell=19274
		[19275] = 180,			-- Ответная реакция https://ru.tbc.wowhead.com/spell=19275
		[25441] = 180,			-- Ответная реакция https://ru.tbc.wowhead.com/spell=25441
		[15487] = 45,			-- Молчание https://ru.tbc.wowhead.com/spell=15487
		[14751] = 180,			-- Внутреннее сосредоточение https://ru.tbc.wowhead.com/spell=14751
		[10060] = 180,			-- Придание сил https://ru.tbc.wowhead.com/spell=10060
		[33206] = 120,			-- Подавление боли https://ru.tbc.wowhead.com/spell=33206
	},
	["ROGUE"] = {
		-- // reviewed 2021/02/16
		[2094] = 120-30,			-- Blind https://ru.tbc.wowhead.com/spell=2094
		[1766] = 15,				-- Kick https://ru.tbc.wowhead.com/spell=1766
		[31224] = 120,				-- Cloak of Shadows https://ru.tbc.wowhead.com/spell=31224
		[1856] = 120-45,			-- Vanish https://ru.tbc.wowhead.com/spell=1856
		[2983] = 120-60,			-- Sprint" [-9sec] https://ru.tbc.wowhead.com/spell=2983
		[36554] = 30 - 30/100*10,	-- Shadowstep https://ru.tbc.wowhead.com/spell=36554
		[5277] = 120,				-- Evasion https://ru.tbc.wowhead.com/spell=5277
		[51690] = 120,				-- Killing Spree https://ru.tbc.wowhead.com/spell=51690
		[79140] = 120,				-- Vendetta [-30sec] https://ru.tbc.wowhead.com/spell=79140
		[13750] = 180,				-- Adrenaline Rush [-30sec] https://ru.tbc.wowhead.com/spell=13750
		[195457] = 60-15-15-6,		-- Абордажный крюк https://ru.tbc.wowhead.com/spell=195457
		[31230] = 360,				-- Обман смерти https://ru.tbc.wowhead.com/spell=31230
		[207777] = 45,				-- Долой оружие https://ru.tbc.wowhead.com/spell=207777
		[207736] = 120,				-- Дуэль в тенях https://ru.tbc.wowhead.com/spell=207736
		[212182] = 180,				-- Дымовая шашка https://ru.tbc.wowhead.com/spell=212182
		[198529] = 120,				-- Кража доспехов https://ru.tbc.wowhead.com/spell=198529
		[121471] = 180,				-- Теневые клинки https://ru.tbc.wowhead.com/spell=121471
		[114018] = 360,				-- Скрывающий покров https://ru.tbc.wowhead.com/spell=114018
		[185311] = 30,				-- Алый фиал https://ru.tbc.wowhead.com/spell=185311
		[185313] = 60,				-- Танец теней https://ru.tbc.wowhead.com/spell=185313
		[343142] = 90,				-- Клинки Ужаса https://ru.tbc.wowhead.com/spell=343142
		[137619] = 60,				-- Marked for Death https://ru.tbc.wowhead.com/spell=137619/marked-for-death
		[408] = 20,					-- Kidney Shot https://ru.tbc.wowhead.com/spell=408/kidney-shot
		[1776] = 15,				-- Gouge https://ru.tbc.wowhead.com/spell=1776/gouge
		[315341] = 45,				-- Between the Eyes https://ru.tbc.wowhead.com/spell=315341/between-the-eyes
		[323547] = 45,				-- Echoing Reprimand https://ru.tbc.wowhead.com/spell=323547/echoing-reprimand
		[328305] = 90,				-- Sepsis https://ru.tbc.wowhead.com/spell=328305/sepsis
		[323654] = 90,				-- Flagellation https://ru.tbc.wowhead.com/spell=323654/flagellation
		[328547] = 30,				-- Serrated Bone Spike https://ru.tbc.wowhead.com/spell=328547/serrated-bone-spike
	},
	["SHAMAN"] = {
		-- // reviewed 2021/02/17
		[57994] = 12,		-- Wind Shear https://ru.tbc.wowhead.com/spell=57994
		[51490] = 45-15,	-- Thunderstorm https://ru.tbc.wowhead.com/spell=51490
		[51485] = 30,		-- Earthbind Totem https://ru.tbc.wowhead.com/spell=51485
		[108280] = 180,		-- Healing Tide Totem https://ru.tbc.wowhead.com/spell=108280
		[98008] = 180,		-- Spirit Link Totem https://ru.tbc.wowhead.com/spell=98008
		[32182] = 60,		-- Heroism https://ru.tbc.wowhead.com/spell=32182
		[2825] = 60,		-- Bloodlust https://ru.tbc.wowhead.com/spell=2825
		[51533] = 90,		-- Feral Spirit https://ru.tbc.wowhead.com/spell=51533
		[79206] = 120-60,	-- Spiritwalker's Grace https://ru.tbc.wowhead.com/spell=79206
		[114050] = 180,		-- Elemental Ascendance https://ru.tbc.wowhead.com/spell=114050
		[114051] = 180,		-- Enhancement Ascendance https://ru.tbc.wowhead.com/spell=114051
		[114052] = 180,		-- Restoration Ascendance https://ru.tbc.wowhead.com/spell=114052
		[108271] = 90,		-- Астральный сдвиг https://ru.tbc.wowhead.com/spell=108271
		[51514] = 10,		-- Hex https://ru.tbc.wowhead.com/spell=51514
		[210873] = 10,		-- Hex https://ru.tbc.wowhead.com/spell=210873
		[211004] = 10,		-- Hex https://ru.tbc.wowhead.com/spell=211004
		[211010] = 10,		-- Hex https://ru.tbc.wowhead.com/spell=211010
		[211015] = 10,		-- Hex https://ru.tbc.wowhead.com/spell=211015
		[269352] = 10,		-- Hex https://ru.tbc.wowhead.com/spell=269352
		[277778] = 10,		-- Hex https://ru.tbc.wowhead.com/spell=277778
		[277784] = 10,		-- Hex https://ru.tbc.wowhead.com/spell=277784
		[309328] = 10,		-- Hex https://ru.tbc.wowhead.com/spell=309328
		[210918] = 45,		-- Астральный облик https://ru.tbc.wowhead.com/spell=210918
		[204336] = 30,		-- Тотем заземления https://ru.tbc.wowhead.com/spell=204336
		[204331] = 45,		-- Тотем контрудара https://ru.tbc.wowhead.com/spell=204331
		[196884] = 30,		-- Свирепый выпад https://ru.tbc.wowhead.com/spell=196884
		[192058] = 60,		-- Тотем выброса тока https://ru.tbc.wowhead.com/spell=192058
		[207399] = 300,		-- Тотем защиты Предков https://ru.tbc.wowhead.com/spell=207399
		[8143] = 60,		-- Тотем трепета https://ru.tbc.wowhead.com/spell=8143
		[305483] = 30,		-- Молния-лассо https://ru.tbc.wowhead.com/spell=305483
		[192077] = 120,		-- Тотем ветряного порыва https://ru.tbc.wowhead.com/spell=192077
		[197214] = 40,		-- Раскол https://ru.tbc.wowhead.com/spell=197214
		[191634] = 60,		-- Stormkeeper https://ru.tbc.wowhead.com/spell=191634/stormkeeper
		[198838] = 60,		-- Earthen Wall Totem https://ru.tbc.wowhead.com/spell=198838/earthen-wall-totem
		[320674] = 90,		-- Chain Harvest https://ru.tbc.wowhead.com/spell=320674/chain-harvest
		[77130] = 8,		-- Purify Spirit https://ru.tbc.wowhead.com/spell=77130/purify-spirit
		[326059] = 45,		-- Primordial Wave https://ru.tbc.wowhead.com/spell=326059/primordial-wave
		[328923] = 120,		-- Fae Transfusion https://ru.tbc.wowhead.com/spell=328923/fae-transfusion
		[324386] = 60,		-- Vesper Totem https://ru.tbc.wowhead.com/spell=324386/vesper-totem
	},
	["WARRIOR"] = {
		-- // reviewed 2021/02/12
		[100] = 20,					-- Charge https://ru.tbc.wowhead.com/spell=100
		[6552] = 15,				-- Pummel https://ru.tbc.wowhead.com/spell=6552
		[23920] = 25,				-- Spell Reflection https://ru.tbc.wowhead.com/spell=23920
		[46924] = 60,				-- Bladestorm https://ru.tbc.wowhead.com/spell=46924
		[46968] = 40,				-- Shockwave https://ru.tbc.wowhead.com/spell=46968
		[107574] = 90,				-- Avatar https://ru.tbc.wowhead.com/spell=107574
		[5246] = 90,				-- Intimidating Shout https://ru.tbc.wowhead.com/spell=5246
		[871] = 240,				-- Shield Wall https://ru.tbc.wowhead.com/spell=871
		[118038] = 180-60-20,		-- Die by the Sword https://ru.tbc.wowhead.com/spell=118038
		[1719] = 90,				-- Recklessness https://ru.tbc.wowhead.com/spell=1719
		[6544] = 45,				-- Heroic Leap https://ru.tbc.wowhead.com/spell=6544
		[12975] = 180-60,			-- Last Stand https://ru.tbc.wowhead.com/spell=12975
		[18499] = 60,				-- Berserker Rage https://ru.tbc.wowhead.com/spell=18499
		[107570] = 30,				-- Storm Bolt https://ru.tbc.wowhead.com/spell=107570
		[227847] = 90-90/100*33,	-- Bladestorm https://ru.tbc.wowhead.com/spell=227847
		[184364] = 180-60,			-- Enraged Regeneration https://ru.tbc.wowhead.com/spell=184364
		[206572] = 20,				-- Dragon Charge https://ru.tbc.wowhead.com/spell=206572
		[236077] = 45,				-- Disarm https://ru.tbc.wowhead.com/spell=236077
		[167105] = 90-45,			-- Colossus Smash https://ru.tbc.wowhead.com/spell=167105
		[262161] = 45,				-- Warbreaker https://ru.tbc.wowhead.com/spell=262161
		[236273] = 60,				-- Duel https://ru.tbc.wowhead.com/spell=236273
		[236320] = 90,				-- War Banner https://ru.tbc.wowhead.com/spell=236320
		[198817] = 25,				-- Sharpen Blade https://ru.tbc.wowhead.com/spell=198817
		[329038] = 20,				-- Кровавая ярость https://ru.tbc.wowhead.com/spell=329038
		[307865] = 60,				-- Spear of Bastion https://ru.tbc.wowhead.com/spell=307865/spear-of-bastion
		[97462] = 180-120,			-- Rallying Cry https://ru.tbc.wowhead.com/spell=97462/rallying-cry#modified-by
		[3411] = 30,				-- Intervene https://ru.tbc.wowhead.com/spell=3411/intervene
	},
};

addonTable.Interrupts = {
	[34490] = true,	-- Глушащий выстрел https://ru.tbc.wowhead.com/spell=34490
	[19244] = true,	-- Запрет чар https://ru.tbc.wowhead.com/spell=19244
	[19647] = true,	-- Запрет чар https://ru.tbc.wowhead.com/spell=19647
	[2139] = true,	-- Антимагия https://ru.tbc.wowhead.com/spell=2139
	[16979] = true,	-- Звериная атака https://ru.tbc.wowhead.com/spell=16979
	[15487] = true,	-- Молчание https://ru.tbc.wowhead.com/spell=15487


	[47528] = true,	-- // Mind Freeze
	[106839] = true,	-- // Skull Bash
	[96231] = true,	-- // Rebuke
	[1766] = true,	-- // Kick
	[57994] = true,	-- // Wind Shear
	[6552] = true,	-- // Pummel
	[147362] = true,	-- // Counter Shot
	[116705] = true, -- // Spear Hand Strike
	[115781] = true,	-- // Optical Blast
	[183752] = true,	-- // Consume Magic
	[187707] = true, -- // Muzzle
	[91802] = true,	-- // Shambling Rush https://ru.tbc.wowhead.com/spell=91802/shambling-rush
	[212619] = true, -- // Вызов охотника Скверны
	[78675] = true,	-- // Столп солнечного света
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

	local allHunterSpells = {};
	for spellId in pairs(addonTable.CDs.HUNTER) do
		if (spellId ~= 23989) then
			allHunterSpells[#allHunterSpells + 1] = spellId;
		end
	end

	local allMageSpells = {};
	for spellId in pairs(addonTable.CDs.MAGE) do
		if (spellId ~= 12472) then
			allMageSpells[#allMageSpells + 1] = spellId;
		end
	end

	addonTable.Reductions = {
		[23989] = {	-- HUNTER: Готовность https://ru.tbc.wowhead.com/spell=23989
			["reduction"] = BIG_REDUCTION,
			["spells"] = allHunterSpells,
		},
		[12472] = {	-- MAGE: Стылая кровь https://ru.tbc.wowhead.com/spell=12472
			["reduction"] = BIG_REDUCTION,
			["spells"] = allMageSpells,
		},

		-- [275773] = { -- // holy paladin's judgment https://www.wowhead.com/spell=275773/judgment
			-- ["reduction"] = 10,
			-- ["spells"] = { 853 },
		-- },
		-- [275779] = { -- // protection paladin's judgment https://ru.tbc.wowhead.com/spell=275779/judgment
			-- ["reduction"] = 6,
			-- ["spells"] = { 853 },
		-- },
		[195676] = { -- // Displacement https://ru.tbc.wowhead.com/spell=195676/%D1%81%D0%BC%D0%B5%D1%89%D0%B5%D0%BD%D0%B8%D0%B5
			["reduction"] = BIG_REDUCTION,
			["spells"] = { 1953 }, -- // Blink
		},
		[235219] = { -- // Cold Snap https://ru.tbc.wowhead.com/spell=235219/%D1%85%D0%BE%D0%BB%D0%BE%D0%B4%D0%BD%D0%B0%D1%8F-%D1%85%D0%B2%D0%B0%D1%82%D0%BA%D0%B0
			["reduction"] = BIG_REDUCTION,
			["spells"] = {
				122,			-- // Frost Nova
				120,			-- // Cone of Cold
				11426,			-- // Ice Barrier
				45438,			-- // Ice Block
			},
		},
		[115203] = { -- // Fortifying Brew https://ru.tbc.wowhead.com/spell=115203/fortifying-brew
			["reduction"] = -120,
			["spells"] = {
				243435,			-- // Fortifying Brew https://ru.tbc.wowhead.com/spell=243435/fortifying-brew
			},
		},
		[585] = {	-- Кара https://ru.tbc.wowhead.com/spell=585/%D0%BA%D0%B0%D1%80%D0%B0
			["reduction"] = -4,
			["spells"] = {
				88625,	-- Holy Word: Chastise https://ru.tbc.wowhead.com/spell=88625
			},
		},
	};

end