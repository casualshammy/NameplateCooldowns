------------------------------
------------ TODO ------------
------------------------------
-- 
------------------------------

local addonName, addonTable = ...;
local L = addonTable.L;

local CDs = {
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
	},
};
local Interrupts = {
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
local Resets = {
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

NameplateCooldownsDB = {};
local charactersDB = {};
local CDCache = {};
local TextureCache = {};
local ElapsedTimer = 0;
local Nameplates = {};
local NameplatesVisible = {};
local GUIFrame;
local EventFrame;
local db;
local gUI3MoP = false;
local TidyPlates = false;
local ActualOnUpdate;
local WorldFrameNumChildren = 0;
local LocalPlayerFullName = UnitName("player").." - "..GetRealmName();
local teen_bold = "Interface\\AddOns\\NameplateCooldowns\\media\\teen_bold.ttf";

local _G = _G;
local pairs = pairs;
local select = select;
local WorldFrame = WorldFrame;
local string_match = strmatch;
local string_gsub = gsub;
local string_find = strfind;
local bit_band = bit.band;
local GetTime = GetTime;
local tContains = tContains;
local math_ceil = ceil;

local OnStartup;
local InitializeDB;
local CheckForAnotherAddons;
local RebuildCache;
local AddButtonToBlizzOptions;

local AllocateIcon;
local ReallocateAllIcons;
local Nameplate_OnShow;
local Nameplate_OnHide;
local GetUnitNameForNameplate;
local CheckForNewNameplates;
local FindNewNameplate;
local InitializeFrame;
local UpdateOnlyOneNameplate;

local OnUpdate;
local OnUpdateTestMode;

local PLAYER_ENTERING_WORLD;
local COMBAT_LOG_EVENT_UNFILTERED;

local ShowGUI;
local InitializeGUI;
local GUICategory_1;
local GUICategory_2;
local GUICategory_Other;
local OnGUICategoryClick;
local ShowGUICategory;
local RebuildDropdowns;
local CreateGUICategory;
local GUICreateSlider;
local GUICreateButton;

local Print;
local deepcopy;

SLASH_NAMEPLATECOOLDOWNS1 = '/nc';
function SlashCmdList.NAMEPLATECOOLDOWNS(msg, editBox)
    ShowGUI();
end

-------------------------------------------------------------------------------------------------
----- Initialize
-------------------------------------------------------------------------------------------------
do

	function OnStartup()
		InitializeDB();
		-- remove non-existent spells
		for _, k in pairs(CDs) do
			for spellID in pairs(k) do
				if (GetSpellLink(spellID) == nil) then
					db.CDsTable[spellID] = nil;
				end
			end
		end
		for _, k in pairs(CDs) do
			for spellID in pairs(k) do
				if (db.CDsTable[spellID] == nil) then
					db.CDsTable[spellID] = true;
					Print(format(L["New spell has been added: %s"], GetSpellLink(spellID)));
				end
			end
		end
		RebuildCache();
		CheckForAnotherAddons();
		ActualOnUpdate = OnUpdate;
		EventFrame:SetScript("OnUpdate", function(self, elapsed)
			ElapsedTimer = ElapsedTimer + elapsed;
			if (ElapsedTimer >= 1) then
				ActualOnUpdate();				
				ElapsedTimer = 0;
			end
		end);
		EventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
		AddButtonToBlizzOptions();
		OnStartup = nil;
	end

	function InitializeDB()
		if (NameplateCooldownsDB[LocalPlayerFullName] == nil) then
			NameplateCooldownsDB[LocalPlayerFullName] = { CDsTable = {}, IconSize = 26, IconXOffset = 0, IconYOffset = 30, FullOpacityAlways = false };
		end
		db = NameplateCooldownsDB[LocalPlayerFullName];
	end

	function CheckForAnotherAddons()
		for i = 1, GetNumAddOns() do
			local name = GetAddOnInfo(i);
			if (name == "gUI-v3") then
				local enabled = GetAddOnEnableState(UnitName("player"), i) > 0;
				if (enabled) then
					gUI3MoP = true;
				end
			elseif (name == "TidyPlates") then
				local enabled = GetAddOnEnableState(UnitName("player"), i) > 0;
				if (enabled) then
					TidyPlates = true;
				end
			end
		end
	end
	
	function RebuildCache()
		wipe(CDCache);
		wipe(TextureCache);
		wipe(charactersDB);
		for _, k in pairs(CDs) do
			for spellID, timeInSec in pairs(k) do
				if (db.CDsTable[spellID] == true) then
					CDCache[spellID] = timeInSec;
					TextureCache[spellID] = select(3, GetSpellInfo(spellID));
				end
			end
		end
		if (UnitFactionGroup("player") == "Alliance") then
			TextureCache[42292] = "Interface\\Icons\\INV_Jewelry_TrinketPVP_01";
		else
			TextureCache[42292] = "Interface\\Icons\\INV_Jewelry_TrinketPVP_02";
		end
	end
	
	function AddButtonToBlizzOptions()
		local frame = CreateFrame("Frame", "NC_BlizzOptionsFrame", UIParent);
		frame.name = "NameplateCooldowns";
		InterfaceOptions_AddCategory(frame);
		local button = GUICreateButton("NC_BlizzOptionsButton", frame, "/nc");
		button:SetWidth(80);
		button:SetHeight(40);
		button:SetPoint("CENTER", frame, "CENTER", 0, 0);
		button:SetScript("OnClick", function(self, ...)
			ShowGUI();
			if (GUIFrame) then
				InterfaceOptionsFrameCancel:Click();
			end
		end);
	end
	
end

-------------------------------------------------------------------------------------------------
----- Nameplates
-------------------------------------------------------------------------------------------------
do

	function AllocateIcon(frame)
		local icon = CreateFrame("frame", nil, db.FullOpacityAlways and WorldFrame or frame);
		icon:SetWidth(db.IconSize);
		icon:SetHeight(db.IconSize);
		icon.texture = icon:CreateTexture(nil, "BORDER");
		icon.texture:SetAllPoints(icon);
		icon.cooldown = icon:CreateFontString(nil, "OVERLAY");
		icon.cooldown:SetTextColor(0.7, 1, 0);
		icon.cooldown:SetAllPoints(icon);
		icon.cooldown:SetFont(teen_bold, math_ceil(db.IconSize - db.IconSize / 2), "OUTLINE");
		icon.border = icon:CreateTexture(nil, "OVERLAY");
		icon.border:SetTexture("Interface\\AddOns\\NameplateCooldowns\\media\\CooldownFrameBorder.tga");
		icon.border:SetVertexColor(1, 0.35, 0);
		icon.border:SetAllPoints(icon);
		icon.border:Hide();
		icon:SetPoint("TOPLEFT", frame, db.IconXOffset + frame.NCIconsCount * db.IconSize, db.IconYOffset);
		icon:Hide();
		frame.NCIconsCount = frame.NCIconsCount + 1;
		tinsert(frame.NCIcons, icon);
	end
	
	function ReallocateAllIcons()
		for frame in pairs(Nameplates) do
			local counter = 0;
			for _, icon in pairs(frame.NCIcons) do
				icon:SetWidth(db.IconSize);
				icon:SetHeight(db.IconSize);
				icon:SetPoint("TOPLEFT", frame, db.IconXOffset + counter * db.IconSize, db.IconYOffset);
				icon.cooldown:SetFont(teen_bold, math_ceil(db.IconSize - db.IconSize / 2), "OUTLINE");
				counter = counter + 1;
			end
		end
	end
	
	function Nameplate_OnShow(frame)
		local unitName = GetUnitNameForNameplate(frame);
		UpdateOnlyOneNameplate(frame, unitName);
		NameplatesVisible[frame] = unitName;
	end
	
	function Nameplate_OnHide(frame)
		NameplatesVisible[frame] = nil;
		if (db.FullOpacityAlways) then
			for index, icon in pairs(frame.NCIcons) do
				icon:Hide();
				icon.shown = nil;
			end
		end
	end
	
	function GetUnitNameForNameplate(f)
		if (TidyPlates or not gUI3MoP) then
			local _, nameplateChild = f:GetChildren();
			local name = nameplateChild:GetRegions();
			return string_gsub(name:GetText(), '%s?%(%*%)', '');
		else
			return string_gsub(f.name:GetText(), '%s?%(%*%)', '');
		end
	end
	
	function CheckForNewNameplates()
		local numChildren = WorldFrame:GetNumChildren();
		if (numChildren ~= WorldFrameNumChildren) then
			WorldFrameNumChildren = numChildren;
			FindNewNameplate(WorldFrame:GetChildren());
		end
	end
	
	function FindNewNameplate(frame, ...)
		if (not frame) then
			return;
		end
		local frameName = frame:GetName();
		if (frameName and string_find(frameName, "NamePlate") and not Nameplates[frame]) then
			InitializeFrame(frame);
		end
		FindNewNameplate(...);
	end
	
	function InitializeFrame(frame)
		Nameplates[frame] = true;
		frame.NCIcons = {};
		frame.NCIconsCount = 0;	-- // it's faster than #frame.NCIcons
		if (frame:IsVisible()) then
			Nameplate_OnShow(frame);
		end
		frame:HookScript("OnShow", Nameplate_OnShow);
		frame:HookScript("OnHide", Nameplate_OnHide);
	end

	function UpdateOnlyOneNameplate(frame, name)
		local counter = 1;
		if (charactersDB[name]) then
			local currentTime = GetTime();
			for spellID, lastTimeUsed in pairs(charactersDB[name]) do
				local duration = CDCache[spellID];
				local last = currentTime - lastTimeUsed;
				if (last < duration) then
					if (counter > frame.NCIconsCount) then
						AllocateIcon(frame);
					end
					local icon = frame.NCIcons[counter];
					if (icon.spellID ~= spellID) then
						icon.texture:SetTexture(TextureCache[spellID]);
						icon.spellID = spellID;
					end
					if (tContains(Interrupts, spellID)) then
						if (icon.borderState ~= 1) then
							icon.border:SetVertexColor(1, 0.35, 0);
							icon.border:Show();
							icon.borderState = 1;
						end
					elseif (spellID == 42292 or spellID == 59752 or spellID == 7744) then
						if (icon.borderState ~= 2) then
							icon.border:SetVertexColor(1, 0.843, 0);
							icon.border:Show();
							icon.borderState = 2;
						end
					elseif (icon.borderState ~= nil) then
						icon.border:Hide();
						icon.borderState = nil;
					end
					local remain = duration - last;
					if (remain >= 60) then
						icon.cooldown:SetText(math_ceil(remain/60).."m");
					else
						icon.cooldown:SetText(math_ceil(remain));
					end
					if (not icon.shown) then
						icon:Show();
						icon.shown = 1;
					end
					counter = counter + 1;
				end
			end
		end
		for k = counter, frame.NCIconsCount do
			local icon = frame.NCIcons[k];
			if (icon.shown) then
				icon:Hide();
				icon.shown = nil;
			end
		end
	end
	
end

-------------------------------------------------------------------------------------------------
----- OnUpdates
-------------------------------------------------------------------------------------------------
do

	function OnUpdate()
		CheckForNewNameplates();
		local currentTime = GetTime();
		for frame, unitName in pairs(NameplatesVisible) do
			local counter = 1;
			if (charactersDB[unitName]) then
				for spellID, value in pairs(charactersDB[unitName]) do
					local duration = CDCache[spellID];
					local last = currentTime - value;
					if (last < duration) then
						-- // allocating icon if need
						if (counter > frame.NCIconsCount) then
							AllocateIcon(frame);
						end
						-- // getting reference to icon
						local icon = frame.NCIcons[counter];
						-- // setting texture if need
						if (icon.spellID ~= spellID) then
							icon.texture:SetTexture(TextureCache[spellID]);
							icon.spellID = spellID;
						end
						-- // setting up border if need
						if (tContains(Interrupts, spellID)) then
							if (icon.borderState ~= 1) then
								icon.border:SetVertexColor(1, 0.35, 0);
								icon.border:Show();
								icon.borderState = 1;
							end
						elseif (spellID == 42292 or spellID == 59752 or spellID == 7744) then -- // I know it's "chinese" coding style, but it's really faster than table lookup
							if (icon.borderState ~= 2) then
								icon.border:SetVertexColor(1, 0.843, 0);	-- // 2/3
								icon.border:Show();
								icon.borderState = 2;
							end
						elseif (icon.borderState ~= nil) then
							icon.border:Hide();
							icon.borderState = nil;
						end
						-- // setting text
						local remain = duration - last;
						if (remain >= 60) then
							icon.cooldown:SetText(math_ceil(remain/60).."m");
						else
							icon.cooldown:SetText(math_ceil(remain));
						end
						-- // show icon if need
						if (not icon.shown) then
							icon:Show();
							icon.shown = 1;
						end
						counter = counter + 1;
					else
						charactersDB[unitName][spellID] = nil;
					end
				end
			end
			for k = counter, frame.NCIconsCount do
				if (frame.NCIcons[k].shown) then
					frame.NCIcons[k]:Hide();
					frame.NCIcons[k].shown = nil;
				end
			end
		end
	end

	function OnUpdateTestMode()
		CheckForNewNameplates();
		for frame, unitName in pairs(NameplatesVisible) do
			----  test  ----
			local testTable = charactersDB[unitName];
			----  test  ----
			local counter = 1;
			for i = 1, 3 do
				if (counter > frame.NCIconsCount) then
					AllocateIcon(frame);
				end
				local icon = frame.NCIcons[counter];
				local spellID = (i == 1 and 42292) or (i == 2 and 2139) or (i == 3 and 108194);
				if (icon.spellID ~= spellID) then
					icon.texture:SetTexture((spellID == 42292 and TextureCache[42292]) or select(3, GetSpellInfo(spellID)));
					icon.spellID = spellID;
				end
				if (i ~= 1) then
					local n = tonumber(icon.cooldown:GetText());
					if (n == nil or n <= 0 or n > 30) then
						icon.cooldown:SetText("30");
					else
						icon.cooldown:SetText(tostring(n - 1));
					end
				else
					icon.cooldown:SetText("2m");
				end
				-- // setting up border if need
				if (tContains(Interrupts, spellID)) then
					if (icon.borderState ~= 1) then
						icon.border:SetVertexColor(1, 0.35, 0);
						icon.border:Show();
						icon.borderState = 1;
					end
				elseif (spellID == 42292 or spellID == 59752 or spellID == 7744) then -- // I know it's "chinese" coding style, but it's really faster than table lookup
					if (icon.borderState ~= 2) then
						icon.border:SetVertexColor(1, 0.843, 0);
						icon.border:Show();
						icon.borderState = 2;
					end
				elseif (icon.borderState ~= nil) then
					icon.border:Hide();
					icon.borderState = nil;
				end
				if (not icon.shown) then
					icon:Show();
					icon.shown = 1;
				end
				counter = counter + 1;
			end
			for k = counter, frame.NCIconsCount do
				if (frame.NCIcons[k].shown) then
					frame.NCIcons[k]:Hide();
					frame.NCIcons[k].shown = nil;
				end
			end
		end
	end

end

-------------------------------------------------------------------------------------------------
----- Events
-------------------------------------------------------------------------------------------------
do
	
	local COMBATLOG_OBJECT_IS_HOSTILE = COMBATLOG_OBJECT_REACTION_HOSTILE;
	
	function PLAYER_ENTERING_WORLD()
		if (OnStartup) then
			OnStartup();
		end
		wipe(charactersDB);
	end
	
	function COMBAT_LOG_EVENT_UNFILTERED(...)
		local _, eventType, _, _, srcName, srcFlags, _, _, _, _, _, spellID = ...;
		if (bit_band(srcFlags, COMBATLOG_OBJECT_IS_HOSTILE) ~= 0) then
			if (CDCache[spellID]) then
				if (eventType == "SPELL_CAST_SUCCESS" or eventType == "SPELL_AURA_APPLIED" or eventType == "SPELL_MISSED" or eventType == "SPELL_SUMMON") then
					local Name = string_match(srcName, "[%P]+");
					if (not charactersDB[Name]) then
						charactersDB[Name] = {};
					end
					charactersDB[Name][spellID] = GetTime();
					for frame, charName in pairs(NameplatesVisible) do
						if (charName == Name) then
							UpdateOnlyOneNameplate(frame, charName);
							break;
						end
					end
				end
			end
			-- // resets
			if (spellID == 11958 or spellID == 14185 or spellID == 108285) then	-- // I know it's "chinese" style, but it's really faster than table lookup
				if (eventType == "SPELL_CAST_SUCCESS") then
					local Name = string_match(srcName, "[%P]+");
					if (charactersDB[Name]) then
						for _, v in pairs(Resets[spellID]) do
							charactersDB[Name][v] = nil;
						end
						for frame, charName in pairs(NameplatesVisible) do
							if (charName == Name) then
								UpdateOnlyOneNameplate(frame, charName);
								break;
							end
						end
					end
				end
			elseif (spellID == 102060) then	-- // let's start cd of spellid:6552 if warrior have used spellid:102060
				if (CDCache[6552] and eventType == "SPELL_CAST_SUCCESS") then
					local Name = string_match(srcName, "[%P]+");
					if (not charactersDB[Name]) then
						charactersDB[Name] = {};
					end
					charactersDB[Name][6552] = GetTime();
					for frame, charName in pairs(NameplatesVisible) do
						if (charName == Name) then
							UpdateOnlyOneNameplate(frame, charName);
							break;
						end
					end
				end
			end
		end
	end

end

-------------------------------------------------------------------------------------------------
----- GUI
-------------------------------------------------------------------------------------------------
do

	local function GUICreateCheckBox(x, y, text, func, publicName)
		local checkBox = CreateFrame("CheckButton", publicName, GUIFrame);
		checkBox:SetHeight(20);
		checkBox:SetWidth(20);
		checkBox:SetPoint("TOPLEFT", GUIFrame, "TOPLEFT", x, y);
		checkBox:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up");
		checkBox:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down");
		checkBox:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight");
		checkBox:SetDisabledCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled");
		checkBox:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check");
		checkBox.Text = checkBox:CreateFontString(nil, "OVERLAY", "GameFontNormal");
		checkBox.Text:SetPoint("LEFT", 20, 0);
		checkBox.Text:SetText(text);
		checkBox:EnableMouse(true);
		checkBox:SetScript("OnClick", func);
		checkBox:Hide();
		return checkBox;
	end

	function ShowGUI()
		if (not InCombatLockdown()) then
			if (not GUIFrame) then
				InitializeGUI();
			end
			GUIFrame:Show();
			OnGUICategoryClick(GUIFrame.CategoryButtons[1]);
		else
			Print(L["Options are not available in combat!"]);
		end
	end
	
	function InitializeGUI()
		GUIFrame = CreateFrame("Frame", "NC_GUIFrame", UIParent);
		GUIFrame:SetHeight(350);
		GUIFrame:SetWidth(500);
		GUIFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 80);
		GUIFrame:SetBackdrop({
			bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = 1,
			tileSize = 16,
			edgeSize = 16,
			insets = { left = 3, right = 3, top = 3, bottom = 3 } 
		});
		GUIFrame:SetBackdropColor(0.1,0.22,0.35,1);
		GUIFrame:SetBackdropBorderColor(0.1,0.1,0.1,1);
		GUIFrame:EnableMouse(1);
		GUIFrame:SetMovable(1);
		GUIFrame:SetFrameStrata("DIALOG");
		GUIFrame:SetToplevel(1);
		GUIFrame:SetClampedToScreen(1);
		GUIFrame:SetScript("OnMouseDown", function() GUIFrame:StartMoving(); end);
		GUIFrame:SetScript("OnMouseUp", function() GUIFrame:StopMovingOrSizing(); end);
		GUIFrame:Hide();
		
		GUIFrame.CategoryButtons = {};
		GUIFrame.ActiveCategory = 1;
		
		local header = GUIFrame:CreateFontString("NC_GUIHeader", "ARTWORK", "GameFontHighlight");
		header:SetFont(GameFontNormal:GetFont(), 22, "THICKOUTLINE");
		header:SetPoint("CENTER", GUIFrame, "CENTER", 0, 185);
		header:SetText("NameplateCooldowns");
		
		GUIFrame.outline = CreateFrame("Frame", nil, GUIFrame);
		GUIFrame.outline:SetBackdrop({
			bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = 1,
			tileSize = 16,
			edgeSize = 16,
			insets = { left = 4, right = 4, top = 4, bottom = 4 }
		});
		GUIFrame.outline:SetBackdropColor(0.1, 0.1, 0.2, 1);
		GUIFrame.outline:SetBackdropBorderColor(0.8, 0.8, 0.9, 0.4);
		GUIFrame.outline:SetPoint("TOPLEFT", 12, -12);
		GUIFrame.outline:SetPoint("BOTTOMLEFT", 12, 12);
		GUIFrame.outline:SetWidth(100);
		
		local closeButton = CreateFrame("Button", "NC_GUICloseButton", GUIFrame, "UIPanelButtonTemplate");
		closeButton:SetWidth(24);
		closeButton:SetHeight(24);
		closeButton:SetPoint("TOPRIGHT", 0, 22);
		closeButton:SetScript("OnClick", function() GUIFrame:Hide(); end);
		closeButton.text = closeButton:CreateFontString(nil, "ARTWORK", "GameFontNormal");
		closeButton.text:SetPoint("CENTER", closeButton, "CENTER", 1, -1);
		closeButton.text:SetText("X");
		
		local scrollFramesTipText = GUIFrame:CreateFontString("NC_GUIScrollFramesTipText", "OVERLAY", "GameFontNormal");
		scrollFramesTipText:SetFont("Fonts\\FRIZQT__.TTF", 12, nil);
		scrollFramesTipText:SetPoint("CENTER", GUIFrame, "LEFT", 300, 130);
		scrollFramesTipText:SetText(L["Click on icon to enable/disable tracking"]);
		
		GUIFrame.Categories = {};
		GUIFrame.SpellIcons = {};
		
		for index, value in pairs({L["General"], L["Profiles"], L["WARRIOR"], L["DRUID"], L["PRIEST"], L["MAGE"], L["MONK"], L["HUNTER"], L["PALADIN"], L["ROGUE"], L["DEATHKNIGHT"], L["WARLOCK"], L["SHAMAN"], L["MISC"]}) do
			local b = CreateGUICategory();
			b.index = index;
			b.text:SetText(value);
			if (index == 1) then
				b:LockHighlight();
				b.text:SetTextColor(1, 1, 1);
				b:SetPoint("TOPLEFT", GUIFrame.outline, "TOPLEFT", 5, -6);
			elseif (index == 2) then
				b:SetPoint("TOPLEFT",GUIFrame.outline,"TOPLEFT", 5, -24);
			else
				b:SetPoint("TOPLEFT",GUIFrame.outline,"TOPLEFT", 5, -18 * (index - 1) - 26);
			end
			
			GUIFrame.Categories[index] = {};
			
			if (index == 1) then
				GUICategory_1(index, value);
			elseif (index == 2) then
				GUICategory_2(index, value);
			else
				GUICategory_Other(index, value);
			end
		end
	end

	function GUICategory_1(index, value)
		local buttonSwitchTestMode = GUICreateButton("NC_GUIGeneralButtonSwitchTestMode", GUIFrame, L["Enable test mode (need at least one visible nameplate)"]);
		buttonSwitchTestMode:SetWidth(340);
		buttonSwitchTestMode:SetHeight(40);
		buttonSwitchTestMode:SetPoint("TOPLEFT", GUIFrame, "TOPLEFT", 130, -40);
		buttonSwitchTestMode:SetScript("OnClick", function(self, ...)
			if (self.Text:GetText() == L["Enable test mode (need at least one visible nameplate)"]) then
				ActualOnUpdate = OnUpdateTestMode;
				ActualOnUpdate();
				self.Text:SetText(L["Disable test mode"]);
			else
				ActualOnUpdate = OnUpdate;
				ActualOnUpdate();
				self.Text:SetText(L["Enable test mode (need at least one visible nameplate)"]);
			end
		end);
		table.insert(GUIFrame.Categories[index], buttonSwitchTestMode);
		
		local sliderIconSize = GUICreateSlider(GUIFrame, 130, -100, 340, "NC_GUIGeneralSliderIconSize");
		sliderIconSize.label:SetText(L["Icon size"]);
		sliderIconSize.slider:SetValueStep(1);
		sliderIconSize.slider:SetMinMaxValues(1, 50);
		sliderIconSize.slider:SetValue(db.IconSize);
		sliderIconSize.slider:SetScript("OnValueChanged", function(self, value)
			sliderIconSize.editbox:SetText(tostring(math_ceil(value)));
			db.IconSize = math_ceil(value);
			ReallocateAllIcons();
		end);
		sliderIconSize.editbox:SetText(tostring(db.IconSize));
		sliderIconSize.editbox:SetScript("OnEnterPressed", function(self, value)
			if (sliderIconSize.editbox:GetText() ~= "") then
				local v = tonumber(sliderIconSize.editbox:GetText());
				if (v == nil) then
					sliderIconSize.editbox:SetText(tostring(db.IconSize));
					Print(L["Value must be a number"]);
				else
					if (v > 50) then
						v = 50;
					end
					if (v < 1) then
						v = 1;
					end
					sliderIconSize.slider:SetValue(v);
				end
				sliderIconSize.editbox:ClearFocus();
			end
		end);
		sliderIconSize.lowtext:SetText("1");
		sliderIconSize.hightext:SetText("50");
		table.insert(GUIFrame.Categories[index], sliderIconSize);
		
		local sliderIconXOffset = GUICreateSlider(GUIFrame, 130, -170, 155, "NC_GUIGeneralSliderIconXOffset");
		sliderIconXOffset.label:SetText(L["Icon X-coord offset"]);
		sliderIconXOffset.slider:SetValueStep(1);
		sliderIconXOffset.slider:SetMinMaxValues(-100, 100);
		sliderIconXOffset.slider:SetValue(db.IconXOffset);
		sliderIconXOffset.slider:SetScript("OnValueChanged", function(self, value)
			sliderIconXOffset.editbox:SetText(tostring(math_ceil(value)));
			db.IconXOffset = math_ceil(value);
			ReallocateAllIcons();
		end);
		sliderIconXOffset.editbox:SetText(tostring(db.IconXOffset));
		sliderIconXOffset.editbox:SetScript("OnEnterPressed", function(self, value)
			if (sliderIconXOffset.editbox:GetText() ~= "") then
				local v = tonumber(sliderIconXOffset.editbox:GetText());
				if (v == nil) then
					sliderIconXOffset.editbox:SetText(tostring(db.IconXOffset));
					Print(L["Value must be a number"]);
				else
					if (v > 100) then
						v = 100;
					end
					if (v < -100) then
						v = -100;
					end
					sliderIconXOffset.slider:SetValue(v);
				end
				sliderIconXOffset.editbox:ClearFocus();
			end
		end);
		sliderIconXOffset.lowtext:SetText("-100");
		sliderIconXOffset.hightext:SetText("100");
		table.insert(GUIFrame.Categories[index], sliderIconXOffset);
		
		local sliderIconYOffset = GUICreateSlider(GUIFrame, 315, -170, 155, "NC_GUIGeneralSliderIconYOffset");
		sliderIconYOffset.label:SetText(L["Icon Y-coord offset"]);
		sliderIconYOffset.slider:SetValueStep(1);
		sliderIconYOffset.slider:SetMinMaxValues(-100, 100);
		sliderIconYOffset.slider:SetValue(db.IconYOffset);
		sliderIconYOffset.slider:SetScript("OnValueChanged", function(self, value)
			sliderIconYOffset.editbox:SetText(tostring(math_ceil(value)));
			db.IconYOffset = math_ceil(value);
			ReallocateAllIcons();
		end);
		sliderIconYOffset.editbox:SetText(tostring(db.IconYOffset));
		sliderIconYOffset.editbox:SetScript("OnEnterPressed", function(self, value)
			if (sliderIconYOffset.editbox:GetText() ~= "") then
				local v = tonumber(sliderIconYOffset.editbox:GetText());
				if (v == nil) then
					sliderIconYOffset.editbox:SetText(tostring(db.IconYOffset));
					Print(L["Value must be a number"]);
				else
					if (v > 100) then
						v = 100;
					end
					if (v < -100) then
						v = -100;
					end
					sliderIconYOffset.slider:SetValue(v);
				end
				sliderIconYOffset.editbox:ClearFocus();
			end
		end);
		sliderIconYOffset.lowtext:SetText("-100");
		sliderIconYOffset.hightext:SetText("100");
		table.insert(GUIFrame.Categories[index], sliderIconYOffset);
		
		local checkBoxFullOpacityAlways = GUICreateCheckBox(130, -240, L["Display CD icons at full opacity (ReloadUI is required)"], function(this)
			db.FullOpacityAlways = this:GetChecked();
		end, "NC_GUI_General_CheckBoxFullOpacityAlways");
		checkBoxFullOpacityAlways:SetChecked(db.FullOpacityAlways);
		table.insert(GUIFrame.Categories[index], checkBoxFullOpacityAlways);
	end
	
	function GUICategory_2(index, value)
		local textProfilesCurrentProfile = GUIFrame:CreateFontString("NC_GUIProfilesTextCurrentProfile", "OVERLAY", "GameFontNormal");
		textProfilesCurrentProfile:SetFont("Fonts\\FRIZQT__.TTF", 12, nil);
		textProfilesCurrentProfile:SetPoint("CENTER", GUIFrame, "LEFT", 300, 130);
		textProfilesCurrentProfile:SetText(format(L["Current profile: [%s]"], LocalPlayerFullName));
		table.insert(GUIFrame.Categories[index], textProfilesCurrentProfile);
		
		local dropdownCopyProfile = CreateFrame("Frame", "NC_GUIProfilesDropdownCopyProfile", GUIFrame, "UIDropDownMenuTemplate");
		UIDropDownMenu_SetWidth(dropdownCopyProfile, 210);
		dropdownCopyProfile:SetPoint("TOPLEFT", GUIFrame, "TOPLEFT", 120, -80);
		dropdownCopyProfile.text = dropdownCopyProfile:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall");
		dropdownCopyProfile.text:SetPoint("LEFT", 20, 20);
		dropdownCopyProfile.text:SetText(L["Copy other profile to current profile:"]);
		table.insert(GUIFrame.Categories[index], dropdownCopyProfile);
		
		local buttonCopyProfile = GUICreateButton("NC_GUIProfilesButtonCopyProfile", GUIFrame, L["Copy"]);
		buttonCopyProfile:SetWidth(90);
		buttonCopyProfile:SetHeight(24);
		buttonCopyProfile:SetPoint("TOPLEFT", GUIFrame, "TOPLEFT", 380, -82);
		buttonCopyProfile:SetScript("OnClick", function(self, ...)
			if (dropdownCopyProfile.myvalue ~= nil) then
				NameplateCooldownsDB[LocalPlayerFullName] = deepcopy(NameplateCooldownsDB[dropdownCopyProfile.myvalue]);
				db = NameplateCooldownsDB[LocalPlayerFullName];
				Print(format(L["Data from '%s' has been successfully copied to '%s'"], dropdownCopyProfile.myvalue, LocalPlayerFullName));
				RebuildDropdowns();
				NC_GUIGeneralSliderIconSize.slider:SetValue(db.IconSize);
				NC_GUIGeneralSliderIconSize.editbox:SetText(tostring(db.IconSize));
				NC_GUIGeneralSliderIconXOffset.slider:SetValue(db.IconXOffset);
				NC_GUIGeneralSliderIconXOffset.editbox:SetText(tostring(db.IconXOffset));
				NC_GUIGeneralSliderIconYOffset.slider:SetValue(db.IconYOffset);
				NC_GUIGeneralSliderIconYOffset.editbox:SetText(tostring(db.IconYOffset));
				for _, v in pairs(GUIFrame.SpellIcons) do
					if (db.CDsTable[v.spellID] == true) then
						v.tex:SetAlpha(1.0);
					else
						v.tex:SetAlpha(0.3);
					end
				end
			end
		end);
		table.insert(GUIFrame.Categories[index], buttonCopyProfile);
		
		local dropdownDeleteProfile = CreateFrame("Frame", "NC_GUIProfilesDropdownDeleteProfile", GUIFrame, "UIDropDownMenuTemplate");
		UIDropDownMenu_SetWidth(dropdownDeleteProfile, 210);
		dropdownDeleteProfile:SetPoint("TOPLEFT", GUIFrame, "TOPLEFT", 120, -120);
		dropdownDeleteProfile.text = dropdownDeleteProfile:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall");
		dropdownDeleteProfile.text:SetPoint("LEFT", 20, 20);
		dropdownDeleteProfile.text:SetText(L["Delete profile:"]);
		table.insert(GUIFrame.Categories[index], dropdownDeleteProfile);
		
		local buttonDeleteProfile = GUICreateButton("NC_GUIProfilesButtonDeleteProfile", GUIFrame, L["Delete"]);
		buttonDeleteProfile:SetWidth(90);
		buttonDeleteProfile:SetHeight(24);
		buttonDeleteProfile:SetPoint("TOPLEFT", GUIFrame, "TOPLEFT", 380, -122);
		buttonDeleteProfile:SetScript("OnClick", function(self, ...)
			if (dropdownDeleteProfile.myvalue ~= nil) then
				NameplateCooldownsDB[dropdownDeleteProfile.myvalue] = nil;
				Print(format(L["Profile '%s' has been successfully deleted"], dropdownDeleteProfile.myvalue));
				RebuildDropdowns();
			end
		end);
		table.insert(GUIFrame.Categories[index], buttonDeleteProfile);
		
		RebuildDropdowns();
	end
	
	function GUICategory_Other(index, value)
		local scrollAreaBackground = CreateFrame("Frame", "NC_GUIScrollFrameBackground_"..tostring(index - 1), GUIFrame);
		scrollAreaBackground:SetPoint("TOPLEFT", GUIFrame, "TOPLEFT", 120, -60);
		scrollAreaBackground:SetPoint("BOTTOMRIGHT", GUIFrame, "BOTTOMRIGHT", -30, 15);
		scrollAreaBackground:SetBackdrop({
			bgFile = "Interface\\AddOns\\NameplateCooldowns\\media\\Smudge.tga",
			edgeFile = "Interface\\AddOns\\NameplateCooldowns\\media\\Border",
			tile = true, edgeSize = 3, tileSize = 1,
			insets = { left = 3, right = 3, top = 3, bottom = 3 }
		});
		scrollAreaBackground:SetBackdropColor(0.1, 0.22, 0.35, 0.8)
		scrollAreaBackground:SetBackdropBorderColor(0.3, 0.3, 0.5, 1);
		scrollAreaBackground:Hide();
		table.insert(GUIFrame.Categories[index], scrollAreaBackground);
		
		local scrollArea = CreateFrame("ScrollFrame", "NC_GUIScrollFrame_"..tostring(index - 1), scrollAreaBackground, "UIPanelScrollFrameTemplate");
		scrollArea:SetPoint("TOPLEFT", scrollAreaBackground, "TOPLEFT", 5, -5);
		scrollArea:SetPoint("BOTTOMRIGHT", scrollAreaBackground, "BOTTOMRIGHT", -5, 5);
		scrollArea:Show();
		
		local scrollAreaChildFrame = CreateFrame("Frame", "NC_GUIScrollFrameChildFrame_"..tostring(index - 1), scrollArea);
		scrollArea:SetScrollChild(scrollAreaChildFrame);
		scrollAreaChildFrame:SetPoint("CENTER", GUIFrame, "CENTER", 0, 1);
		scrollAreaChildFrame:SetWidth(288);
		scrollAreaChildFrame:SetHeight(288);
		
		local iterator = 1;
		for spellID in pairs(CDs[value]) do
			local n, _, icon = GetSpellInfo(spellID);
			if (not n) then
				Print(format(L["Unknown spell: %s"], spellID));
			end
			
			local spellItem = CreateFrame("button", nil, scrollAreaChildFrame, "SecureActionButtonTemplate");
			spellItem:SetHeight(20);
			spellItem:SetWidth(20);
			spellItem:SetPoint("TOPLEFT", 3, ((iterator - 1) * -22) - 10);
			
			spellItem.tex = spellItem:CreateTexture();
			spellItem.tex:SetAllPoints(spellItem);
			spellItem.tex:SetHeight(20);
			spellItem.tex:SetWidth(20);
			spellItem.tex:SetTexture(icon);
			
			spellItem.Text = spellItem:CreateFontString(nil, "OVERLAY");
			spellItem.Text:SetFont("Fonts\\FRIZQT__.TTF", 12, nil);
			spellItem.Text:SetPoint("LEFT", 22, 0);
			spellItem.Text:SetText(n); -- // .."  (ID: "..tostring(spellID)..")"
			spellItem:EnableMouse(true);
			
			spellItem:SetScript("OnEnter", function(self, ...)
				GameTooltip:SetOwner(spellItem, "ANCHOR_TOPRIGHT");
				GameTooltip:SetSpellByID(spellID);
				GameTooltip:Show();
			end)
			spellItem:SetScript("OnLeave", function(self, ...)
				GameTooltip:Hide();
			end)
			spellItem:SetScript("OnClick", function(self, ...)
				if (self.tex:GetAlpha() > 0.5) then
					db.CDsTable[spellID] = false;
					self.tex:SetAlpha(0.3);
				else
					db.CDsTable[spellID] = true;
					self.tex:SetAlpha(1.0);
				end
				RebuildCache();
			end)
			if (db.CDsTable[spellID] == true) then
				spellItem.tex:SetAlpha(1.0);
			else
				spellItem.tex:SetAlpha(0.3);
			end
			iterator = iterator + 1;
			spellItem.spellID = spellID;
			tinsert(GUIFrame.SpellIcons, spellItem);
		end
	end
	
	function OnGUICategoryClick(self, ...)
		GUIFrame.CategoryButtons[GUIFrame.ActiveCategory].text:SetTextColor(1, 0.82, 0);
		GUIFrame.CategoryButtons[GUIFrame.ActiveCategory]:UnlockHighlight();
		GUIFrame.ActiveCategory = self.index;
		self.text:SetTextColor(1, 1, 1);
		self:LockHighlight();
		PlaySound("igMainMenuOptionCheckBoxOn");
		ShowGUICategory(GUIFrame.ActiveCategory);
	end
	
	function ShowGUICategory(index)
		for i, v in pairs(GUIFrame.Categories) do
			for k, l in pairs(v) do
				l:Hide();
			end
		end
		for i, v in pairs(GUIFrame.Categories[index]) do
			v:Show();
		end
		if (index > 2) then
			NC_GUIScrollFramesTipText:Show();
		else
			NC_GUIScrollFramesTipText:Hide();
		end
	end
	
	function RebuildDropdowns()
		local info = {};
		NC_GUIProfilesDropdownCopyProfile.myvalue = nil;
		UIDropDownMenu_SetText(NC_GUIProfilesDropdownCopyProfile, "");
		local initCopyProfile = function()
			wipe(info);
			for index in pairs(NameplateCooldownsDB) do
				if (index ~= LocalPlayerFullName) then
					info.text = index;
					info.func = function(self)
						NC_GUIProfilesDropdownCopyProfile.myvalue = index;
						UIDropDownMenu_SetText(NC_GUIProfilesDropdownCopyProfile, index);
					end
					info.notCheckable = true;
					UIDropDownMenu_AddButton(info);
				end
			end
		end
		UIDropDownMenu_Initialize(NC_GUIProfilesDropdownCopyProfile, initCopyProfile);
		
		NC_GUIProfilesDropdownDeleteProfile.myvalue = nil;
		UIDropDownMenu_SetText(NC_GUIProfilesDropdownDeleteProfile, "");
		local initDeleteProfile = function()
			wipe(info);
			for index in pairs(NameplateCooldownsDB) do
				info.text = index;
				info.func = function(self)
					NC_GUIProfilesDropdownDeleteProfile.myvalue = index;
					UIDropDownMenu_SetText(NC_GUIProfilesDropdownDeleteProfile, index);
				end
				info.notCheckable = true;
				UIDropDownMenu_AddButton(info);
			end
		end
		UIDropDownMenu_Initialize(NC_GUIProfilesDropdownDeleteProfile, initDeleteProfile);
	end
	
	function CreateGUICategory()
		local b = CreateFrame("Button", nil, GUIFrame.outline);
		b:SetWidth(92);
		b:SetHeight(18);
		b:SetScript("OnClick", OnGUICategoryClick);
		b:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
		b:GetHighlightTexture():SetAlpha(0.7);
		b.text = b:CreateFontString(nil, "ARTWORK", "GameFontNormal");
		b.text:SetPoint("LEFT", 3, 0);
		GUIFrame.CategoryButtons[#GUIFrame.CategoryButtons + 1] = b;
		return b;
	end
	
	function GUICreateSlider(parent, x, y, size, publicName)
		local frame = CreateFrame("Frame", publicName, parent);
		frame:SetHeight(100);
		frame:SetWidth(size);
		frame:SetPoint("TOPLEFT", x, y);

		frame.label = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
		frame.label:SetFont("Fonts\\FRIZQT__.TTF", 12, nil);
		frame.label:SetPoint("TOPLEFT");
		frame.label:SetPoint("TOPRIGHT");
		frame.label:SetJustifyH("CENTER");
		frame.label:SetHeight(15);
		
		frame.slider = CreateFrame("Slider", nil, frame);
		frame.slider:SetOrientation("HORIZONTAL")
		frame.slider:SetHeight(15)
		frame.slider:SetHitRectInsets(0, 0, -10, 0)
		frame.slider:SetBackdrop({
			bgFile = "Interface\\Buttons\\UI-SliderBar-Background",
			edgeFile = "Interface\\Buttons\\UI-SliderBar-Border",
			tile = true, tileSize = 8, edgeSize = 8,
			insets = { left = 3, right = 3, top = 6, bottom = 6 }
		});
		frame.slider:SetThumbTexture("Interface\\Buttons\\UI-SliderBar-Button-Horizontal")
		frame.slider:SetPoint("TOP", frame.label, "BOTTOM")
		frame.slider:SetPoint("LEFT", 3, 0)
		frame.slider:SetPoint("RIGHT", -3, 0)

		frame.lowtext = frame.slider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		frame.lowtext:SetPoint("TOPLEFT", frame.slider, "BOTTOMLEFT", 2, 3)

		frame.hightext = frame.slider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		frame.hightext:SetPoint("TOPRIGHT", frame.slider, "BOTTOMRIGHT", -2, 3)

		frame.editbox = CreateFrame("EditBox", nil, frame)
		frame.editbox:SetAutoFocus(false)
		frame.editbox:SetFontObject(GameFontHighlightSmall)
		frame.editbox:SetPoint("TOP", frame.slider, "BOTTOM")
		frame.editbox:SetHeight(14)
		frame.editbox:SetWidth(70)
		frame.editbox:SetJustifyH("CENTER")
		frame.editbox:EnableMouse(true)
		frame.editbox:SetBackdrop({
			bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
			edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
			tile = true, edgeSize = 1, tileSize = 5,
		});
		frame.editbox:SetBackdropColor(0, 0, 0, 0.5)
		frame.editbox:SetBackdropBorderColor(0.3, 0.3, 0.30, 0.80)
		frame.editbox:SetScript("OnEscapePressed", function() frame.editbox:ClearFocus(); end)
		frame:Hide();
		return frame;
	end
	
	function GUICreateButton(publicName, parentFrame, text)
		-- After creation we need to set up :SetWidth, :SetHeight, :SetPoint, :SetScript
		local button = CreateFrame("Button", publicName, parentFrame);
		button.Background = button:CreateTexture(nil, "BORDER");
		button.Background:SetPoint("TOPLEFT", 1, -1);
		button.Background:SetPoint("BOTTOMRIGHT", -1, 1);
		button.Background:SetTexture(0, 0, 0, 1);

		button.Border = button:CreateTexture(nil, "BACKGROUND");
		button.Border:SetPoint("TOPLEFT", 0, 0);
		button.Border:SetPoint("BOTTOMRIGHT", 0, 0);
		button.Border:SetTexture(unpack({0.73, 0.26, 0.21, 1}));

		button.Normal = button:CreateTexture(nil, "ARTWORK");
		button.Normal:SetPoint("TOPLEFT", 2, -2);
		button.Normal:SetPoint("BOTTOMRIGHT", -2, 2);
		button.Normal:SetTexture(unpack({0.38, 0, 0, 1}));
		button:SetNormalTexture(button.Normal);

		button.Disabled = button:CreateTexture(nil, "OVERLAY");
		button.Disabled:SetPoint("TOPLEFT", 3, -3);
		button.Disabled:SetPoint("BOTTOMRIGHT", -3, 3);
		button.Disabled:SetTexture(0.6, 0.6, 0.6, 0.2);
		button:SetDisabledTexture(button.Disabled);

		button.Highlight = button:CreateTexture(nil, "OVERLAY");
		button.Highlight:SetPoint("TOPLEFT", 3, -3);
		button.Highlight:SetPoint("BOTTOMRIGHT", -3, 3);
		button.Highlight:SetTexture(0.6, 0.6, 0.6, 0.2);
		button:SetHighlightTexture(button.Highlight);

		button.Text = button:CreateFontString(publicName.."Text", "OVERLAY", "GameFontNormal");
		button.Text:SetPoint("CENTER", 0, 0);
		button.Text:SetJustifyH("CENTER");
		button.Text:SetTextColor(1, 0.82, 0, 1);
		button.Text:SetText(text);

		button:SetScript("OnMouseDown", function(self) self.Text:SetPoint("CENTER", 1, -1) end);
		button:SetScript("OnMouseUp", function(self) self.Text:SetPoint("CENTER", 0, 0) end);
		return button;
	end
	
end

-------------------------------------------------------------------------------------------------
----- Useful stuff
-------------------------------------------------------------------------------------------------
do

	function Print(...)
		local text = "";
		for i = 1, select("#", ...) do
			text = text..tostring(select(i, ...)).." "
		end
		DEFAULT_CHAT_FRAME:AddMessage(format("NameplateCooldowns: %s", text), 0, 128, 128);
	end

	function deepcopy(object)
		local lookup_table = {}
		local function _copy(object)
			if type(object) ~= "table" then
				return object
			elseif lookup_table[object] then
				return lookup_table[object]
			end
			local new_table = {}
			lookup_table[object] = new_table
			for index, value in pairs(object) do
				new_table[_copy(index)] = _copy(value)
			end
			return setmetatable(new_table, getmetatable(object))
		end
		return _copy(object)
	end
	
end

-------------------------------------------------------------------------------------------------
----- Frame for events
-------------------------------------------------------------------------------------------------
EventFrame = CreateFrame("Frame");
EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
EventFrame:SetScript("OnEvent", function(self, event, ...)
	if (event == "COMBAT_LOG_EVENT_UNFILTERED") then
		COMBAT_LOG_EVENT_UNFILTERED(...);
	else
		PLAYER_ENTERING_WORLD();
	end
end);
