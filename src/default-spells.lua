-- luacheck: no max line length
-- luacheck: globals GetBuildInfo LibStub GetSpellInfo

local _, addonTable = ...;

addonTable.CDs = {
	[addonTable.UNKNOWN_CLASS] = {
		-- // reviewed 2021/05/31
		[42292] = 120,		-- PvP trinket
		[28730] = 120,		-- // Arcane Torrent https://ru.tbc.wowhead.com/spell=28730
		[25046] = 120,		-- // Arcane Torrent https://ru.tbc.wowhead.com/spell=25046
		[20572] = 120,		-- // Blood Fury https://ru.tbc.wowhead.com/spell=20572
		[33702] = 120,		-- // Blood Fury https://ru.tbc.wowhead.com/spell=33702
		[33697] = 120,		-- // Blood Fury https://ru.tbc.wowhead.com/spell=33697
		[7744] = 120,		-- // Will of the Forsaken https://ru.tbc.wowhead.com/spell=7744
		[20549] = 120,		-- Громовая поступь https://ru.tbc.wowhead.com/spell=20549
		[20554] = 180,		-- Боевое исступление https://ru.tbc.wowhead.com/spell=20554
		[26296] = 180,		-- Боевое исступление https://ru.tbc.wowhead.com/spell=26296
		[26297] = 180,		-- Боевое исступление https://ru.tbc.wowhead.com/spell=26297
		[20589] = 1.75*60,	-- Мастер побега https://ru.tbc.wowhead.com/spell=20589
		[20594] = 180,		-- Каменная форма https://ru.tbc.wowhead.com/spell=20594
		[20600] = 180,		-- Внимательность https://ru.tbc.wowhead.com/spell=20600
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
		-- // reviewed 2021/05/29
		[31224] = 60,	-- Плащ теней https://ru.tbc.wowhead.com/spell=31224
		[2094] = 180 - 90 - 5,	-- Ослепление https://ru.tbc.wowhead.com/spell=2094
		[1856] = 300 - 90 - 30,	-- Исчезновение https://ru.tbc.wowhead.com/spell=1856
		[1857] = 300 - 90 - 30,	-- Исчезновение https://ru.tbc.wowhead.com/spell=1857
		[26889] = 300 - 90 - 30,	-- Исчезновение https://ru.tbc.wowhead.com/spell=26889
		[408] = 20,					-- Удар по почкам https://ru.tbc.wowhead.com/spell=408
		[8643] = 20,				-- Удар по почкам https://ru.tbc.wowhead.com/spell=8643
		[1766] = 10 - 0.5,			-- Пинок https://ru.tbc.wowhead.com/spell=1766
		[1767] = 10 - 0.5,			-- Пинок https://ru.tbc.wowhead.com/spell=1767
		[1768] = 10 - 0.5,			-- Пинок https://ru.tbc.wowhead.com/spell=1768
		[1769] = 10 - 0.5,			-- Пинок https://ru.tbc.wowhead.com/spell=1769
		[38768] = 10 - 0.5,			-- Пинок https://ru.tbc.wowhead.com/spell=38768
		[2983] = 300 - 90,			-- Спринт https://ru.tbc.wowhead.com/spell=2983
		[8696] = 300 - 90,			-- Спринт https://ru.tbc.wowhead.com/spell=8696
		[11305] = 300 - 90,			-- Спринт https://ru.tbc.wowhead.com/spell=11305
		[5277] = 300 - 90,			-- Ускользание https://ru.tbc.wowhead.com/spell=5277
		[26669] = 300 - 90,			-- Ускользание https://ru.tbc.wowhead.com/spell=26669
		[1784] = 10 - 5,			-- Незаметность https://ru.tbc.wowhead.com/spell=1784
		[1785] = 10 - 5,			-- Незаметность https://ru.tbc.wowhead.com/spell=1785
		[1786] = 10 - 5,			-- Незаметность https://ru.tbc.wowhead.com/spell=1786
		[1787] = 10 - 5,			-- Незаметность https://ru.tbc.wowhead.com/spell=1787
		[1776] = 10,				-- Парализующий удар https://ru.tbc.wowhead.com/spell=1776
		[1777] = 10,				-- Парализующий удар https://ru.tbc.wowhead.com/spell=1777
		[8629] = 10,				-- Парализующий удар https://ru.tbc.wowhead.com/spell=8629
		[11285] = 10,				-- Парализующий удар https://ru.tbc.wowhead.com/spell=11285
		[11286] = 10,				-- Парализующий удар https://ru.tbc.wowhead.com/spell=11286
		[38764] = 10,				-- Парализующий удар https://ru.tbc.wowhead.com/spell=38764
		[36554] = 30,				-- Шаг сквозь тень https://ru.tbc.wowhead.com/spell=36554
		[13750] = 300,				-- Выброс адреналина https://ru.tbc.wowhead.com/spell=13750
		[13877] = 120,				-- Шквал клинков https://ru.tbc.wowhead.com/spell=13877
		[14185] = 600,				-- Подготовка https://ru.tbc.wowhead.com/spell=14185
		[14177] = 180,				-- Хладнокровие https://ru.tbc.wowhead.com/spell=14177
	},
	["SHAMAN"] = {
		-- // reviewed 2021/05/30
		[2825] = 600,		-- Кровожадность https://ru.tbc.wowhead.com/spell=2825
		[32182] = 600,		-- Героизм https://ru.tbc.wowhead.com/spell=32182
		[2894] = 1200,		-- Тотем элементаля огня https://ru.tbc.wowhead.com/spell=2894
		[8177] = 15 - 1.5,	-- Тотем заземления https://ru.tbc.wowhead.com/spell=8177
		[2062] = 1200,		-- Тотем элементаля земли https://ru.tbc.wowhead.com/spell=2062
		[8042] = 6 - 1,		-- Земной шок https://ru.tbc.wowhead.com/spell=8042
		[8044] = 6 - 1,		-- Земной шок https://ru.tbc.wowhead.com/spell=8044
		[8045] = 6 - 1,		-- Земной шок https://ru.tbc.wowhead.com/spell=8045
		[8046] = 6 - 1,		-- Земной шок https://ru.tbc.wowhead.com/spell=8046
		[10412] = 6 - 1,	-- Земной шок https://ru.tbc.wowhead.com/spell=10412
		[10413] = 6 - 1,	-- Земной шок https://ru.tbc.wowhead.com/spell=10413
		[10414] = 6 - 1,	-- Земной шок https://ru.tbc.wowhead.com/spell=10414
		[25454] = 6 - 1,	-- Земной шок https://ru.tbc.wowhead.com/spell=25454
		[2484] = 15,		-- Тотем оков земли https://ru.tbc.wowhead.com/spell=2484
		[30823] = 120,		-- Ярость шамана https://ru.tbc.wowhead.com/spell=30823
		[16190] = 300,		-- Тотем прилива маны https://ru.tbc.wowhead.com/spell=16190
		[16166] = 180,		-- Покорение стихий https://ru.tbc.wowhead.com/spell=16166
		[16188] = 180,		-- Природная стремительность https://ru.tbc.wowhead.com/spell=16188
	},
	["WARRIOR"] = {
		-- // reviewed 2021/05/31
		[23920] = 10,		-- Отражение заклинаний https://ru.tbc.wowhead.com/spell=23920
		[3411] = 30,		-- Вмешательство https://ru.tbc.wowhead.com/spell=3411
		[1719] = 20*60,		-- Безрассудство https://ru.tbc.wowhead.com/spell=1719
		[871] = 20*60,		-- Глухая оборона https://ru.tbc.wowhead.com/spell=871
		[6552] = 10,		-- Зуботычина https://ru.tbc.wowhead.com/spell=6552
		[6554] = 10,		-- Зуботычина https://ru.tbc.wowhead.com/spell=6554
		[676] = 60,			-- Разоружение https://ru.tbc.wowhead.com/spell=676
		[18499] = 30,		-- Ярость берсерка https://ru.tbc.wowhead.com/spell=18499
		[20230] = 20*60,	-- Возмездие https://ru.tbc.wowhead.com/spell=20230
		[5246] = 180 - 15,	-- Устрашающий крик https://ru.tbc.wowhead.com/spell=5246
		[20252] = 30 - 10,	-- Перехват https://ru.tbc.wowhead.com/spell=20252
		[20616] = 30 - 10,	-- Перехват https://ru.tbc.wowhead.com/spell=20616
		[20617] = 30 - 10,	-- Перехват https://ru.tbc.wowhead.com/spell=20617
		[25272] = 30 - 10,	-- Перехват https://ru.tbc.wowhead.com/spell=25272
		[25275] = 30 - 10,	-- Перехват https://ru.tbc.wowhead.com/spell=25275
		[72] = 12,			-- Удар щитом https://ru.tbc.wowhead.com/spell=72
		[1671] = 12,		-- Удар щитом https://ru.tbc.wowhead.com/spell=1671
		[1672] = 12,		-- Удар щитом https://ru.tbc.wowhead.com/spell=1672
		[29704] = 12,		-- Удар щитом https://ru.tbc.wowhead.com/spell=29704
		[12292] = 180,		-- Инстинкт смерти https://ru.tbc.wowhead.com/spell=12292
		[12975] = 8*60,		-- Ни шагу назад https://ru.tbc.wowhead.com/spell=12975
		[12809] = 45,		-- Оглушающий удар https://ru.tbc.wowhead.com/spell=12809
	},
};

addonTable.Interrupts = {
	[34490] = true,	-- Глушащий выстрел https://ru.tbc.wowhead.com/spell=34490
	[19244] = true,	-- Запрет чар https://ru.tbc.wowhead.com/spell=19244
	[19647] = true,	-- Запрет чар https://ru.tbc.wowhead.com/spell=19647
	[2139] = true,	-- Антимагия https://ru.tbc.wowhead.com/spell=2139
	[16979] = true,	-- Звериная атака https://ru.tbc.wowhead.com/spell=16979
	[15487] = true,	-- Молчание https://ru.tbc.wowhead.com/spell=15487
	[1766] = true,	-- Пинок https://ru.tbc.wowhead.com/spell=1766
	[1767] = true,	-- Пинок https://ru.tbc.wowhead.com/spell=1767
	[1768] = true,	-- Пинок https://ru.tbc.wowhead.com/spell=1768
	[1769] = true,	-- Пинок https://ru.tbc.wowhead.com/spell=1769
	[38768] = true,	-- Пинок https://ru.tbc.wowhead.com/spell=38768
	[8042] = true,	-- Земной шок https://ru.tbc.wowhead.com/spell=8042
	[8044] = true,	-- Земной шок https://ru.tbc.wowhead.com/spell=8044
	[8045] = true,	-- Земной шок https://ru.tbc.wowhead.com/spell=8045
	[8046] = true,	-- Земной шок https://ru.tbc.wowhead.com/spell=8046
	[10412] = true,	-- Земной шок https://ru.tbc.wowhead.com/spell=10412
	[10413] = true,	-- Земной шок https://ru.tbc.wowhead.com/spell=10413
	[10414] = true,	-- Земной шок https://ru.tbc.wowhead.com/spell=10414
	[25454] = true,	-- Земной шок https://ru.tbc.wowhead.com/spell=25454
	[6552] = true,	-- Зуботычина https://ru.tbc.wowhead.com/spell=6552
	[6554] = true,	-- Зуботычина https://ru.tbc.wowhead.com/spell=6554
	[72] = true,	-- Удар щитом https://ru.tbc.wowhead.com/spell=72
	[1671] = true,	-- Удар щитом https://ru.tbc.wowhead.com/spell=1671
	[1672] = true,	-- Удар щитом https://ru.tbc.wowhead.com/spell=1672
	[29704] = true,	-- Удар щитом https://ru.tbc.wowhead.com/spell=29704
};

addonTable.Trinkets = {
	[42292] = true,
	[7744] = true,
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

	local mageResetSpells = {};
	table.insert(mageResetSpells, 120); 	-- Cone of Cold
	table.insert(mageResetSpells, 8492); 	-- Cone of Cold
	table.insert(mageResetSpells, 10159); 	-- Cone of Cold
	table.insert(mageResetSpells, 10160); 	-- Cone of Cold
	table.insert(mageResetSpells, 10161); 	-- Cone of Cold
	table.insert(mageResetSpells, 27087); 	-- Cone of Cold
	table.insert(mageResetSpells, 122); 	-- Frost Nova
	table.insert(mageResetSpells, 865); 	-- Frost Nova
	table.insert(mageResetSpells, 6131); 	-- Frost Nova
	table.insert(mageResetSpells, 10230); 	-- Frost Nova
	table.insert(mageResetSpells, 27088); 	-- Frost Nova
	table.insert(mageResetSpells, 11426); 	-- Ice Barrier
	table.insert(mageResetSpells, 13031); 	-- Ice Barrier
	table.insert(mageResetSpells, 13032); 	-- Ice Barrier
	table.insert(mageResetSpells, 13033); 	-- Ice Barrier
	table.insert(mageResetSpells, 27134); 	-- Ice Barrier
	table.insert(mageResetSpells, 33405); 	-- Ice Barrier
	table.insert(mageResetSpells, 12472); 	-- Icy Veins
	table.insert(mageResetSpells, 45438); 	-- Ice Block
	table.insert(mageResetSpells, 31687); 	-- Summon Water Elemental

	local roguePreparationCds = {};
	table.insert(roguePreparationCds, 26669); 	-- Evasion
	table.insert(roguePreparationCds, 2983); 	-- Sprint
	table.insert(roguePreparationCds, 11305); 	-- Sprint
	table.insert(roguePreparationCds, 8696); 	-- Sprint
	table.insert(roguePreparationCds, 1856); 	-- Vanish
	table.insert(roguePreparationCds, 26889); 	-- Vanish
	table.insert(roguePreparationCds, 1857); 	-- Vanish
	table.insert(roguePreparationCds, 14177); 	-- Cold Blood
	table.insert(roguePreparationCds, 36554); 	-- Shadowstep
	table.insert(roguePreparationCds, 14183); 	-- Premeditation

	addonTable.Reductions = {
		[23989] = {	-- HUNTER: Готовность https://ru.tbc.wowhead.com/spell=23989
			["reduction"] = BIG_REDUCTION,
			["spells"] = allHunterSpells,
		},
		[11958] = {	-- MAGE: Стылая кровь https://ru.tbc.wowhead.com/spell=12472
			["reduction"] = BIG_REDUCTION,
			["spells"] = mageResetSpells,
		},
		[14185] = {	-- ROGUE: Подготовка https://ru.tbc.wowhead.com/spell=14185
			["reduction"] = BIG_REDUCTION,
			["spells"] = roguePreparationCds,
		},
	};

end