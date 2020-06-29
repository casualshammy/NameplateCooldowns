if (select(4, GetBuildInfo()) < 80200) then return end

local _, addonTable = ...;
local L = addonTable.L;
local CDs = addonTable.CDs;
local Interrupts = addonTable.Interrupts;
local Trinkets = addonTable.Trinkets;
local Reductions = addonTable.Reductions;

--[===[@non-debug@
local buildTimestamp = "@project-version@";
--@end-non-debug@]===]

local LRD = LibStub("LibRedDropdown-1.0");
local LBG_ShowOverlayGlow, LBG_HideOverlayGlow = NAuras_LibButtonGlow.ShowOverlayGlow, NAuras_LibButtonGlow.HideOverlayGlow;
local SML = LibStub("LibSharedMedia-3.0");
SML:Register("font", "NC_TeenBold", "Interface\\AddOns\\NameplateCooldowns\\media\\teen_bold.ttf", 255);

local SPELL_PVPADAPTATION = 195901;
local SPELL_PVPTRINKET = 42292;

local charactersDB = {};
local spellNamesWithCd = { };
local AllSpellIDsAndIconsByName = { };

local SpellTextureByID = setmetatable({
	[SPELL_PVPTRINKET] =	1322720,
	[200166] =				1247262,
}, {
	__index = function(t, key)
		local texture = GetSpellTexture(key);
		t[key] = texture;
		return texture;
	end
});
local SpellNameByID = setmetatable({}, {
	__index = function(t, key)
		local spellName = GetSpellInfo(key);
		t[key] = spellName;
		return spellName;
	end
});
local ElapsedTimer = 0;
local Nameplates = {};
local NameplatesVisible = {};
local InstanceType = "none";
local GUIFrame, EventFrame, TestFrame, db, aceDB, ProfileOptionsFrame;

local _G, pairs, select, UIParent, string_match, string_gsub, string_find, bit_band, GetTime, table_contains_value, math_ceil, 	table_insert, table_sort, C_Timer_After, string_lower, string_format, C_Timer_NewTimer =
	  _G, pairs, select, UIParent, strmatch,	   		gsub,	  strfind, bit.band, GetTime, 			 tContains,		 ceil,	table.insert, table.sort, C_Timer.After, string.lower, string.format, C_Timer.NewTimer;
	  
local OnStartup, InitializeDB, GetDefaultDBEntryForSpell;
local AllocateIcon, ReallocateAllIcons, InitializeFrame, UpdateOnlyOneNameplate, Nameplate_SetBorder, Nameplate_SetCooldown, HideCDIcon, ShowCDIcon;
local OnUpdate;
local EnableTestMode, DisableTestMode;
local ShowGUI, InitializeGUI, GUICategory_General, GUICategory_Profiles, GUICategory_Other, OnGUICategoryClick, ShowGUICategory, CreateGUICategory;
local Print, deepcopy, table_contains_key, table_any, CoroutineProcessor, ColorizeText, msg, table_count;

-- // consts: you should not change existing values
local CONST_SORT_MODES = { "none", "trinket-interrupt-other", "interrupt-trinket-other", "trinket-other", "interrupt-other" };
local CONST_SORT_MODES_L = {
	[CONST_SORT_MODES[1]] = "none",
	[CONST_SORT_MODES[2]] = "trinkets, then interrupts, then other spells",
	[CONST_SORT_MODES[3]] = "interrupts, then trinkets, then other spells",
	[CONST_SORT_MODES[4]] = "trinkets, then other spells",
	[CONST_SORT_MODES[5]] = "interrupts, then other spells",
};

local GLOW_TIME_INFINITE, INSTANCE_TYPE_UNKNOWN;
do
	GLOW_TIME_INFINITE 		= 4*1000*1000*1000;
	INSTANCE_TYPE_UNKNOWN 	= "unknown";
end

-------------------------------------------------------------------------------------------------
----- Initialize
-------------------------------------------------------------------------------------------------
do

	function GetDefaultDBEntryForSpell(spellID)
		return {
			["enabled"] = true,
			["cooldown"] = 60,
			["glow"] = nil,
			["texture"] = SpellTextureByID[spellID],
			["refSpellID"] = spellID,
			["spellIDs"] = nil,
		};
	end
	
	local function MigrateDB(t)
		if (next(t.CDsTable)) then
			for spellID, enabled in pairs(t.CDsTable) do
				local spellName = SpellNameByID[spellID];
				if (t.SpellCDs[spellName] == nil and addonTable.CDs[spellID] ~= nil) then
					t.SpellCDs[spellName] = GetDefaultDBEntryForSpell(spellID);
					t.SpellCDs[spellName].enabled = enabled;
					t.SpellCDs[spellName].cooldown = addonTable.CDs[spellID];
					t.SpellCDs[spellName].spellIDs = { [spellID] = true; };
				end
			end
			t.CDsTable = { };
		end
	end
		
	local function AddToBlizzOptions()
		LibStub("AceConfig-3.0"):RegisterOptionsTable("NameplateCooldowns", {
			name = "NameplateCooldowns",
			type = "group",
			args = {
				openGUI = {
					type = 'execute',
					order = 1,
					name = 'Open config dialog',
					desc = nil,
					func = function()
						ShowGUI();
						if (GUIFrame) then
							InterfaceOptionsFrameCancel:Click();
						end
					end,
				},
			},
		});
		LibStub("AceConfigDialog-3.0"):AddToBlizOptions("NameplateCooldowns", "NameplateCooldowns");
		local profilesConfig = LibStub("AceDBOptions-3.0"):GetOptionsTable(aceDB);
		LibStub("AceConfig-3.0"):RegisterOptionsTable("NameplateCooldowns.profiles", profilesConfig);
		ProfileOptionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("NameplateCooldowns.profiles", "Profiles", "NameplateCooldowns");
	end

	local function ReloadDB()
		db = aceDB.profile;
		if (db.AddonEnabled) then
			EventFrame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
			wipe(charactersDB);
		else
			EventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
		end
		if (TestFrame and TestFrame:GetScript("OnUpdate") ~= nil) then
			DisableTestMode();
		end
		OnUpdate();
		if (GUIFrame) then
			for _, func in pairs(GUIFrame.OnDBChangedHandlers) do
				func();
			end
		end
	end
	
	function InitializeDB()
		-- // set defaults
		local aceDBDefaults = {
			profile = {
				SpellCDs = { },
				UnwantedDefaultSpells = { },
				DBVersion = 0,
				IconSpacing = 0,
				CDsTable = { }, -- // obsolete
				IconSize = 26,
				IconXOffset = 0,
				IconYOffset = 30,
				FullOpacityAlways = false,
				ShowBorderTrinkets = true,
				ShowBorderInterrupts = true,
				BorderInterruptsColor = {1, 0.35, 0},
				BorderTrinketsColor = {1, 0.843, 0},
				Font = "NC_TeenBold",
				IconSortMode = CONST_SORT_MODES[1],
				AddonEnabled = true,
				ShowCooldownsOnCurrentTargetOnly = false,
				EnabledZoneTypes = { 
					["none"] =					true,
					[INSTANCE_TYPE_UNKNOWN] = 	true,
					["pvp"] = 					true,
					["arena"] = 				true,
					["party"] = 				true,
					["raid"] = 					true,
					["scenario"] = 				true,
				},
				ShowOldBlizzardBorderAroundIcons = false,
			},
		};
		aceDB = LibStub("AceDB-3.0"):New("NameplateCooldownsAceDB", aceDBDefaults);
		MigrateDB(aceDB.profile);
		AddToBlizzOptions();
		aceDB.RegisterCallback("NameplateCooldowns", "OnProfileChanged", ReloadDB);
		aceDB.RegisterCallback("NameplateCooldowns", "OnProfileCopied", ReloadDB);
		aceDB.RegisterCallback("NameplateCooldowns", "OnProfileReset", ReloadDB);
		db = aceDB.profile;
	end
	
	local function OnStartup_AddNewAndUpdatedSpells()
		if (db.DBVersion < addonTable.DefaultSpellsVersion) then
			local spellsAlreadyInUserDb = { };
			for spellID, spellCd in pairs(addonTable.CDs) do
				local spellName = SpellNameByID[spellID];
				if (db.UnwantedDefaultSpells[spellName] == nil) then
					if (db.SpellCDs[spellName] == nil) then
						db.SpellCDs[spellName] = GetDefaultDBEntryForSpell(spellID);
						db.SpellCDs[spellName].cooldown = spellCd;
						db.SpellCDs[spellName].spellIDs = { [spellID] = true; };
						Print(format(L["New spell has been added: %s"], GetSpellLink(spellID)));
					else
						if (db.SpellCDs[spellName].cooldown ~= spellCd) then
							spellsAlreadyInUserDb[spellName] = spellCd;
						end
					end
				end
			end
			if (table_any(spellsAlreadyInUserDb)) then
				for spellName, spellCd in pairs(spellsAlreadyInUserDb) do
					Print(string_format(L["chat:print-updated-spells"], spellName, db.SpellCDs[spellName].cooldown, spellCd));
				end
				msgWithQuestion(L["msg:question:import-existing-spells"], 
					function()
						for spellName, spellCd in pairs(spellsAlreadyInUserDb) do
							local oldCooldown = db.SpellCDs[spellName].cooldown;
							db.SpellCDs[spellName].cooldown = spellCd;
						end
					end,
					function() end
				);
			end
			db.DBVersion = addonTable.DefaultSpellsVersion;
		end
	end
	
	function OnStartup()
		InitializeDB();
		OnStartup_AddNewAndUpdatedSpells();
		-- // starting OnUpdate()
		EventFrame:SetScript("OnUpdate", function(self, elapsed)
			ElapsedTimer = ElapsedTimer + elapsed;
			if (ElapsedTimer >= 1) then
				OnUpdate();
				ElapsedTimer = 0;
			end
		end);
		-- // starting listening for events
		if (db.AddonEnabled) then
			EventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
		else
			Print(L["chat:addon-is-disabled-note"]);
		end
		if (db.ShowCooldownsOnCurrentTargetOnly) then
			EventFrame:RegisterEvent("PLAYER_TARGET_CHANGED");
			--Print(L["chat:enable-only-for-target-nameplate"]);
		end
		EventFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED");
		EventFrame:RegisterEvent("NAME_PLATE_UNIT_REMOVED");
		SLASH_NAMEPLATECOOLDOWNS1 = '/nc';
		SlashCmdList["NAMEPLATECOOLDOWNS"] = function(msg, editBox)
			if (msg == "t" or msg == "ver") then
				local c = UNKNOWN;
				if (IsInGroup(LE_PARTY_CATEGORY_INSTANCE)) then
					c = "INSTANCE_CHAT";
				elseif (IsInRaid()) then
					c = "RAID";
				else
					c = "GUILD";
				end
				Print("Waiting for replies from " .. c);
				C_ChatInfo.SendAddonMessage("NC_prefix", "requesting", c);
			else
				ShowGUI();
			end
		end
		OnStartup = nil;
	end
	
end

-------------------------------------------------------------------------------------------------
----- Nameplates
-------------------------------------------------------------------------------------------------
do
	
	local glowInfo = { };
	
	function AllocateIcon(frame)
		if (not frame.NCFrame) then
			frame.NCFrame = CreateFrame("frame", nil, db.FullOpacityAlways and UIParent or frame);
			frame.NCFrame:SetWidth(db.IconSize);
			frame.NCFrame:SetHeight(db.IconSize);
			frame.NCFrame:SetPoint("TOPLEFT", frame, db.IconXOffset, db.IconYOffset);
			frame.NCFrame:Show();
		end
		local icon = CreateFrame("frame", nil, frame.NCFrame);
		icon:SetWidth(db.IconSize);
		icon:SetHeight(db.IconSize);
		if (frame.NCIconsCount == 0) then
			icon:SetPoint("LEFT", frame.NCFrame, 0, 0);
		else
			icon:SetPoint("LEFT", frame.NCIcons[frame.NCIconsCount], "RIGHT", db.IconSpacing, 0);
		end
		icon:Hide();
		icon.texture = icon:CreateTexture(nil, "BORDER");
		icon.texture:SetAllPoints(icon);
		if (not db.ShowOldBlizzardBorderAroundIcons) then
			icon.texture:SetTexCoord(0.07, 0.93, 0.07, 0.93);
		end
		icon.cooldownText = icon:CreateFontString(nil, "OVERLAY");
		icon.cooldownText:SetTextColor(0.7, 1, 0);
		icon.cooldownText:SetAllPoints(icon);
		icon.cooldownText:SetFont(SML:Fetch("font", db.Font), math_ceil(db.IconSize - db.IconSize / 2), "OUTLINE");
		icon.border = icon:CreateTexture(nil, "OVERLAY");
		icon.border:SetTexture("Interface\\AddOns\\NameplateCooldowns\\media\\CooldownFrameBorder.tga");
		icon.border:SetVertexColor(1, 0.35, 0);
		icon.border:SetAllPoints(icon);
		icon.border:Hide();
		frame.NCIconsCount = frame.NCIconsCount + 1;
		tinsert(frame.NCIcons, icon);
	end
	
	function ReallocateAllIcons(clearSpells)
		for frame in pairs(Nameplates) do
			if (frame.NCFrame) then
				frame.NCFrame:SetPoint("TOPLEFT", frame, db.IconXOffset, db.IconYOffset);
				local counter = 0;
				for iconIndex, icon in pairs(frame.NCIcons) do
					icon:SetWidth(db.IconSize);
					icon:SetHeight(db.IconSize);
					if (iconIndex == 1) then
						icon:SetPoint("LEFT", frame.NCFrame, 0, 0);
					else
						icon:SetPoint("LEFT", frame.NCIcons[iconIndex-1], "RIGHT", db.IconSpacing, 0);
					end
					
					if (not db.ShowOldBlizzardBorderAroundIcons) then
						icon.texture:SetTexCoord(0.07, 0.93, 0.07, 0.93);
					else
						icon.texture:SetTexCoord(0, 1, 0, 1);
					end
					
					icon.cooldownText:SetFont(SML:Fetch("font", db.Font), math_ceil(db.IconSize - db.IconSize / 2), "OUTLINE");
					if (clearSpells) then
						HideCDIcon(icon);
					end
					counter = counter + 1;
				end
			end
		end
		if (clearSpells) then
			OnUpdate();
		end
	end
	
	local function GlobalFilterNameplate(unitName)
		if (not db.ShowCooldownsOnCurrentTargetOnly or UnitName("target") == unitName) then
			if (db.EnabledZoneTypes[InstanceType]) then
				return true;
			end
		end
		return false;
	end
	
	local function Nameplate_SortAuras_mode1(item1, item2)
		if (Trinkets[item1.spellName]) then
			if (Trinkets[item2.spellName]) then
				return item1.expires < item2.expires;
			else
				return true;
			end
		elseif (Trinkets[item2.spellName]) then
			return false;
		elseif (Interrupts[item1.spellName]) then
			if (Interrupts[item2.spellName]) then
				return item1.expires < item2.expires;
			else
				return true;
			end
		elseif (Interrupts[item2.spellName]) then
			return false;
		else
			return item1.expires < item2.expires;
		end
	end
	
	local function Nameplate_SortAuras_mode2(item1, item2)
		if (Interrupts[item1.spellName]) then
			if (Interrupts[item2.spellName]) then
				return item1.expires < item2.expires;
			else
				return true;
			end
		elseif (Interrupts[item2.spellName]) then
			return false;
		elseif (Trinkets[item1.spellName]) then
			if (Trinkets[item2.spellName]) then
				return item1.expires < item2.expires;
			else
				return true;
			end
		elseif (Trinkets[item2.spellName]) then
			return false;
		else
			return item1.expires < item2.expires;
		end
	end
	
	local function Nameplate_SortAuras_mode3(item1, item2)
		if (Trinkets[item1.spellName]) then
			if (Trinkets[item2.spellName]) then
				return item1.expires < item2.expires;
			else
				return true;
			end
		elseif (Trinkets[item2.spellName]) then
			return false;
		else
			return item1.expires < item2.expires;
		end
	end
	
	local function Nameplate_SortAuras_mode4(item1, item2)
		if (Interrupts[item1.spellName]) then
			if (Interrupts[item2.spellName]) then
				return item1.expires < item2.expires;
			else
				return true;
			end
		elseif (Interrupts[item2.spellName]) then
			return false;
		else
			return item1.expires < item2.expires;
		end
	end
	
	local function Nameplate_SortAuras(cds)
		local t = { };
		for spellName, spellInfo in pairs(cds) do
			if (spellName ~= nil) then
				table.insert(t, spellInfo);
			end
		end
		if (db.IconSortMode == CONST_SORT_MODES[1]) then
			-- // do nothing
		elseif (db.IconSortMode == CONST_SORT_MODES[2]) then
			table.sort(t, Nameplate_SortAuras_mode1);
		elseif (db.IconSortMode == CONST_SORT_MODES[3]) then
			table.sort(t, Nameplate_SortAuras_mode2);
		elseif (db.IconSortMode == CONST_SORT_MODES[4]) then
			table.sort(t, Nameplate_SortAuras_mode3);
		elseif (db.IconSortMode == CONST_SORT_MODES[5]) then
			table.sort(t, Nameplate_SortAuras_mode4);
		end
		return t;
	end
	
	local function UpdateNameplate_SetGlow(icon, spellNeedGlow, remain)
		if (glowInfo[icon]) then
			glowInfo[icon]:Cancel(); -- // cancel delayed glow
			glowInfo[icon] = nil;
		end
		if (spellNeedGlow ~= nil) then
			if (remain < spellNeedGlow or remain > GLOW_TIME_INFINITE) then
				LBG_ShowOverlayGlow(icon, true, true); -- // show glow immediately
			else
				LBG_HideOverlayGlow(icon); -- // hide glow
				glowInfo[icon] = C_Timer_NewTimer(remain - spellNeedGlow, function() LBG_ShowOverlayGlow(icon, true, true); end); -- // queue delayed glow
			end
		else
			LBG_HideOverlayGlow(icon); -- // this aura doesn't require glow
		end
	end
	
	function UpdateOnlyOneNameplate(frame, name)
		local counter = 1;
		if (GlobalFilterNameplate(name)) then
			if (charactersDB[name]) then
				local currentTime = GetTime();
				local sortedCDs = Nameplate_SortAuras(charactersDB[name]);
				for _, spellInfo in pairs(sortedCDs) do
					local spellName = spellInfo.spellName;
					if (spellInfo.expires > currentTime) then
						local dbInfo = db.SpellCDs[spellName];
						if (counter > frame.NCIconsCount) then
							AllocateIcon(frame);
						end
						local icon = frame.NCIcons[counter];
						if (icon.textureID ~= spellInfo.texture) then
							icon.texture:SetTexture(spellInfo.texture);
							icon.textureID = spellInfo.texture;
							Nameplate_SetBorder(icon, spellName);
						end
						local remain = spellInfo.expires - currentTime;
						Nameplate_SetCooldown(icon, remain);
						UpdateNameplate_SetGlow(icon, dbInfo.glow, remain);
						if (not icon.shown) then
							ShowCDIcon(icon);
						end
						counter = counter + 1;
					else
						charactersDB[name][spellName] = nil;
					end
				end
			end
		end
		for k = counter, frame.NCIconsCount do
			local icon = frame.NCIcons[k];
			if (icon.shown) then
				HideCDIcon(icon);
			end
		end
	end
	
	function Nameplate_SetBorder(icon, spellName)
		if (db.ShowBorderInterrupts and Interrupts[spellName]) then
			if (icon.borderState ~= 1) then
				icon.border:SetVertexColor(unpack(db.BorderInterruptsColor));
				icon.border:Show();
				icon.borderState = 1;
			end
		elseif (db.ShowBorderTrinkets and Trinkets[spellName]) then
			if (icon.borderState ~= 2) then
				icon.border:SetVertexColor(unpack(db.BorderTrinketsColor));
				icon.border:Show();
				icon.borderState = 2;
			end
		elseif (icon.borderState ~= nil) then
			icon.border:Hide();
			icon.borderState = nil;
		end
	end
	
	function Nameplate_SetCooldown(icon, remain)
		if (remain >= 60) then
			icon.cooldownText:SetText(math_ceil(remain/60).."m");
		else
			icon.cooldownText:SetText(math_ceil(remain));
		end
	end
	
	function HideCDIcon(icon)
		icon.border:Hide();
		icon.borderState = nil;
		icon.cooldownText:Hide();
		icon:Hide();
		icon.shown = false;
		icon.textureID = 0;
		LBG_HideOverlayGlow(icon);
	end
	
	function ShowCDIcon(icon)
		icon.cooldownText:Show();
		icon:Show();
		icon.shown = true;
	end
	
end

-------------------------------------------------------------------------------------------------
----- OnUpdates
-------------------------------------------------------------------------------------------------
do

	function OnUpdate()
		for frame, unitName in pairs(NameplatesVisible) do
			UpdateOnlyOneNameplate(frame, unitName);
		end
	end
	
end

-------------------------------------------------------------------------------------------------
----- Test mode
-------------------------------------------------------------------------------------------------
do

	local _t = 0;
	local _charactersDB;
	local _spellCDs;
	local _spellIDs = {
		[2139] 		= 24,
		[108194] 	= 45,
		[100] 		= 17,
	};
	
	local function refreshCDs()
		local cTime = GetTime();
		for _, unitName in pairs(NameplatesVisible) do
			if (not charactersDB[unitName]) then charactersDB[unitName] = { }; end
			charactersDB[unitName][SpellNameByID[SPELL_PVPTRINKET]] = { ["spellName"] = SpellNameByID[SPELL_PVPTRINKET], ["expires"] = cTime + 120, ["texture"] = SpellTextureByID[SPELL_PVPTRINKET] }; -- // 2m test
			for spellID, cd in pairs(_spellIDs) do
				if (not charactersDB[unitName][SpellNameByID[spellID]]) then
					charactersDB[unitName][SpellNameByID[spellID]] = { ["spellName"] = SpellNameByID[spellID], ["expires"] = cTime + cd, ["texture"] = SpellTextureByID[spellID] };
				else
					if (cTime - charactersDB[unitName][SpellNameByID[spellID]]["expires"] > 0) then
						charactersDB[unitName][SpellNameByID[spellID]] = { ["spellName"] = SpellNameByID[spellID], ["expires"] = cTime + cd, ["texture"] = SpellTextureByID[spellID] };
					end
				end
			end
		end
	end
	
	function EnableTestMode()
		_charactersDB = deepcopy(charactersDB);
		_spellCDs = deepcopy(db.SpellCDs);
		db.SpellCDs = { };
		for spellID, cd in pairs(_spellIDs) do
			local spellName = SpellNameByID[spellID];
			db.SpellCDs[spellName] = GetDefaultDBEntryForSpell(spellID);
			db.SpellCDs[spellName].enabled = true;
			db.SpellCDs[spellName].cooldown = cd;
			db.SpellCDs[spellName].spellIDs = { [spellID] = true; };
		end
		db.SpellCDs[SpellNameByID[SPELL_PVPTRINKET]] = GetDefaultDBEntryForSpell(SPELL_PVPTRINKET);
		db.SpellCDs[SpellNameByID[SPELL_PVPTRINKET]].enabled = true;
		db.SpellCDs[SpellNameByID[SPELL_PVPTRINKET]].cooldown = 120;
		db.SpellCDs[SpellNameByID[SPELL_PVPTRINKET]].spellIDs = { [SPELL_PVPTRINKET] = true; };
		db.SpellCDs[SpellNameByID[SPELL_PVPTRINKET]].glow = GLOW_TIME_INFINITE;
		if (not TestFrame) then
			TestFrame = CreateFrame("frame");
			TestFrame:SetScript("OnEvent", function() DisableTestMode(); end);
		end
		TestFrame:SetScript("OnUpdate", function(self, elapsed)
			_t = _t + elapsed;
			if (_t >= 2) then
				refreshCDs();
				_t = 0;
			end
		end);
		TestFrame:RegisterEvent("PLAYER_LOGOUT");
		refreshCDs(); 	-- // for instant start
		OnUpdate();		-- // for instant start
	end
	
	function DisableTestMode()
		TestFrame:SetScript("OnUpdate", nil);
		TestFrame:UnregisterEvent("PLAYER_LOGOUT");
		charactersDB = deepcopy(_charactersDB);
		db.SpellCDs = deepcopy(_spellCDs);
		OnUpdate();		-- // for instant start
	end
	
end

-------------------------------------------------------------------------------------------------
----- GUI
-------------------------------------------------------------------------------------------------
do

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
	
	local function GUICategory_Filters(index, value)
		local checkBoxEnableOnlyForTarget;
		
		-- // checkBoxEnableOnlyForTarget
		do
		
			checkBoxEnableOnlyForTarget = LRD.CreateCheckBox();
			checkBoxEnableOnlyForTarget:SetText(L["options:general:enable-only-for-target-nameplate"]);
			checkBoxEnableOnlyForTarget:SetOnClickHandler(function(this)
				db.ShowCooldownsOnCurrentTargetOnly = this:GetChecked();
				if (db.ShowCooldownsOnCurrentTargetOnly) then
					EventFrame:RegisterEvent("PLAYER_TARGET_CHANGED");
				else
					EventFrame:UnregisterEvent("PLAYER_TARGET_CHANGED");
				end
				ReallocateAllIcons(true);
			end);
			checkBoxEnableOnlyForTarget:SetChecked(db.ShowCooldownsOnCurrentTargetOnly);
			checkBoxEnableOnlyForTarget:SetParent(GUIFrame.outline);
			checkBoxEnableOnlyForTarget:SetPoint("TOPLEFT", GUIFrame.outline, "TOPRIGHT", 15, -15);
			table_insert(GUIFrame.Categories[index], checkBoxEnableOnlyForTarget);
			table_insert(GUIFrame.OnDBChangedHandlers, function() checkBoxEnableOnlyForTarget:SetChecked(db.ShowCooldownsOnCurrentTargetOnly); end);
			
		end
		
		-- // buttonInstances
		do
			
			local zoneTypes = {
				["none"] = 					L["instance-type:none"],
				[INSTANCE_TYPE_UNKNOWN] = 	L["instance-type:unknown"],
				["pvp"] = 					L["instance-type:pvp"],
				["arena"] = 				L["instance-type:arena"],
				["party"] = 				L["instance-type:party"],
				["raid"] = 					L["instance-type:raid"],
				["scenario"] = 				L["instance-type:scenario"],
			};
			local zoneIcons = {
				["none"] = 					SpellTextureByID[6711],
				[INSTANCE_TYPE_UNKNOWN] = 	SpellTextureByID[175697],
				["pvp"] = 					SpellTextureByID[232352],
				["arena"] = 				SpellTextureByID[270697],
				["party"] = 				SpellTextureByID[77629],
				["raid"] = 					SpellTextureByID[3363],
				["scenario"] = 				SpellTextureByID[77628],
			};
			
		
			local dropdownInstances = LRD.CreateDropdownMenu();
			local buttonInstances = LRD.CreateButton();
			buttonInstances:SetParent(GUIFrame.outline);
			buttonInstances:SetText(L["filters.instance-types"]);
			
			local function setEntries()
				local entries = { };
				for instanceType, instanceLocalizatedName in pairs(zoneTypes) do
					table_insert(entries, {
						["text"] = instanceLocalizatedName,
						["icon"] = zoneIcons[instanceType],
						["func"] = function(info)
							local btn = dropdownInstances:GetButtonByText(info.text);
							if (btn) then
								info.disabled = not info.disabled;
								btn:SetGray(info.disabled);
								db.EnabledZoneTypes[info.instanceType] = not info.disabled;
							end
							ReallocateAllIcons(true);
						end,
						["disabled"] = not db.EnabledZoneTypes[instanceType],
						["dontCloseOnClick"] = true,
						["instanceType"] = instanceType,
					});
				end
				table_sort(entries, function(item1, item2) return item1.instanceType < item2.instanceType; end);
				return entries;
			end
			
			buttonInstances:SetWidth(350);
			buttonInstances:SetHeight(40);
			buttonInstances:SetPoint("TOPLEFT", checkBoxEnableOnlyForTarget, "BOTTOMLEFT", 0, -5);
			buttonInstances:SetScript("OnClick", function(self, ...)
				if (dropdownInstances:IsVisible()) then
					dropdownInstances:Hide();
				else
					dropdownInstances:SetList(setEntries());
					dropdownInstances:SetParent(self);
					dropdownInstances:ClearAllPoints();
					dropdownInstances:SetPoint("TOP", self, "BOTTOM", 0, 0);
					dropdownInstances:Show();
				end
			end);
			buttonInstances:SetScript("OnHide", function() dropdownInstances:Hide(); end);
			table_insert(GUIFrame.Categories[index], buttonInstances);
			table_insert(GUIFrame.OnDBChangedHandlers, function() dropdownInstances:SetList(setEntries()); dropdownInstances:Hide(); end);
		
		end
		
	end
	
	local function GUICategory_Borders(index, value)
		local checkBoxBorderTrinkets, checkBoxBorderInterrupts, checkBoxShowOldBlizzardBordersAroundIcons;

		-- // checkBoxBorderTrinkets
		do
			checkBoxBorderTrinkets = LRD.CreateCheckBoxWithColorPicker();
			checkBoxBorderTrinkets:SetText(L["Show border around trinkets"]);
			checkBoxBorderTrinkets:SetOnClickHandler(function(this)
				db.ShowBorderTrinkets = this:GetChecked();
				ReallocateAllIcons(true);
			end);
			checkBoxBorderTrinkets:SetParent(GUIFrame.outline);
			checkBoxBorderTrinkets:SetPoint("TOPLEFT", GUIFrame.outline, "TOPRIGHT", 15, -15);
			checkBoxBorderTrinkets:SetChecked(db.ShowBorderTrinkets);
			checkBoxBorderTrinkets:SetColor(unpack(db.BorderTrinketsColor));
			checkBoxBorderTrinkets.ColorButton:SetScript("OnClick", function()
				ColorPickerFrame:Hide();
				local function callback(restore)
					local r, g, b;
					if (restore) then
						r, g, b = unpack(restore);
					else
						r, g, b = ColorPickerFrame:GetColorRGB();
					end
					db.BorderTrinketsColor = {r, g, b};
					checkBoxBorderTrinkets:SetColor(unpack(db.BorderTrinketsColor));
					ReallocateAllIcons(true);
				end
				ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc = callback, callback, callback;
				ColorPickerFrame:SetColorRGB(unpack(db.BorderTrinketsColor));
				ColorPickerFrame.hasOpacity = false;
				ColorPickerFrame.previousValues = { unpack(db.BorderTrinketsColor) };
				ColorPickerFrame:Show();
			end);
			table.insert(GUIFrame.Categories[index], checkBoxBorderTrinkets);
			table_insert(GUIFrame.OnDBChangedHandlers, function() checkBoxBorderTrinkets:SetChecked(db.ShowBorderTrinkets); checkBoxBorderTrinkets:SetColor(unpack(db.BorderTrinketsColor)); end);	
		end
		
		-- // checkBoxBorderInterrupts
		do
			checkBoxBorderInterrupts = LRD.CreateCheckBoxWithColorPicker();
			checkBoxBorderInterrupts:SetText(L["Show border around interrupts"]);
			checkBoxBorderInterrupts:SetOnClickHandler(function(this)
				db.ShowBorderInterrupts = this:GetChecked();
				ReallocateAllIcons(true);
			end);
			checkBoxBorderInterrupts:SetParent(GUIFrame.outline);
			checkBoxBorderInterrupts:SetPoint("TOPLEFT", checkBoxBorderTrinkets, "BOTTOMLEFT", 0, -5);
			checkBoxBorderInterrupts:SetChecked(db.ShowBorderInterrupts);
			checkBoxBorderInterrupts:SetColor(unpack(db.BorderInterruptsColor));
			checkBoxBorderInterrupts.ColorButton:SetScript("OnClick", function()
				ColorPickerFrame:Hide();
				local function callback(restore)
					local r, g, b;
					if (restore) then
						r, g, b = unpack(restore);
					else
						r, g, b = ColorPickerFrame:GetColorRGB();
					end
					db.BorderInterruptsColor = {r, g, b};
					checkBoxBorderInterrupts:SetColor(unpack(db.BorderInterruptsColor));
					ReallocateAllIcons(true);
				end
				ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc = callback, callback, callback;
				ColorPickerFrame:SetColorRGB(unpack(db.BorderInterruptsColor));
				ColorPickerFrame.hasOpacity = false;
				ColorPickerFrame.previousValues = { unpack(db.BorderInterruptsColor) };
				ColorPickerFrame:Show();
			end);
			table.insert(GUIFrame.Categories[index], checkBoxBorderInterrupts);
			table_insert(GUIFrame.OnDBChangedHandlers, function() checkBoxBorderInterrupts:SetChecked(db.ShowBorderInterrupts); checkBoxBorderInterrupts:SetColor(unpack(db.BorderInterruptsColor)); end);
		end

		-- // checkBoxShowOldBlizzardBordersAroundIcons
		do
			checkBoxShowOldBlizzardBordersAroundIcons = LRD.CreateCheckBox();
			checkBoxShowOldBlizzardBordersAroundIcons:SetText(L["options:borders:show-blizz-borders"]);
			checkBoxShowOldBlizzardBordersAroundIcons:SetOnClickHandler(function(this)
				db.ShowOldBlizzardBorderAroundIcons = this:GetChecked();
				ReallocateAllIcons(true);
			end);
			checkBoxShowOldBlizzardBordersAroundIcons:SetParent(GUIFrame.outline);
			checkBoxShowOldBlizzardBordersAroundIcons:SetPoint("TOPLEFT", checkBoxBorderInterrupts, "BOTTOMLEFT", 0, -5);
			checkBoxShowOldBlizzardBordersAroundIcons:SetChecked(db.ShowOldBlizzardBorderAroundIcons);
			table.insert(GUIFrame.Categories[index], checkBoxShowOldBlizzardBordersAroundIcons);
			table_insert(GUIFrame.OnDBChangedHandlers, function() checkBoxShowOldBlizzardBordersAroundIcons:SetChecked(db.ShowOldBlizzardBorderAroundIcons); end);
		end
		
	end

	function InitializeGUI()
		GUIFrame = CreateFrame("Frame", "NC_GUIFrame", UIParent);
		GUIFrame:SetHeight(450);
		GUIFrame:SetWidth(540);
		GUIFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 80);
		GUIFrame:SetBackdrop({
			bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = 1,
			tileSize = 16,
			edgeSize = 16,
			insets = { left = 3, right = 3, top = 3, bottom = 3 } 
		});
		GUIFrame:SetBackdropColor(0.25, 0.24, 0.32, 1);
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
		header:SetPoint("BOTTOM", GUIFrame, "TOP", 0, 0);
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
		GUIFrame.outline:SetWidth(140);
		
		local closeButton = CreateFrame("Button", "NC_GUICloseButton", GUIFrame, "UIPanelButtonTemplate");
		closeButton:SetWidth(24);
		closeButton:SetHeight(24);
		closeButton:SetPoint("TOPRIGHT", 0, 22);
		closeButton:SetScript("OnClick", function() GUIFrame:Hide(); end);
		closeButton.text = closeButton:CreateFontString(nil, "ARTWORK", "GameFontNormal");
		closeButton.text:SetPoint("CENTER", closeButton, "CENTER", 1, -1);
		closeButton.text:SetText("X");
		
		GUIFrame.Categories = {};
		GUIFrame.SpellIcons = {};
		
		for index, value in pairs({ L["General"], L["Filters"], L["options:category:borders"], L["Profiles"], L["options:category:spells"] }) do
			local b = CreateGUICategory();
			b.index = index;
			b.text:SetText(value);
			if (index == 1) then
				b:LockHighlight();
				b.text:SetTextColor(1, 1, 1);
			end
			if (index < 5) then
				b:SetPoint("TOPLEFT", GUIFrame.outline, "TOPLEFT", 5, (index-1) * -18 - 6);
			else
				b:SetPoint("TOPLEFT", GUIFrame.outline, "TOPLEFT", 5, (index-1) * -18 - 26);
			end
			
			GUIFrame.Categories[index] = {};
			GUIFrame.OnDBChangedHandlers = { };
			
			if (value == L["General"]) then
				GUICategory_General(index, value);
			elseif (value == L["Filters"]) then
				GUICategory_Filters(index, value);
			elseif (value == L["Profiles"]) then
				GUICategory_Profiles(index, value);
			elseif (value == L["options:category:borders"]) then
				GUICategory_Borders(index, value);
			else
				GUICategory_Other(index, value);
			end
		end
	end

	function GUICategory_General(index, value)
		local buttonEnableDisableAddon = LRD.CreateButton();
		buttonEnableDisableAddon:SetParent(GUIFrame);
		buttonEnableDisableAddon:SetText(db.AddonEnabled and L["options:general:disable-addon-btn"] or L["options:general:enable-addon-btn"]);
		buttonEnableDisableAddon:SetWidth(340);
		buttonEnableDisableAddon:SetHeight(20);
		buttonEnableDisableAddon:SetPoint("TOPLEFT", GUIFrame.outline, "TOPRIGHT", 15, -5);
		buttonEnableDisableAddon:SetScript("OnClick", function(self, ...)
			if (db.AddonEnabled) then
				EventFrame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
				wipe(charactersDB);
			else
				EventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
			end
			OnUpdate();
			db.AddonEnabled = not db.AddonEnabled;
			buttonEnableDisableAddon.Text:SetText(db.AddonEnabled and L["options:general:disable-addon-btn"] or L["options:general:enable-addon-btn"]);
			Print(db.AddonEnabled and L["chat:addon-is-enabled"] or L["chat:addon-is-disabled"]);
		end);
		table.insert(GUIFrame.Categories[index], buttonEnableDisableAddon);
		table_insert(GUIFrame.OnDBChangedHandlers, function() buttonEnableDisableAddon.Text:SetText(db.AddonEnabled and L["options:general:disable-addon-btn"] or L["options:general:enable-addon-btn"]); end);
	
		local buttonSwitchTestMode = LRD.CreateButton();
		buttonSwitchTestMode:SetParent(GUIFrame);
		buttonSwitchTestMode:SetText(L["Enable test mode (need at least one visible nameplate)"]);
		buttonSwitchTestMode:SetWidth(340);
		buttonSwitchTestMode:SetHeight(20);
		buttonSwitchTestMode:SetPoint("TOPLEFT", GUIFrame.outline, "TOPRIGHT", 15, -30);
		buttonSwitchTestMode:SetScript("OnClick", function(self, ...)
			if (not TestFrame or not TestFrame:GetScript("OnUpdate")) then
				EnableTestMode();
				self.Text:SetText(L["Disable test mode"]);
			else
				DisableTestMode();
				self.Text:SetText(L["Enable test mode (need at least one visible nameplate)"]);
			end
		end);
		table.insert(GUIFrame.Categories[index], buttonSwitchTestMode);
		table_insert(GUIFrame.OnDBChangedHandlers, function() buttonSwitchTestMode.Text:SetText(L["Enable test mode (need at least one visible nameplate)"]); end);
		
		local sliderIconSize = LRD.CreateSlider();
		sliderIconSize:SetParent(GUIFrame.outline);
		sliderIconSize:SetPoint("TOPLEFT", GUIFrame.outline, "TOPRIGHT", 15, -60);
		sliderIconSize:SetHeight(100);
		sliderIconSize:SetWidth(155);
		sliderIconSize:GetTextObject():SetText(L["Icon size"]);
		sliderIconSize:GetBaseSliderObject():SetValueStep(1);
		sliderIconSize:GetBaseSliderObject():SetMinMaxValues(1, 50);
		sliderIconSize:GetBaseSliderObject():SetValue(db.IconSize);
		sliderIconSize:GetBaseSliderObject():SetScript("OnValueChanged", function(self, value)
			sliderIconSize:GetEditboxObject():SetText(tostring(math_ceil(value)));
			db.IconSize = math_ceil(value);
			ReallocateAllIcons(false);
		end);
		sliderIconSize:GetEditboxObject():SetText(tostring(db.IconSize));
		sliderIconSize:GetEditboxObject():SetScript("OnEnterPressed", function(self, value)
			if (sliderIconSize:GetEditboxObject():GetText() ~= "") then
				local v = tonumber(sliderIconSize:GetEditboxObject():GetText());
				if (v == nil) then
					sliderIconSize:GetEditboxObject():SetText(tostring(db.IconSize));
					Print(L["Value must be a number"]);
				else
					if (v > 50) then
						v = 50;
					end
					if (v < 1) then
						v = 1;
					end
					sliderIconSize:GetBaseSliderObject():SetValue(v);
				end
				sliderIconSize:GetEditboxObject():ClearFocus();
			end
		end);
		sliderIconSize:GetLowTextObject():SetText("1");
		sliderIconSize:GetHighTextObject():SetText("50");
		table.insert(GUIFrame.Categories[index], sliderIconSize);
		table_insert(GUIFrame.OnDBChangedHandlers, function() sliderIconSize:GetBaseSliderObject():SetValue(db.IconSize); sliderIconSize:GetEditboxObject():SetText(tostring(db.IconSize)); end);
		
		-- // sliderIconSpacing
		do
		
			local minValue, maxValue = 0, 50;
			local sliderIconSpacing = LRD.CreateSlider();
			sliderIconSpacing:SetParent(GUIFrame.outline);
			sliderIconSpacing:SetWidth(155);
			sliderIconSpacing:SetPoint("LEFT", sliderIconSize, "RIGHT", 30, 0);
			sliderIconSpacing.label:SetText(L["options:general:space-between-icons"]);
			sliderIconSpacing.slider:SetValueStep(1);
			sliderIconSpacing.slider:SetMinMaxValues(minValue, maxValue);
			sliderIconSpacing.slider:SetValue(db.IconSpacing);
			sliderIconSpacing.slider:SetScript("OnValueChanged", function(self, value)
				sliderIconSpacing.editbox:SetText(tostring(math_ceil(value)));
				db.IconSpacing = math_ceil(value);
				ReallocateAllIcons(true);
			end);
			sliderIconSpacing.editbox:SetText(tostring(db.IconSpacing));
			sliderIconSpacing.editbox:SetScript("OnEnterPressed", function(self, value)
				if (sliderIconSpacing.editbox:GetText() ~= "") then
					local v = tonumber(sliderIconSpacing.editbox:GetText());
					if (v == nil) then
						sliderIconSpacing.editbox:SetText(tostring(db.IconSpacing));
						msg(L["Value must be a number"]);
					else
						if (v > maxValue) then
							v = maxValue;
						end
						if (v < minValue) then
							v = minValue;
						end
						sliderIconSpacing.slider:SetValue(v);
					end
					sliderIconSpacing.editbox:ClearFocus();
				end
			end);
			sliderIconSpacing.lowtext:SetText(tostring(minValue));
			sliderIconSpacing.hightext:SetText(tostring(maxValue));
			table_insert(GUIFrame.Categories[index], sliderIconSpacing);
			table_insert(GUIFrame.OnDBChangedHandlers, function() sliderIconSpacing.slider:SetValue(db.IconSpacing); sliderIconSpacing.editbox:SetText(tostring(db.IconSpacing)); end);
		
		end
		
		local sliderIconXOffset = LRD.CreateSlider();
		sliderIconXOffset:SetParent(GUIFrame.outline);
		sliderIconXOffset:SetPoint("TOPLEFT", GUIFrame.outline, "TOPRIGHT", 15, -115);
		sliderIconXOffset:SetHeight(100);
		sliderIconXOffset:SetWidth(155);
		sliderIconXOffset:GetTextObject():SetText(L["Icon X-coord offset"]);
		sliderIconXOffset:GetBaseSliderObject():SetValueStep(1);
		sliderIconXOffset:GetBaseSliderObject():SetMinMaxValues(-200, 200);
		sliderIconXOffset:GetBaseSliderObject():SetValue(db.IconXOffset);
		sliderIconXOffset:GetBaseSliderObject():SetScript("OnValueChanged", function(self, value)
			sliderIconXOffset:GetEditboxObject():SetText(tostring(math_ceil(value)));
			db.IconXOffset = math_ceil(value);
			ReallocateAllIcons(false);
		end);
		sliderIconXOffset:GetEditboxObject():SetText(tostring(db.IconXOffset));
		sliderIconXOffset:GetEditboxObject():SetScript("OnEnterPressed", function(self, value)
			if (sliderIconXOffset:GetEditboxObject():GetText() ~= "") then
				local v = tonumber(sliderIconXOffset:GetEditboxObject():GetText());
				if (v == nil) then
					sliderIconXOffset:GetEditboxObject():SetText(tostring(db.IconXOffset));
					Print(L["Value must be a number"]);
				else
					if (v > 200) then
						v = 200;
					end
					if (v < -200) then
						v = -200;
					end
					sliderIconXOffset:GetBaseSliderObject():SetValue(v);
				end
				sliderIconXOffset:GetEditboxObject():ClearFocus();
			end
		end);
		sliderIconXOffset:GetLowTextObject():SetText("-200");
		sliderIconXOffset:GetHighTextObject():SetText("200");
		table.insert(GUIFrame.Categories[index], sliderIconXOffset);
		table_insert(GUIFrame.OnDBChangedHandlers, function() sliderIconXOffset:GetBaseSliderObject():SetValue(db.IconXOffset); sliderIconXOffset:GetEditboxObject():SetText(tostring(db.IconXOffset)); end);
		
		local sliderIconYOffset = LRD.CreateSlider();
		sliderIconYOffset:SetHeight(100);
		sliderIconYOffset:SetWidth(155);
		sliderIconYOffset:SetParent(GUIFrame.outline);
		sliderIconYOffset:SetPoint("TOPLEFT", GUIFrame.outline, "TOPRIGHT", 200, -115);
		sliderIconYOffset:GetTextObject():SetText(L["Icon Y-coord offset"]);
		sliderIconYOffset:GetBaseSliderObject():SetValueStep(1);
		sliderIconYOffset:GetBaseSliderObject():SetMinMaxValues(-200, 200);
		sliderIconYOffset:GetBaseSliderObject():SetValue(db.IconYOffset);
		sliderIconYOffset:GetBaseSliderObject():SetScript("OnValueChanged", function(self, value)
			sliderIconYOffset:GetEditboxObject():SetText(tostring(math_ceil(value)));
			db.IconYOffset = math_ceil(value);
			ReallocateAllIcons(false);
		end);
		sliderIconYOffset:GetEditboxObject():SetText(tostring(db.IconYOffset));
		sliderIconYOffset:GetEditboxObject():SetScript("OnEnterPressed", function(self, value)
			if (sliderIconYOffset:GetEditboxObject():GetText() ~= "") then
				local v = tonumber(sliderIconYOffset:GetEditboxObject():GetText());
				if (v == nil) then
					sliderIconYOffset:GetEditboxObject():SetText(tostring(db.IconYOffset));
					Print(L["Value must be a number"]);
				else
					if (v > 200) then
						v = 200;
					end
					if (v < -200) then
						v = -200;
					end
					sliderIconYOffset:GetBaseSliderObject():SetValue(v);
				end
				sliderIconYOffset:GetEditboxObject():ClearFocus();
			end
		end);
		sliderIconYOffset:GetLowTextObject():SetText("-200");
		sliderIconYOffset:GetHighTextObject():SetText("200");
		table.insert(GUIFrame.Categories[index], sliderIconYOffset);
		table_insert(GUIFrame.OnDBChangedHandlers, function() sliderIconYOffset:GetBaseSliderObject():SetValue(db.IconYOffset); sliderIconYOffset:GetEditboxObject():SetText(tostring(db.IconYOffset)); end);
		
		local checkBoxFullOpacityAlways = LRD.CreateCheckBox();
		checkBoxFullOpacityAlways:SetText(L["Always display CD icons at full opacity (ReloadUI is needed)"]);
		checkBoxFullOpacityAlways:SetOnClickHandler(function(this)
			db.FullOpacityAlways = this:GetChecked();
		end);
		checkBoxFullOpacityAlways:SetParent(GUIFrame.outline);
		checkBoxFullOpacityAlways:SetPoint("TOPLEFT", GUIFrame.outline, "TOPRIGHT", 15, -185);
		checkBoxFullOpacityAlways:SetChecked(db.FullOpacityAlways);
		table.insert(GUIFrame.Categories[index], checkBoxFullOpacityAlways);
		table_insert(GUIFrame.OnDBChangedHandlers, function() checkBoxFullOpacityAlways:SetChecked(db.FullOpacityAlways); end);
		
		local dropdownIconSortMode = CreateFrame("Frame", "NC.GUI.General.DropdownIconSortMode", GUIFrame, "UIDropDownMenuTemplate");
		UIDropDownMenu_SetWidth(dropdownIconSortMode, 300);
		dropdownIconSortMode:SetPoint("BOTTOMLEFT", GUIFrame.outline, "BOTTOMRIGHT", 10, 45);
		local info = {};
		dropdownIconSortMode.initialize = function()
			wipe(info);
			for _, sortMode in pairs(CONST_SORT_MODES) do
				info.text = CONST_SORT_MODES_L[sortMode];
				info.value = sortMode;
				info.func = function(self)
					db.IconSortMode = self.value;
					_G[dropdownIconSortMode:GetName().."Text"]:SetText(self:GetText());
				end
				info.checked = (db.IconSortMode == info.value);
				UIDropDownMenu_AddButton(info);
			end
		end
		_G[dropdownIconSortMode:GetName().."Text"]:SetText(CONST_SORT_MODES_L[db.IconSortMode]);
		dropdownIconSortMode.text = dropdownIconSortMode:CreateFontString("NC.GUI.General.DropdownIconSortMode.Label", "ARTWORK", "GameFontNormalSmall");
		dropdownIconSortMode.text:SetPoint("LEFT", 20, 15);
		dropdownIconSortMode.text:SetText(L["general.sort-mode"]);
		table.insert(GUIFrame.Categories[index], dropdownIconSortMode);
		table_insert(GUIFrame.OnDBChangedHandlers, function() _G[dropdownIconSortMode:GetName().."Text"]:SetText(CONST_SORT_MODES_L[db.IconSortMode]); end);
		
		local dropdownFont = CreateFrame("Frame", "NC_GUI_General_DropdownFont", GUIFrame, "UIDropDownMenuTemplate");
		UIDropDownMenu_SetWidth(dropdownFont, 300);
		dropdownFont:SetPoint("BOTTOMLEFT", GUIFrame.outline, "BOTTOMRIGHT", 10, 10);
		local info = {};
		dropdownFont.initialize = function()
			wipe(info);
			for idx, font in next, LibStub("LibSharedMedia-3.0"):List("font") do
				info.text = font;
				info.value = font;
				info.func = function(self)
					db.Font = self.value;
					ReallocateAllIcons(false);
					NC_GUI_General_DropdownFontText:SetText(self:GetText());
				end
				info.checked = font == db.Font;
				UIDropDownMenu_AddButton(info);
			end
		end
		NC_GUI_General_DropdownFontText:SetText(db.Font);
		dropdownFont.text = dropdownFont:CreateFontString("NC_GUI_General_DropdownFontNoteText", "ARTWORK", "GameFontNormalSmall");
		dropdownFont.text:SetPoint("LEFT", 20, 15);
		dropdownFont.text:SetText(L["Font:"]);
		table.insert(GUIFrame.Categories[index], dropdownFont);
		table_insert(GUIFrame.OnDBChangedHandlers, function() NC_GUI_General_DropdownFontText:SetText(db.Font); end);
		
	end
	
	function GUICategory_Profiles(index, value)
		local button = LRD.CreateButton();
		button:SetParent(GUIFrame);
		button:SetText(L["options:profiles:open-profiles-dialog"]);
		button:SetWidth(170);
		button:SetHeight(40);
		button:SetPoint("CENTER", GUIFrame, "CENTER", 70, 0);
		button:SetScript("OnClick", function(self, ...)
			InterfaceOptionsFrame_OpenToCategory(ProfileOptionsFrame);
			GUIFrame:Hide();
		end);
		table_insert(GUIFrame.Categories[index], button);
	end
	
	function GUICategory_Other(index, value)
		local controls = { };
		local selectedSpellName = 0;
		local dropdownMenuSpells = LRD.CreateDropdownMenu();
		local spellArea, editboxAddSpell, buttonAddSpell, dropdownSelectSpell, sliderCooldown, dropdownSpellShowType, editboxSpellID, buttonDeleteSpell, checkboxShowOnFriends,
			checkboxShowOnEnemies, checkboxAllowMultipleInstances, selectSpell, checkboxPvPMode, checkboxEnabled, checkboxGlow, areaGlow, sliderGlowThreshold, areaCooldown, areaAuraType, areaIDs,
			areaMaxAuraDurationFilter, sliderMaxAuraDurationFilter;
			
		-- // building spell cache
		do
			
			GUIFrame:HookScript("OnShow", function()
				buttonAddSpell:Disable();
				local scanAllSpells = coroutine.create(function()
					local misses = 0;
					local id = 0;
					while (misses < 400) do
						id = id + 1;
						local name, _, icon = GetSpellInfo(id);
						if (icon == 136243) then -- 136243 is the a gear icon
							misses = 0;
						elseif (name and name ~= "") then
							misses = 0;
							if (AllSpellIDsAndIconsByName[name] == nil) then AllSpellIDsAndIconsByName[name] = { }; end
							AllSpellIDsAndIconsByName[name][id] = icon;
						else
							misses = misses + 1;
						end
						coroutine.yield();
					end
					buttonAddSpell:Enable();
				end);
				CoroutineProcessor:Queue("scanAllSpells", scanAllSpells);
			end);
			GUIFrame:HookScript("OnHide", function()
				CoroutineProcessor:DeleteFromQueue("scanAllSpells");
				wipe(AllSpellIDsAndIconsByName);
			end);
			
		end
			
			
		-- // spellArea
		do
		
			spellArea = CreateFrame("Frame", nil, GUIFrame);
			spellArea:SetBackdrop({
				bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
				edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
				tile = 1,
				tileSize = 16,
				edgeSize = 16,
				insets = { left = 4, right = 4, top = 4, bottom = 4 }
			});
			spellArea:SetBackdropColor(0.1, 0.1, 0.2, 1);
			spellArea:SetBackdropBorderColor(0.8, 0.8, 0.9, 0.4);
			spellArea:SetPoint("TOPLEFT", GUIFrame.outline, "TOPRIGHT", 10, -85);
			spellArea:SetPoint("BOTTOMLEFT", GUIFrame.outline, "BOTTOMRIGHT", 10, 0);
			spellArea:SetWidth(360);
			
			spellArea.scrollArea = CreateFrame("ScrollFrame", nil, spellArea, "UIPanelScrollFrameTemplate");
			spellArea.scrollArea:SetPoint("TOPLEFT", spellArea, "TOPLEFT", 0, -3);
			spellArea.scrollArea:SetPoint("BOTTOMRIGHT", spellArea, "BOTTOMRIGHT", -8, 3);
			spellArea.scrollArea:Show();
			
			spellArea.controlsFrame = CreateFrame("Frame", nil, spellArea.scrollArea);
			spellArea.scrollArea:SetScrollChild(spellArea.controlsFrame);
			spellArea.controlsFrame:SetWidth(360);
			spellArea.controlsFrame:SetHeight(spellArea:GetHeight() + 150);
			
			spellArea.scrollBG = CreateFrame("Frame", nil, spellArea)
			spellArea.scrollBG:SetBackdrop({
				bgFile = [[Interface\Tooltips\UI-Tooltip-Background]],
				edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]], edgeSize = 16,
				insets = { left = 4, right = 3, top = 4, bottom = 3 }
			});
			spellArea.scrollBG:SetBackdropColor(0, 0, 0)
			spellArea.scrollBG:SetBackdropBorderColor(0.4, 0.4, 0.4)
			spellArea.scrollBG:SetWidth(20);
			spellArea.scrollBG:SetHeight(spellArea.scrollArea:GetHeight());
			spellArea.scrollBG:SetPoint("TOPRIGHT", spellArea.scrollArea, "TOPRIGHT", 23, 0)
			
			
			table_insert(controls, spellArea);
		
		end
		
		-- // editboxAddSpell, buttonAddSpell
		do
		
			editboxAddSpell = CreateFrame("EditBox", nil, GUIFrame, "InputBoxTemplate");
			editboxAddSpell:SetAutoFocus(false);
			editboxAddSpell:SetFontObject(GameFontHighlightSmall);
			editboxAddSpell:SetPoint("TOPLEFT", GUIFrame, 172, -30);
			editboxAddSpell:SetHeight(20);
			editboxAddSpell:SetWidth(210);
			editboxAddSpell:SetJustifyH("LEFT");
			editboxAddSpell:EnableMouse(true);
			editboxAddSpell:SetScript("OnEscapePressed", function() editboxAddSpell:ClearFocus(); end);
			editboxAddSpell:SetScript("OnEnterPressed", function() buttonAddSpell:Click(); end);
			local text = editboxAddSpell:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall");
			text:SetPoint("LEFT", 0, 15);
			text:SetText(L["options:spells:add-new-spell"]);
			hooksecurefunc("ChatEdit_InsertLink", function(link)
                if (editboxAddSpell:IsVisible() and editboxAddSpell:HasFocus() and link ~= nil) then
					local spellName = string.match(link, "%[\"?(.-)\"?%]");
					if (spellName ~= nil) then
						editboxAddSpell:SetText(spellName);
						editboxAddSpell:ClearFocus();
						return true;
					end
                end
			end);
			table_insert(GUIFrame.Categories[index], editboxAddSpell);
			
			buttonAddSpell = LRD.CreateButton();
			buttonAddSpell:SetParent(GUIFrame);
			buttonAddSpell:SetText(L["options:spells:add-spell"]);
			buttonAddSpell:SetWidth(115);
			buttonAddSpell:SetHeight(20);
			buttonAddSpell:SetPoint("LEFT", editboxAddSpell, "RIGHT", 10, 0);
			buttonAddSpell:SetScript("OnClick", function(self, ...)
				local text = editboxAddSpell:GetText();
				if (text == nil or text == "") then
					Print(L["Empty spell name!"]);
				else
					local spellName, refSpellID, userHasProvidedSpellName;
					if (tonumber(text) ~= nil) then
						userHasProvidedSpellName = true;
						refSpellID = tonumber(text);
						spellName = SpellNameByID[refSpellID];
					else
						spellName = text;
					end
					if (spellName ~= nil) then
						if (refSpellID == nil) then
							if (AllSpellIDsAndIconsByName[spellName]) then
								refSpellID = next(AllSpellIDsAndIconsByName[spellName]);
							else
								for _spellName, _spellInfo in pairs(AllSpellIDsAndIconsByName) do
									if (string_lower(_spellName) == string_lower(spellName)) then
										refSpellID = next(_spellInfo);
										spellName = SpellNameByID[refSpellID];
									end
								end
							end
						end
						if (refSpellID ~= nil) then
							if (db.SpellCDs[spellName] ~= nil) then
								msg(format(L["Spell already exists (%s)"], spellName));
							else
								db.SpellCDs[spellName] = GetDefaultDBEntryForSpell(refSpellID);
								if (userHasProvidedSpellName) then db.SpellCDs[spellName].spellIDs = { [refSpellID] = true }; end
								selectSpell:Click();
								local btn = dropdownMenuSpells:GetButtonByText(spellName);
								if (btn ~= nil) then
									btn:Click();
									LBG_ShowOverlayGlow(areaCooldown, false, true);
									C_Timer_After(3, function() LBG_HideOverlayGlow(areaCooldown); end);
								end
								ReallocateAllIcons(true);
							end
						else
							msg(L["Spell seems to be nonexistent"]);
						end
					else
						msg(L["Spell seems to be nonexistent"]);
					end
				end
				editboxAddSpell:SetText("");
				editboxAddSpell:ClearFocus();
			end);
			table_insert(GUIFrame.Categories[index], buttonAddSpell);
			
		end
		
		-- // enable & disable all spells buttons
		do

			local enableAllSpellsButton = LRD.CreateButton();
			enableAllSpellsButton.clickedOnce = false;
			enableAllSpellsButton:SetParent(dropdownMenuSpells);
			enableAllSpellsButton:SetPoint("TOPLEFT", dropdownMenuSpells, "BOTTOMLEFT", 0, -10);
			enableAllSpellsButton:SetHeight(18);
			enableAllSpellsButton:SetWidth(dropdownMenuSpells:GetWidth() / 2 - 10);
			enableAllSpellsButton:SetText(L["options:spells:enable-all-spells"]);
			enableAllSpellsButton:SetScript("OnClick", function(self)
				if (self.clickedOnce) then
					for spellName in pairs(db.SpellCDs) do
						db.SpellCDs[spellName].enabled = true;
					end
					ReallocateAllIcons(true);
					selectSpell:Click();
					self.clickedOnce = false;
					self:SetText(L["options:spells:enable-all-spells"]);
				else
					self.clickedOnce = true;
					self:SetText(L["options:spells:please-push-once-more"]);
					C_Timer_After(3, function() 
						self.clickedOnce = false;
						self:SetText(L["options:spells:enable-all-spells"]);
					end);
				end
			end);
			enableAllSpellsButton:SetScript("OnHide", function(self)
				self.clickedOnce = false;
				self:SetText(L["options:spells:enable-all-spells"]);
			end);

			local disableAllSpellsButton = LRD.CreateButton();
			disableAllSpellsButton.clickedOnce = false;
			disableAllSpellsButton:SetParent(dropdownMenuSpells);
			disableAllSpellsButton:SetPoint("LEFT", enableAllSpellsButton, "RIGHT", 10, 0);
			disableAllSpellsButton:SetPoint("TOPRIGHT", dropdownMenuSpells, "BOTTOMRIGHT", 0, -10);
			disableAllSpellsButton:SetHeight(18);
			disableAllSpellsButton:SetText(L["options:spells:disable-all-spells"]);
			disableAllSpellsButton:SetScript("OnClick", function(self)
				if (self.clickedOnce) then
					for spellName in pairs(db.SpellCDs) do
						db.SpellCDs[spellName].enabled = false;
					end
					ReallocateAllIcons(true);
					selectSpell:Click();
					self.clickedOnce = false;
					self:SetText(L["options:spells:disable-all-spells"]);
				else
					self.clickedOnce = true;
					self:SetText(L["options:spells:please-push-once-more"]);
					C_Timer_After(3, function() 
						self.clickedOnce = false;
						self:SetText(L["options:spells:disable-all-spells"]);
					end);
				end
			end);
			disableAllSpellsButton:SetScript("OnHide", function(self)
				self.clickedOnce = false;
				self:SetText(L["options:spells:disable-all-spells"]);
			end);

		end

		-- // delete all spells button
		do

			local deleteAllSpellsButton = LRD.CreateButton();
			deleteAllSpellsButton.clickedOnce = false;
			deleteAllSpellsButton:SetParent(dropdownMenuSpells);
			deleteAllSpellsButton:SetPoint("TOPLEFT", dropdownMenuSpells, "BOTTOMLEFT", 0, -29);
			deleteAllSpellsButton:SetPoint("TOPRIGHT", dropdownMenuSpells, "BOTTOMRIGHT", 0, -29);
			deleteAllSpellsButton:SetHeight(18);
			deleteAllSpellsButton:SetText(L["options:spells:delete-all-spells"]);
			deleteAllSpellsButton:SetScript("OnClick", function(self)
				if (self.clickedOnce) then
					wipe(db.SpellCDs);
					ReloadDB();
					self.clickedOnce = false;
					self:SetText(L["options:spells:delete-all-spells"]);
				else
					self.clickedOnce = true;
					self:SetText(L["options:spells:please-push-once-more"]);
					C_Timer_After(3, function() 
						self.clickedOnce = false;
						self:SetText(L["options:spells:delete-all-spells"]);
					end);
				end
			end);
			deleteAllSpellsButton:SetScript("OnHide", function(self)
				self.clickedOnce = false;
				self:SetText(L["options:spells:delete-all-spells"]);
			end);

		end
		
		-- // selectSpell
		do
		
			local function OnSpellSelected(buttonInfo)
				for _, control in pairs(controls) do
					control:Show();
				end
				selectedSpellName = buttonInfo.text;
				selectSpell.Text:SetText(buttonInfo.text);
				selectSpell:SetScript("OnEnter", function(self, ...)
					GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT");
					GameTooltip:SetSpellByID(buttonInfo.info.refSpellID);
					GameTooltip:Show();
				end);
				selectSpell:HookScript("OnLeave", function(self, ...) GameTooltip:Hide(); end);
				selectSpell.icon:SetTexture(buttonInfo.info.texture);
				selectSpell.icon:Show();
				checkboxEnabled:SetChecked(db.SpellCDs[selectedSpellName].enabled);
				if (db.SpellCDs[selectedSpellName].glow == nil) then
					checkboxGlow:SetTriState(0);
					sliderGlowThreshold:Hide();
					areaGlow:SetHeight(40);
				elseif (db.SpellCDs[selectedSpellName].glow == GLOW_TIME_INFINITE) then
					checkboxGlow:SetTriState(2);
					sliderGlowThreshold:Hide();
					areaGlow:SetHeight(40);
				else
					checkboxGlow:SetTriState(1);
					sliderGlowThreshold.slider:SetValue(db.SpellCDs[selectedSpellName].glow);
					areaGlow:SetHeight(80);
				end
				sliderCooldown.slider:SetValue(db.SpellCDs[selectedSpellName].cooldown);
				if (db.SpellCDs[selectedSpellName].spellIDs) then
					local t = { };
					for key in pairs(db.SpellCDs[selectedSpellName].spellIDs) do
						table_insert(t, key);
					end
					editboxSpellID:SetText(table.concat(t, ","));
				else
					editboxSpellID:SetText("");
				end
			end
			
			local function HideGameTooltip()
				GameTooltip:Hide();
			end
			
			local function ResetSelectSpell()
				for _, control in pairs(controls) do
					control:Hide();
				end
				selectSpell.Text:SetText(L["options:spells:click-to-select-spell"]);
				selectSpell:SetScript("OnEnter", nil);
				selectSpell:SetScript("OnLeave", nil);
				selectSpell.icon:Hide();
			end
		
			selectSpell = LRD.CreateButton();
			selectSpell:SetParent(GUIFrame);
			selectSpell:SetText(L["options:spells:click-to-select-spell"]);
			selectSpell:SetWidth(285);
			selectSpell:SetHeight(24);
			selectSpell.icon = selectSpell:CreateTexture(nil, "OVERLAY");
			selectSpell.icon:SetPoint("RIGHT", selectSpell.Text, "LEFT", -3, 0);
			selectSpell.icon:SetWidth(20);
			selectSpell.icon:SetHeight(20);
			selectSpell.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93);
			selectSpell.icon:Hide();
			selectSpell:SetPoint("BOTTOMLEFT", spellArea, "TOPLEFT", 15, 5);
			selectSpell:SetPoint("BOTTOMRIGHT", spellArea, "TOPRIGHT", -15, 5);
			selectSpell:SetScript("OnClick", function(button)
				local t = { };
				for spellName, spellInfo in pairs(db.SpellCDs) do
					table_insert(t, {
						icon = spellInfo.texture,
						text = spellName,
						info = spellInfo,
						disabled = not spellInfo.enabled,
						onEnter = function(self)
							GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
							GameTooltip:SetSpellByID(spellInfo.refSpellID);
							GameTooltip:Show();
						end,
						onLeave = HideGameTooltip,
						func = OnSpellSelected,
						checkBoxEnabled = true,
						checkBoxState = spellInfo.enabled,
						onCheckBoxClick = function(checkbox)
							db.SpellCDs[spellName].enabled = checkbox:GetChecked();
							ReallocateAllIcons(true);
							dropdownMenuSpells:GetButtonByText(spellName):SetGray(not checkbox:GetChecked());
						end,
					});
				end
				table_sort(t, function(item1, item2) return item1.text < item2.text; end);
				dropdownMenuSpells:SetList(t);
				dropdownMenuSpells:SetParent(button);
				dropdownMenuSpells:ClearAllPoints();
				dropdownMenuSpells:SetPoint("TOP", button, "BOTTOM", 0, 0);
				dropdownMenuSpells:Show();
				dropdownMenuSpells.searchBox:SetFocus();
				dropdownMenuSpells.searchBox:SetText("");
				ResetSelectSpell();
				HideGameTooltip();
			end);
			selectSpell:SetScript("OnHide", function(self)
				ResetSelectSpell();
				dropdownMenuSpells:Hide();
			end);
			table_insert(GUIFrame.Categories[index], selectSpell);
			
		end
		
		-- // checkboxEnabled
		do
			checkboxEnabled = LRD.CreateCheckBox();
			checkboxEnabled:SetText(L["options:spells:enable-tracking-of-this-spell"]);
			checkboxEnabled:SetOnClickHandler(function(self)
				db.SpellCDs[selectedSpellName].enabled = self:GetChecked();
				ReallocateAllIcons(true);
			end);
			checkboxEnabled:SetParent(spellArea.controlsFrame);
			checkboxEnabled:SetPoint("TOPLEFT", 15, -15);
			table_insert(controls, checkboxEnabled);
			
		end
		
		-- // areaCooldown
		do
		
			areaCooldown = CreateFrame("Frame", nil, spellArea.controlsFrame);
			areaCooldown:SetBackdrop({
				bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
				edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
				tile = 1,
				tileSize = 16,
				edgeSize = 16,
				insets = { left = 4, right = 4, top = 4, bottom = 4 }
			});
			areaCooldown:SetBackdropColor(0.1, 0.1, 0.2, 1);
			areaCooldown:SetBackdropBorderColor(0.8, 0.8, 0.9, 0.4);
			areaCooldown:SetPoint("TOPLEFT", checkboxEnabled, "BOTTOMLEFT", 0, -10);
			areaCooldown:SetWidth(340);
			areaCooldown:SetHeight(70);
			table_insert(controls, areaCooldown);
		
		end
		
		-- // sliderCooldown
		do
			local minV, maxV = 1, 900;
			sliderCooldown = LRD.CreateSlider();
			sliderCooldown:SetParent(areaCooldown);
			sliderCooldown:SetWidth(330);
			sliderCooldown.label:ClearAllPoints();
			sliderCooldown.label:SetPoint("CENTER", sliderCooldown, "CENTER", 0, 15);
			sliderCooldown.label:SetText(L["options:spells:cooldown-time"]);
			sliderCooldown:ClearAllPoints();
			sliderCooldown:SetPoint("CENTER", areaCooldown, "CENTER", 0, 0);
			sliderCooldown.slider:ClearAllPoints();
			sliderCooldown.slider:SetPoint("LEFT", 3, 0)
			sliderCooldown.slider:SetPoint("RIGHT", -3, 0)
			sliderCooldown.slider:SetValueStep(1);
			sliderCooldown.slider:SetMinMaxValues(minV, maxV);
			sliderCooldown.slider:SetScript("OnValueChanged", function(self, value)
				sliderCooldown.editbox:SetText(tostring(math_ceil(value)));
				db.SpellCDs[selectedSpellName].cooldown = math_ceil(value);
				ReallocateAllIcons(true);
			end);
			sliderCooldown.editbox:SetScript("OnEnterPressed", function(self, value)
				if (sliderCooldown.editbox:GetText() ~= "") then
					local v = tonumber(sliderCooldown.editbox:GetText());
					if (v == nil) then
						sliderCooldown.editbox:SetText(tostring(db.SpellCDs[selectedSpellName].cooldown));
						Print(L["Value must be a number"]);
					else
						if (v > maxV) then
							v = maxV;
						end
						if (v < minV) then
							v = minV;
						end
						sliderCooldown.slider:SetValue(v);
					end
					sliderCooldown.editbox:ClearFocus();
				end
			end);
			sliderCooldown.lowtext:SetText(tostring(minV));
			sliderCooldown.hightext:SetText(tostring(maxV));
			table_insert(controls, sliderCooldown);
			
		end
		
		-- // areaGlow
		do
		
			areaGlow = CreateFrame("Frame", nil, spellArea.controlsFrame);
			areaGlow:SetBackdrop({
				bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
				edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
				tile = 1,
				tileSize = 16,
				edgeSize = 16,
				insets = { left = 4, right = 4, top = 4, bottom = 4 }
			});
			areaGlow:SetBackdropColor(0.1, 0.1, 0.2, 1);
			areaGlow:SetBackdropBorderColor(0.8, 0.8, 0.9, 0.4);
			areaGlow:SetPoint("TOPLEFT", areaCooldown, "BOTTOMLEFT", 0, 0);
			areaGlow:SetWidth(340);
			areaGlow:SetHeight(80);
			table_insert(controls, areaGlow);
		
		end
		
		-- // checkboxGlow
		do
			checkboxGlow = LRD.CreateCheckBoxTristate();
			checkboxGlow:SetTextEntries({
				ColorizeText(L["options:spells:icon-glow"], 1, 1, 1),
				ColorizeText(L["options:spells:icon-glow-threshold"], 0, 1, 1),
				ColorizeText(L["options:spells:icon-glow-always"], 0, 1, 0),
			});
			checkboxGlow:SetOnClickHandler(function(self)
				if (self:GetTriState() == 0) then
					db.SpellCDs[selectedSpellName].glow = nil; -- // making db smaller
					sliderGlowThreshold:Hide();
					areaGlow:SetHeight(40);
				elseif (self:GetTriState() == 1) then
					db.SpellCDs[selectedSpellName].glow = 5;
					sliderGlowThreshold:Show();
					sliderGlowThreshold.slider:SetValue(5);
					areaGlow:SetHeight(80);
				else
					db.SpellCDs[selectedSpellName].glow = GLOW_TIME_INFINITE;
					sliderGlowThreshold:Hide();
					areaGlow:SetHeight(40);
				end
				ReallocateAllIcons(true);
			end);
			checkboxGlow:SetParent(areaGlow);
			checkboxGlow:SetPoint("TOPLEFT", 10, -10);
			table_insert(controls, checkboxGlow);
			
		end
		
		-- // sliderGlowThreshold
		do
		
			local minV, maxV = 1, 30;
			sliderGlowThreshold = LRD.CreateSlider();
			sliderGlowThreshold:SetParent(areaGlow);
			sliderGlowThreshold:SetWidth(320);
			sliderGlowThreshold:SetPoint("TOPLEFT", 18, -23);
			sliderGlowThreshold.label:ClearAllPoints();
			sliderGlowThreshold.label:SetPoint("CENTER", sliderGlowThreshold, "CENTER", 0, 15);
			sliderGlowThreshold.label:SetText();
			sliderGlowThreshold:ClearAllPoints();
			sliderGlowThreshold:SetPoint("TOPLEFT", areaGlow, "TOPLEFT", 10, 5);
			sliderGlowThreshold.slider:ClearAllPoints();
			sliderGlowThreshold.slider:SetPoint("LEFT", 3, 0)
			sliderGlowThreshold.slider:SetPoint("RIGHT", -3, 0)
			sliderGlowThreshold.slider:SetValueStep(1);
			sliderGlowThreshold.slider:SetMinMaxValues(minV, maxV);
			sliderGlowThreshold.slider:SetScript("OnValueChanged", function(self, value)
				sliderGlowThreshold.editbox:SetText(tostring(math_ceil(value)));
				db.SpellCDs[selectedSpellName].glow = math_ceil(value);
				ReallocateAllIcons(true);
			end);
			sliderGlowThreshold.editbox:SetScript("OnEnterPressed", function(self, value)
				if (sliderGlowThreshold.editbox:GetText() ~= "") then
					local v = tonumber(sliderGlowThreshold.editbox:GetText());
					if (v == nil) then
						sliderGlowThreshold.editbox:SetText(tostring(db.SpellCDs[selectedSpellName].glow));
						Print(L["Value must be a number"]);
					else
						if (v > maxV) then
							v = maxV;
						end
						if (v < minV) then
							v = minV;
						end
						sliderGlowThreshold.slider:SetValue(v);
					end
					sliderGlowThreshold.editbox:ClearFocus();
				end
			end);
			sliderGlowThreshold.lowtext:SetText("1");
			sliderGlowThreshold.hightext:SetText("30");
			table_insert(controls, sliderGlowThreshold);
			
		end
		
		-- // areaIDs
		do
		
			areaIDs = CreateFrame("Frame", nil, spellArea.controlsFrame);
			areaIDs:SetBackdrop({
				bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
				edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
				tile = 1,
				tileSize = 16,
				edgeSize = 16,
				insets = { left = 4, right = 4, top = 4, bottom = 4 }
			});
			areaIDs:SetBackdropColor(0.1, 0.1, 0.2, 1);
			areaIDs:SetBackdropBorderColor(0.8, 0.8, 0.9, 0.4);
			areaIDs:SetPoint("TOPLEFT", areaGlow, "BOTTOMLEFT", 0, 0);
			areaIDs:SetWidth(340);
			areaIDs:SetHeight(40);
			table_insert(controls, areaIDs);
		
		end
		
		-- // editboxSpellID
		do
		
			local function StringToTableKeys(str)
				local t = { };
				for key in gmatch(str, "%w+") do
					local nmbr = tonumber(key);
					if (nmbr ~= nil) then
						t[nmbr] = true;
					end
				end
				return t;
			end
		
			editboxSpellID = CreateFrame("EditBox", nil, areaIDs);
			editboxSpellID:SetAutoFocus(false);
			editboxSpellID:SetFontObject(GameFontHighlightSmall);
			editboxSpellID.text = editboxSpellID:CreateFontString(nil, "ARTWORK", "GameFontNormal");
			editboxSpellID.text:SetPoint("TOPLEFT", areaIDs, "TOPLEFT", 10, -10);
			editboxSpellID.text:SetText(L["options:spells:track-only-this-spellid"]);
			editboxSpellID:SetPoint("LEFT", editboxSpellID.text, "RIGHT", 5, 0);
			editboxSpellID:SetPoint("RIGHT", areaIDs, "RIGHT", -15, 0);
			editboxSpellID:SetHeight(20);
			editboxSpellID:SetJustifyH("LEFT");
			editboxSpellID:EnableMouse(true);
			editboxSpellID:SetBackdrop({
				bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
				edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
				tile = true, edgeSize = 1, tileSize = 5,
			});
			editboxSpellID:SetBackdropColor(0, 0, 0, 0.5);
			editboxSpellID:SetBackdropBorderColor(0.3, 0.3, 0.30, 0.80);
			editboxSpellID:SetScript("OnEscapePressed", function() editboxSpellID:ClearFocus(); end);
			editboxSpellID:SetScript("OnEnterPressed", function(self, value)
				local text = self:GetText();
				local t = StringToTableKeys(text);
				db.SpellCDs[selectedSpellName].spellIDs = (table_count(t) > 0) and t or nil;
				ReallocateAllIcons(true);
				if (table_count(t) == 0) then
					self:SetText("");
				end
				self:ClearFocus();
			end);
			table_insert(controls, editboxSpellID);
		
		end
		
		-- // buttonDeleteSpell
		do
		
			buttonDeleteSpell = LRD.CreateButton();
			buttonDeleteSpell:SetParent(spellArea.controlsFrame);
			buttonDeleteSpell:SetText(L["options:spells:delete-spell"]);
			buttonDeleteSpell:SetWidth(90);
			buttonDeleteSpell:SetHeight(20);
			buttonDeleteSpell:SetPoint("TOPLEFT", areaIDs, "BOTTOMLEFT", 10, -10);
			buttonDeleteSpell:SetPoint("TOPRIGHT", areaIDs, "BOTTOMRIGHT", -10, -10);
			buttonDeleteSpell:SetScript("OnClick", function(self, ...)
				db.SpellCDs[selectedSpellName] = nil;
				for spellID in pairs(addonTable.CDs) do
					local spellName = SpellNameByID[spellID];
					if (spellName == selectedSpellName and not db.UnwantedDefaultSpells[spellName]) then
						db.UnwantedDefaultSpells[spellName] = true;
						Print(string_format(L["chat:default-spell-is-added-to-ignore-list"], GetSpellLink(spellID)));
						break;
					end
				end
				ReallocateAllIcons(true);
				selectSpell.Text:SetText(L["options:spells:click-to-select-spell"]);
				selectSpell.icon:SetTexture(nil);
				for _, control in pairs(controls) do
					control:Hide();
				end
			end);
			table_insert(controls, buttonDeleteSpell);
		
		end
		
	end
	
	function OnGUICategoryClick(self, ...)
		GUIFrame.CategoryButtons[GUIFrame.ActiveCategory].text:SetTextColor(1, 0.82, 0);
		GUIFrame.CategoryButtons[GUIFrame.ActiveCategory]:UnlockHighlight();
		GUIFrame.ActiveCategory = self.index;
		self.text:SetTextColor(1, 1, 1);
		self:LockHighlight();
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
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
	end
	
	function CreateGUICategory()
		local b = CreateFrame("Button", nil, GUIFrame.outline);
		b:SetWidth(GUIFrame.outline:GetWidth()-8);
		b:SetHeight(18);
		b:SetScript("OnClick", OnGUICategoryClick);
		b:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
		b:GetHighlightTexture():SetAlpha(0.7);
		b.text = b:CreateFontString(nil, "ARTWORK", "GameFontNormal");
		b.text:SetPoint("LEFT", 3, 0);
		GUIFrame.CategoryButtons[#GUIFrame.CategoryButtons + 1] = b;
		return b;
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
	
	function table_contains_key(t, key)
		for index in pairs(t) do
			if (index == key) then
				return true;
			end
		end
		return false;
	end
	
	function ColorizeText(text, r, g, b)
		return string_format("|cff%02x%02x%02x%s|r", r*255, g*255, b*255, text);
	end
	
	function table_any(t)
		return next(t) ~= nil;
	end
	
	function table_count(t)
		local count = 0;
		for i in pairs(t) do
			count = count + 1;
		end
		return count;
	end
	
	function msg(text)
		if (StaticPopupDialogs["NCOOLDOWNS_MSG"] == nil) then
			StaticPopupDialogs["NCOOLDOWNS_MSG"] = {
				text = "NCOOLDOWNS_MSG",
				button1 = OKAY,
				timeout = 0,
				whileDead = true,
				hideOnEscape = true,
				preferredIndex = 3,
			};
		end
		StaticPopupDialogs["NCOOLDOWNS_MSG"].text = text;
		StaticPopup_Show("NCOOLDOWNS_MSG");
	end
	
	function msgWithQuestion(text, funcOnAccept, funcOnCancel)
		local frameName = "NameplateCooldowns_msgWithQuestion";
		if (StaticPopupDialogs[frameName] == nil) then
			StaticPopupDialogs[frameName] = {
				button1 = YES,
				button2 = NO,
				timeout = 0,
				whileDead = true,
				hideOnEscape = true,
				preferredIndex = 3,
			};
		end
		StaticPopupDialogs[frameName].text = text;
		StaticPopupDialogs[frameName].OnAccept = funcOnAccept;
		StaticPopupDialogs[frameName].OnCancel = funcOnCancel;
		StaticPopup_Show(frameName);
	end
	
	-- // CoroutineProcessor
	do
		CoroutineProcessor = {};
		CoroutineProcessor.frame = CreateFrame("frame");
		CoroutineProcessor.update = {};
		CoroutineProcessor.size = 0;

		function CoroutineProcessor.Queue(self, name, func)
			if (not name) then
				name = string_format("NIL%d", CoroutineProcessor.size + 1);
			end
			if (not CoroutineProcessor.update[name]) then
				CoroutineProcessor.update[name] = func;
				CoroutineProcessor.size = CoroutineProcessor.size + 1;
				CoroutineProcessor.frame:Show();
			end
		end

		function CoroutineProcessor.DeleteFromQueue(self, name)
			if (CoroutineProcessor.update[name]) then
				CoroutineProcessor.update[name] = nil;
				CoroutineProcessor.size = CoroutineProcessor.size - 1;
				if (CoroutineProcessor.size == 0) then
					CoroutineProcessor.frame:Hide();
				end
			end
		end

		CoroutineProcessor.frame:Hide();
		CoroutineProcessor.frame:SetScript("OnUpdate", function(self, elapsed)
			local start = debugprofilestop();
			local hasData = true;
			while (debugprofilestop() - start < 16 and hasData) do
				hasData = false;
				for name, func in pairs(CoroutineProcessor.update) do
					hasData = true;
					if (coroutine.status(func) ~= "dead") then
						local err, ret1, ret2 = assert(coroutine.resume(func));
					else
						CoroutineProcessor:DeleteFromQueue(name);
					end
				end
			end
		end);
	end
	
end

-------------------------------------------------------------------------------------------------
----- Frame for events
-------------------------------------------------------------------------------------------------
do

	local COMBATLOG_OBJECT_IS_HOSTILE = COMBATLOG_OBJECT_REACTION_HOSTILE;

	EventFrame = CreateFrame("Frame");
	EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
	EventFrame:SetScript("OnEvent", function(self, event, ...) self[event](...); end);
	
	EventFrame.COMBAT_LOG_EVENT_UNFILTERED = function()
		local cTime = GetTime();
		local _, eventType, _, _, srcName, srcFlags, _, _, _, _, _, spellID, spellName = CombatLogGetCurrentEventInfo();
		if (bit_band(srcFlags, COMBATLOG_OBJECT_IS_HOSTILE) ~= 0) then
			local entry = db.SpellCDs[spellName];
			if (entry and entry.enabled and (entry.spellIDs == nil or entry.spellIDs[spellID])) then
				if (eventType == "SPELL_CAST_SUCCESS" or eventType == "SPELL_AURA_APPLIED" or eventType == "SPELL_MISSED" or eventType == "SPELL_SUMMON") then
					entry.refSpellID = spellID;
					entry.texture = SpellTextureByID[spellID];
					local name = string_match(srcName, "[%P]+");
					if (not charactersDB[name]) then charactersDB[name] = { }; end
					local expires = cTime + entry.cooldown;
					charactersDB[name][spellName] = { ["spellName"] = spellName, ["expires"] = expires, ["texture"] = SpellTextureByID[spellID] };
					for frame, charName in pairs(NameplatesVisible) do
						if (charName == name) then
							UpdateOnlyOneNameplate(frame, charName);
							break;
						end
					end
				end
			end
			-- reductions
			if (Reductions[spellID] ~= nil and eventType == "SPELL_CAST_SUCCESS") then
				local name = string_match(srcName, "[%P]+");
				if (charactersDB[name]) then
					for _, sp in pairs(Reductions[spellID].spells) do
						if (charactersDB[name][SpellNameByID[sp]] ~= nil) then
							charactersDB[name][SpellNameByID[sp]].expires = charactersDB[name][SpellNameByID[sp]].expires - Reductions[spellID].reduction;
						end
					end
					for frame, charName in pairs(NameplatesVisible) do
						if (charName == name) then
							UpdateOnlyOneNameplate(frame, charName);
							break;
						end
					end
				end
			-- // pvptier 1/2 used, correcting cd of PvP trinket
			elseif (spellID == SPELL_PVPADAPTATION and db.SpellCDs[SpellNameByID[SPELL_PVPTRINKET]] ~= nil and db.SpellCDs[SpellNameByID[SPELL_PVPTRINKET]].enabled and eventType == "SPELL_AURA_APPLIED") then
				local name = string_match(srcName, "[%P]+");
				if (charactersDB[name]) then
					charactersDB[name][SpellNameByID[SPELL_PVPTRINKET]] = { ["spellName"] = SpellNameByID[SPELL_PVPTRINKET], ["expires"] = cTime + 60, ["texture"] = SpellTextureByID[SPELL_PVPTRINKET] };
					for frame, charName in pairs(NameplatesVisible) do
						if (charName == name) then
							UpdateOnlyOneNameplate(frame, charName);
							break;
						end
					end
				end
			end
		end
	end
	
	EventFrame.PLAYER_ENTERING_WORLD = function()
		if (OnStartup) then
			OnStartup();
		end
		wipe(charactersDB);
		local inInstance, instanceType = IsInInstance();
		if (not inInstance) then
			InstanceType = instanceType;
		elseif (inInstance and instanceType == "none") then
			InstanceType = INSTANCE_TYPE_UNKNOWN;
		else
			InstanceType = instanceType;
		end
	end
	
	EventFrame.NAME_PLATE_UNIT_ADDED = function(unitID)
		local nameplate = C_NamePlate.GetNamePlateForUnit(unitID);
		local unitName = UnitName(unitID);
		NameplatesVisible[nameplate] = unitName;
		if (not Nameplates[nameplate]) then
			nameplate.NCIcons = {};
			nameplate.NCIconsCount = 0;	-- // it's faster than #nameplate.NCIcons
			Nameplates[nameplate] = true;
		end
		UpdateOnlyOneNameplate(nameplate, unitName);
		if (db.FullOpacityAlways and nameplate.NCFrame) then
			nameplate.NCFrame:Show();
		end
	end
	
	EventFrame.NAME_PLATE_UNIT_REMOVED = function(unitID)
		local nameplate = C_NamePlate.GetNamePlateForUnit(unitID);
		NameplatesVisible[nameplate] = nil;
		if (db.FullOpacityAlways and nameplate.NCFrame) then
			nameplate.NCFrame:Hide();
		end
	end
	
	EventFrame.PLAYER_TARGET_CHANGED = function()
		ReallocateAllIcons(true);
	end
		
end

-------------------------------------------------------------------------------------------------
----- Frame for fun
-------------------------------------------------------------------------------------------------
local funFrame = CreateFrame("Frame");
funFrame:RegisterEvent("CHAT_MSG_ADDON");
funFrame:SetScript("OnEvent", function(self, event, ...)
	local prefix, message, channel, sender = ...;
	if (prefix == "NC_prefix") then
		if (string_find(message, "reporting")) then
			local _, toWhom = strsplit(":", message, 2);
			local myName = UnitName("player").."-"..string_gsub(GetRealmName(), " ", "");
			if (toWhom == myName and sender ~= myName) then
				Print(sender.." is using NC");
			end
		elseif (string_find(message, "requesting")) then
			C_ChatInfo.SendAddonMessage("NC_prefix", "reporting:"..sender, channel);
		end
	end
end);
C_ChatInfo.RegisterAddonMessagePrefix("NC_prefix");
