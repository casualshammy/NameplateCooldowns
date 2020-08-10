if (select(4, GetBuildInfo()) > 20000) then return end

local _, addonTable = ...;
local L = LibStub("AceLocale-3.0"):GetLocale("NameplateCooldowns");

addonTable.DefaultSpellsVersion = 8;

addonTable.CDs = {
	-- // other spells
	[20594] = 120,				--"Stoneform",
	-- // hunter
	[19574] = 90,					-- // Bestial Wrath
	-- // warlock
	[6789] = 45,				-- // Mortal Coil
	-- // mage
	[12042] = 90,				-- // Arcane Power
	-- // druid
	[1850] = 180,				-- // Dash
	[22570] = 10,				-- // Maim
	[5217] = 30,				-- // Tiger's Fury
	[740] = 120,				-- // Tranquility
	[5211]		= 50,			-- // Mighty Bash
	-- // paladin
	[642] = 240,			-- // Божественный щит
	[1044] = 25,			-- // Благословенная свобода
	[633] = 600,			-- // Возложение рук
	[1022] = 135,			-- // Благословение защиты
	[498] = 60,				-- // Божественная защита
	[853] = 30,				-- // Молот правосудия https://www.wowhead.com/spell=853/hammer-of-justice
	-- // priest
	[8122] = 30,				--"Psychic Scream", [-30sec]
	[10060] = 120,				--"Power Infusion",
	[19236] = 90,				--"Desperate Prayer",
	-- // rogue
	[1776] = 10,				--"Gouge",
	[5277] = 120,				--"Evasion",
	[408] = 20,					--"Kidney Shot",
	[13750] = 150,				-- Adrenaline Rush [-30sec]
	-- // shaman
	[16166] = 120,				--"Elemental Mastery",
	-- // warrior
	[100] 		= 17,					--"Charge", [-3sec (talent)]
	[1719] 		= 90,				-- // Recklessness https://www.wowhead.com/spell=1719/recklessness
	[18499] 	= 60,				-- Berserker Rage
};

local interrupts = {
	2139,	-- Counterspell
	15487,	-- Silence
	1766,	-- Kick
	6552,	-- Pummel
	19647,	-- Spell Lock https://ru.wowhead.com/spell=19647
};
addonTable.Interrupts = { };
for _, spellID in pairs(interrupts) do
	local spellName = GetSpellInfo(spellID);
	if (spellName ~= nil) then
		addonTable.Interrupts[spellName] = true;
	else
		print("NameplateCooldowns: interrupt spell is not exist: "..tostring(spellID));
		-- error("NameplateCooldowns: interrupt spell is not exist: "..tostring(spellID));
	end
end

-- // Trinkets
do

	local trinkets = {
		-- 42292,
		-- 59752,
		7744,
		-- 195710,				-- // Почетный медальон
		-- 208683,				-- // Медальон гладиатора
	};
	addonTable.Trinkets = { };
	for _, spellID in pairs(trinkets) do
		local spellName = GetSpellInfo(spellID);
		if (spellName == nil) then
			print("NameplateCooldowns: trinket spell is not exist: "..tostring(spellID));
		else
			addonTable.Trinkets[spellName] = true;
		end
	end

end

-- // spells that reduce cooldown of other spells
do
	
	local BIG_REDUCTION = 4*1000*1000;

	addonTable.Reductions = {
		-- ["SPELL NAME HERE"] = { -- // Fortifying Brew https://www.wowhead.com/spell=115203/fortifying-brew
			-- ["reduction"] = -120,
			-- ["spells"] = {
				-- 243435,			-- // Fortifying Brew https://www.wowhead.com/spell=243435/fortifying-brew
			-- },
		-- },
	};

end
