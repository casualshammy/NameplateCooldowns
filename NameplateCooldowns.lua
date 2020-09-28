if (select(4, GetBuildInfo()) < 80200) then return end

local _, addonTable = ...;
local CDs = addonTable.CDs;
local Interrupts = addonTable.Interrupts;
local Trinkets = addonTable.Trinkets;
local Reductions = addonTable.Reductions;

--[===[@non-debug@
local buildTimestamp = "@project-version@";
--@end-non-debug@]===]

-- Libraries
local L, LRD, SML, LBG_ShowOverlayGlow, LBG_HideOverlayGlow;
do
	L = LibStub("AceLocale-3.0"):GetLocale("NameplateCooldowns");
	LRD = LibStub("LibRedDropdown-1.0");
	LBG_ShowOverlayGlow, LBG_HideOverlayGlow = NAuras_LibButtonGlow.ShowOverlayGlow, NAuras_LibButtonGlow.HideOverlayGlow;
	SML = LibStub("LibSharedMedia-3.0");
	SML:Register("font", "NC_TeenBold", "Interface\\AddOns\\NameplateCooldowns\\media\\teen_bold.ttf", 255);
end

-- Consts
local SPELL_PVPADAPTATION, SPELL_PVPTRINKET, ICON_GROW_DIRECTION_RIGHT, ICON_GROW_DIRECTION_LEFT, ICON_GROW_DIRECTION_UP, ICON_GROW_DIRECTION_DOWN, SORT_MODE_NONE, SORT_MODE_TRINKET_INTERRUPT_OTHER,
	SORT_MODE_INTERRUPT_TRINKET_OTHER, SORT_MODE_TRINKET_OTHER, SORT_MODE_INTERRUPT_OTHER;
do
	SPELL_PVPADAPTATION, SPELL_PVPTRINKET = addonTable.SPELL_PVPADAPTATION, addonTable.SPELL_PVPTRINKET;
	ICON_GROW_DIRECTION_RIGHT, ICON_GROW_DIRECTION_LEFT, ICON_GROW_DIRECTION_UP, ICON_GROW_DIRECTION_DOWN = 
		addonTable.ICON_GROW_DIRECTION_RIGHT, addonTable.ICON_GROW_DIRECTION_LEFT, addonTable.ICON_GROW_DIRECTION_UP, addonTable.ICON_GROW_DIRECTION_DOWN;
	SORT_MODE_NONE, SORT_MODE_TRINKET_INTERRUPT_OTHER, SORT_MODE_INTERRUPT_TRINKET_OTHER, SORT_MODE_TRINKET_OTHER, SORT_MODE_INTERRUPT_OTHER = 
		addonTable.SORT_MODE_NONE, addonTable.SORT_MODE_TRINKET_INTERRUPT_OTHER, addonTable.SORT_MODE_INTERRUPT_TRINKET_OTHER, addonTable.SORT_MODE_TRINKET_OTHER, addonTable.SORT_MODE_INTERRUPT_OTHER;
	GLOW_TIME_INFINITE = addonTable.GLOW_TIME_INFINITE;
	INSTANCE_TYPE_UNKNOWN = addonTable.INSTANCE_TYPE_UNKNOWN;
end

-- Utilities
local SpellTextureByID, SpellNameByID;
do
	SpellTextureByID, SpellNameByID = addonTable.SpellTextureByID, addonTable.SpellNameByID;
end

local SpellsPerPlayerGUID = { };
local spellNamesWithCd = { };
local AllSpellIDsAndIconsByName = { };
local ElapsedTimer = 0;
local Nameplates = {};
local NameplatesVisible = {};
local InstanceType = "none";
local GUIFrame, EventFrame, TestFrame, db, aceDB, ProfileOptionsFrame, LocalPlayerGUID;

local _G, pairs, select, UIParent, string_match, string_gsub, string_find, bit_band, GetTime, table_contains_value, math_ceil, 	table_insert, table_sort, C_Timer_After, string_lower, string_format, C_Timer_NewTimer, math_max, C_NamePlate_GetNamePlateForUnit, UnitGUID =
	  _G, pairs, select, UIParent, strmatch,	   		gsub,	  strfind, bit.band, GetTime, 			 tContains,		 ceil,	table.insert, table.sort, C_Timer.After, string.lower, string.format, C_Timer.NewTimer,		 max, C_NamePlate.GetNamePlateForUnit, UnitGUID;

local OnStartup, InitializeDB, GetDefaultDBEntryForSpell;
local AllocateIcon, ReallocateAllIcons, InitializeFrame, UpdateOnlyOneNameplate, HideCDIcon, ShowCDIcon;
local OnUpdate;
local EnableTestMode, DisableTestMode;
local ShowGUI, InitializeGUI, GUICategory_General, GUICategory_Profiles, GUICategory_Other, OnGUICategoryClick, ShowGUICategory, CreateGUICategory;

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
		if (t.TimerTextSize == nil) then
			t.TimerTextSize = math_ceil(t.IconSize - t.IconSize/2);
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
			wipe(SpellsPerPlayerGUID);
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
				IconSortMode = SORT_MODE_NONE,
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
				FontScale = 1,
				TimerTextSize = nil,
				TimerTextUseRelativeScale = true,
				TimerTextAnchor = "CENTER",
				TimerTextAnchorIcon = "CENTER",
				TimerTextXOffset = 0,
				TimerTextYOffset = 0,
				TimerTextColor = { 0.7, 1, 0 },
				IconGrowDirection = "right",
				CDFrameAnchor = "TOPLEFT",
				CDFrameAnchorToParent = "TOPLEFT",
				ShowCDOnAllies = false,
				ShowInactiveCD = false,
				IgnoreNameplateScale = false,
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
				if (spellName ~= nil and db.UnwantedDefaultSpells[spellName] == nil) then
					if (db.SpellCDs[spellName] == nil) then
						db.SpellCDs[spellName] = GetDefaultDBEntryForSpell(spellID);
						db.SpellCDs[spellName].cooldown = spellCd;
						db.SpellCDs[spellName].spellIDs = { [spellID] = true; };
						addonTable.Print(format(L["New spell has been added: %s"], GetSpellLink(spellID)));
					else
						if (db.SpellCDs[spellName].cooldown ~= spellCd) then
							spellsAlreadyInUserDb[spellName] = spellCd;
						end
					end
				end
			end
			if (next(spellsAlreadyInUserDb) ~= nil) then
				for spellName, spellCd in pairs(spellsAlreadyInUserDb) do
					addonTable.Print(string_format(L["chat:print-updated-spells"], spellName, db.SpellCDs[spellName].cooldown, spellCd));
				end
				addonTable.msgWithQuestion(L["msg:question:import-existing-spells"], 
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
		LocalPlayerGUID = UnitGUID("player");
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
			addonTable.Print(L["chat:addon-is-disabled-note"]);
		end
		if (db.ShowCooldownsOnCurrentTargetOnly) then
			EventFrame:RegisterEvent("PLAYER_TARGET_CHANGED");
			--addonTable.Print(L["chat:enable-only-for-target-nameplate"]);
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
				addonTable.Print("Waiting for replies from " .. c);
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
	
	local function AllocateIcon_SetIconPlace(frame, icon, iconIndex)
		icon:ClearAllPoints();
		local index = iconIndex == nil and frame.NCIconsCount or (iconIndex-1)
		if (index == 0) then
			if (db.IconGrowDirection == ICON_GROW_DIRECTION_RIGHT) then
				icon:SetPoint("LEFT", frame.NCFrame, "LEFT", 0, 0);
			elseif (db.IconGrowDirection == ICON_GROW_DIRECTION_LEFT) then
				icon:SetPoint("RIGHT", frame.NCFrame, "RIGHT", 0, 0);
			elseif (db.IconGrowDirection == ICON_GROW_DIRECTION_UP) then
				icon:SetPoint("BOTTOM", frame.NCFrame, "BOTTOM", 0, 0);
			else -- // down
				icon:SetPoint("TOP", frame.NCFrame, "TOP", 0, 0);
			end
		else
			if (db.IconGrowDirection == ICON_GROW_DIRECTION_RIGHT) then
				icon:SetPoint("LEFT", frame.NCIcons[index], "RIGHT", db.IconSpacing, 0);
			elseif (db.IconGrowDirection == ICON_GROW_DIRECTION_LEFT) then
				icon:SetPoint("RIGHT", frame.NCIcons[index], "LEFT", -db.IconSpacing, 0);
			elseif (db.IconGrowDirection == ICON_GROW_DIRECTION_UP) then
				icon:SetPoint("BOTTOM", frame.NCIcons[index], "TOP", 0, db.IconSpacing);
			else -- // down
				icon:SetPoint("TOP", frame.NCIcons[index], "BOTTOM", 0, -db.IconSpacing);
			end
		end
	end

	local function SetFrameSize(frame)
		local maxWidth, maxHeight = 0, 0;
		local vertical = db.IconGrowDirection == ICON_GROW_DIRECTION_RIGHT or db.IconGrowDirection == ICON_GROW_DIRECTION_LEFT;
		if (frame.NCFrame) then
			for iconIndex, icon in pairs(frame.NCIcons) do
				if (icon.shown) then
					if (vertical) then -- right -- left
						maxHeight = math_max(maxHeight, icon:GetHeight());
						maxWidth = maxWidth + icon:GetWidth() + db.IconSpacing;
					else -- up -- down
						maxHeight = maxHeight + icon:GetHeight() + db.IconSpacing;
						maxWidth = math_max(maxWidth, icon:GetWidth());
					end
				end
			end
		end
		maxWidth = maxWidth - db.IconSpacing;
		maxHeight = maxHeight - db.IconSpacing;
		frame.NCFrame:SetWidth(math_max(maxWidth, 1));
		frame.NCFrame:SetHeight(math_max(maxHeight, 1));
	end

	function AllocateIcon(frame)
		if (not frame.NCFrame) then
			frame.NCFrame = CreateFrame("frame", nil, frame);
			frame.NCFrame:SetIgnoreParentAlpha(db.FullOpacityAlways);
			frame.NCFrame:SetIgnoreParentScale(db.IgnoreNameplateScale);
			frame.NCFrame:SetWidth(db.IconSize);
			frame.NCFrame:SetHeight(db.IconSize);
			frame.NCFrame:SetPoint(db.CDFrameAnchor, frame, db.CDFrameAnchorToParent, db.IconXOffset, db.IconYOffset);
			frame.NCFrame:Show();
		end
		local icon = CreateFrame("frame", nil, frame.NCFrame);
		icon:SetWidth(db.IconSize);
		icon:SetHeight(db.IconSize);
		AllocateIcon_SetIconPlace(frame, icon);
		icon:Hide();
		icon.texture = icon:CreateTexture(nil, "BORDER");
		icon.texture:SetAllPoints(icon);
		if (not db.ShowOldBlizzardBorderAroundIcons) then
			icon.texture:SetTexCoord(0.07, 0.93, 0.07, 0.93);
		end
		icon.cooldownText = icon:CreateFontString(nil, "OVERLAY");
		icon.cooldownText:SetTextColor(unpack(db.TimerTextColor));
		icon.cooldownText:SetPoint(db.TimerTextAnchor, icon, db.TimerTextAnchorIcon, db.TimerTextXOffset, db.TimerTextYOffset);
		if (db.TimerTextUseRelativeScale) then
			icon.cooldownText:SetFont(SML:Fetch("font", db.Font), math_ceil((db.IconSize - db.IconSize / 2) * db.FontScale), "OUTLINE");
		else
			icon.cooldownText:SetFont(SML:Fetch("font", db.Font), db.TimerTextSize, "OUTLINE");
		end
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
				frame.NCFrame:SetIgnoreParentAlpha(db.FullOpacityAlways);
				frame.NCFrame:SetIgnoreParentScale(db.IgnoreNameplateScale);
				frame.NCFrame:ClearAllPoints();
				frame.NCFrame:SetPoint(db.CDFrameAnchor, frame, db.CDFrameAnchorToParent, db.IconXOffset, db.IconYOffset);
				local counter = 0;
				for iconIndex, icon in pairs(frame.NCIcons) do
					icon:SetWidth(db.IconSize);
					icon:SetHeight(db.IconSize);
					AllocateIcon_SetIconPlace(frame, icon, iconIndex);
					
					if (not db.ShowOldBlizzardBorderAroundIcons) then
						icon.texture:SetTexCoord(0.07, 0.93, 0.07, 0.93);
					else
						icon.texture:SetTexCoord(0, 1, 0, 1);
					end

					icon.cooldownText:SetTextColor(unpack(db.TimerTextColor));
					icon.cooldownText:ClearAllPoints();
					icon.cooldownText:SetPoint(db.TimerTextAnchor, icon, db.TimerTextAnchorIcon, db.TimerTextXOffset, db.TimerTextYOffset);
					if (db.TimerTextUseRelativeScale) then
						icon.cooldownText:SetFont(SML:Fetch("font", db.Font), math_ceil((db.IconSize - db.IconSize / 2) * db.FontScale), "OUTLINE");
					else
						icon.cooldownText:SetFont(SML:Fetch("font", db.Font), db.TimerTextSize, "OUTLINE");
					end

					if (clearSpells) then
						HideCDIcon(icon, frame);
					end
					counter = counter + 1;
				end
				SetFrameSize(frame);
			end
		end
		if (clearSpells) then
			OnUpdate();
		end
	end
	
	local function GlobalFilterNameplate(unitGUID)
		if (not db.ShowCooldownsOnCurrentTargetOnly or UnitGUID("target") == unitGUID) then
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
		if (db.IconSortMode == SORT_MODE_NONE) then
			-- // do nothing
		elseif (db.IconSortMode == SORT_MODE_TRINKET_INTERRUPT_OTHER) then
			table.sort(t, Nameplate_SortAuras_mode1);
		elseif (db.IconSortMode == SORT_MODE_INTERRUPT_TRINKET_OTHER) then
			table.sort(t, Nameplate_SortAuras_mode2);
		elseif (db.IconSortMode == SORT_MODE_TRINKET_OTHER) then
			table.sort(t, Nameplate_SortAuras_mode3);
		elseif (db.IconSortMode == SORT_MODE_INTERRUPT_OTHER) then
			table.sort(t, Nameplate_SortAuras_mode4);
		end
		return t;
	end
	
	local function UpdateNameplate_SetGlow(icon, spellNeedGlow, remain, isActive)
		if (glowInfo[icon]) then
			glowInfo[icon]:Cancel(); -- // cancel delayed glow
			glowInfo[icon] = nil;
		end
		if (not isActive) then
			if (icon.glow ~= false) then
				LBG_HideOverlayGlow(icon);
				icon.glow = false;
			end
		else
			if (spellNeedGlow ~= nil) then
				if (remain < spellNeedGlow or remain > GLOW_TIME_INFINITE) then
					if (icon.glow ~= true) then
						LBG_ShowOverlayGlow(icon, true, true); -- // show glow immediately
						icon.glow = true;
					end
				else
					LBG_HideOverlayGlow(icon); -- // hide glow
					icon.glow = false;
					glowInfo[icon] = C_Timer_NewTimer(remain - spellNeedGlow, function() LBG_ShowOverlayGlow(icon, true, true); icon.glow = true; end); -- // queue delayed glow
				end
			elseif (icon.glow ~= false) then
				LBG_HideOverlayGlow(icon); -- // this aura doesn't require glow
				icon.glow = false;
			end
		end
	end

	local function Nameplate_SetBorder(icon, spellName, isActive)
		if (isActive and db.ShowBorderInterrupts and Interrupts[spellName]) then
			if (icon.borderState ~= 1) then
				icon.border:SetVertexColor(unpack(db.BorderInterruptsColor));
				icon.border:Show();
				icon.borderState = 1;
			end
		elseif (isActive and db.ShowBorderTrinkets and Trinkets[spellName]) then
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

	local function Nameplate_SetCooldown(icon, remain, isActive)
		if (isActive) then
			local text = (remain >= 60) and (math_ceil(remain/60).."m") or math_ceil(remain);
			if (icon.text ~= text) then
				icon.cooldownText:SetText(text);
				icon.text = text;
			end
		elseif (icon.text ~= "") then
			icon.cooldownText:SetText("");
			icon.text = "";
		end
	end

	local function UpdateOnlyOneNameplate_SetTexture(icon, texture, isActive)
		if (icon.textureID ~= texture) then
			icon.texture:SetTexture(texture);
			icon.textureID = texture;
		end
		if (icon.desaturation ~= not isActive) then
			icon.texture:SetDesaturated(not isActive);
			icon.desaturation = not isActive;
		end
	end

	function UpdateOnlyOneNameplate(frame, unitGUID)
		local counter = 1;
		if (GlobalFilterNameplate(unitGUID)) then
			if (SpellsPerPlayerGUID[unitGUID]) then
				local currentTime = GetTime();
				local sortedCDs = Nameplate_SortAuras(SpellsPerPlayerGUID[unitGUID]);
				for _, spellInfo in pairs(sortedCDs) do
					local spellName = spellInfo.spellName;
					local isActiveCD = spellInfo.expires > currentTime;
					local dbInfo = db.SpellCDs[spellName];
					if (dbInfo and dbInfo.enabled and (db.ShowInactiveCD or isActiveCD)) then
						if (counter > frame.NCIconsCount) then
							AllocateIcon(frame);
						end
						local icon = frame.NCIcons[counter];
						UpdateOnlyOneNameplate_SetTexture(icon, spellInfo.texture, isActiveCD);
						local remain = spellInfo.expires - currentTime;
						UpdateNameplate_SetGlow(icon, dbInfo.glow, remain, isActiveCD);
						Nameplate_SetCooldown(icon, remain, isActiveCD);
						Nameplate_SetBorder(icon, spellName, isActiveCD);
						if (not icon.shown) then
							ShowCDIcon(icon, frame);
						end
						counter = counter + 1;
					end
				end
			end
		end
		for k = counter, frame.NCIconsCount do
			local icon = frame.NCIcons[k];
			if (icon.shown) then
				HideCDIcon(icon, frame);
			end
		end
	end
	
	function HideCDIcon(icon, frame)
		icon.border:Hide();
		icon.borderState = nil;
		icon.cooldownText:Hide();
		icon:Hide();
		icon.shown = false;
		icon.textureID = 0;
		LBG_HideOverlayGlow(icon);
		SetFrameSize(frame);
	end
	
	function ShowCDIcon(icon, frame)
		icon.cooldownText:Show();
		icon:Show();
		icon.shown = true;
		SetFrameSize(frame);
	end
	
end

-------------------------------------------------------------------------------------------------
----- OnUpdates
-------------------------------------------------------------------------------------------------
do

	function OnUpdate()
		for frame, unitGUID in pairs(NameplatesVisible) do
			UpdateOnlyOneNameplate(frame, unitGUID);
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
		for _, unitGUID in pairs(NameplatesVisible) do
			if (not SpellsPerPlayerGUID[unitGUID]) then SpellsPerPlayerGUID[unitGUID] = { }; end
			SpellsPerPlayerGUID[unitGUID][SpellNameByID[SPELL_PVPTRINKET]] = { ["spellName"] = SpellNameByID[SPELL_PVPTRINKET], ["expires"] = cTime + 120, ["texture"] = SpellTextureByID[SPELL_PVPTRINKET] }; -- // 2m test
			for spellID, cd in pairs(_spellIDs) do
				if (not SpellsPerPlayerGUID[unitGUID][SpellNameByID[spellID]]) then
					SpellsPerPlayerGUID[unitGUID][SpellNameByID[spellID]] = { ["spellName"] = SpellNameByID[spellID], ["expires"] = cTime + cd, ["texture"] = SpellTextureByID[spellID] };
				else
					if (cTime - SpellsPerPlayerGUID[unitGUID][SpellNameByID[spellID]]["expires"] > 0) then
						SpellsPerPlayerGUID[unitGUID][SpellNameByID[spellID]] = { ["spellName"] = SpellNameByID[spellID], ["expires"] = cTime + cd, ["texture"] = SpellTextureByID[spellID] };
					end
				end
			end
		end
	end
	
	function EnableTestMode()
		_charactersDB = addonTable.deepcopy(SpellsPerPlayerGUID);
		_spellCDs = addonTable.deepcopy(db.SpellCDs);
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
		SpellsPerPlayerGUID = addonTable.deepcopy(_charactersDB);
		db.SpellCDs = addonTable.deepcopy(_spellCDs);
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
			addonTable.Print(L["Options are not available in combat!"]);
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

	local function GUICategory_Text(index, value)
		local dropdownMenuFont = LRD.CreateDropdownMenu();
		local textAnchors = { "TOPRIGHT", "RIGHT", "BOTTOMRIGHT", "TOP", "CENTER", "BOTTOM", "TOPLEFT", "LEFT", "BOTTOMLEFT" };
		local textAnchorsLocalization = {
			[textAnchors[1]] = L["anchor-point:topright"],
			[textAnchors[2]] = L["anchor-point:right"],
			[textAnchors[3]] = L["anchor-point:bottomright"],
			[textAnchors[4]] = L["anchor-point:top"],
			[textAnchors[5]] = L["anchor-point:center"],
			[textAnchors[6]] = L["anchor-point:bottom"],
			[textAnchors[7]] = L["anchor-point:topleft"],
			[textAnchors[8]] = L["anchor-point:left"],
			[textAnchors[9]] = L["anchor-point:bottomleft"]
		};
		local textSizeArea, textAnchorArea;
		local sliderTimerFontScale, sliderTimerFontSize;
	
		-- // dropdownFont
		do
		
			local fonts = { };
			local button = LRD.CreateButton();
			button:SetParent(GUIFrame);
			button:SetText(L["options:text:font"] .. ": " .. db.Font);
			
			for idx, font in next, SML:List("font") do
				table_insert(fonts, {
					["text"] = font,
					["icon"] = [[Interface\AddOns\NameplateAuras\media\font.tga]],
					["func"] = function(info)
						button.Text:SetText(L["options:text:font"] .. ": " .. info.text);
						db.Font = info.text;
						ReallocateAllIcons(false);
					end,
					["options:text:font"] = SML:Fetch("font", font),
				});
			end
			table_sort(fonts, function(item1, item2) return item1.text < item2.text; end);
			
			button:SetWidth(170);
			button:SetHeight(24);
			button:SetPoint("TOPLEFT", GUIFrame, "TOPLEFT", 160, -28);
			button:SetPoint("TOPRIGHT", GUIFrame, "TOPRIGHT", -30, -28);
			button:SetScript("OnClick", function(self, ...)
				if (dropdownMenuFont:IsVisible()) then
					dropdownMenuFont:Hide();
				else
					dropdownMenuFont:SetList(fonts);
					dropdownMenuFont:SetParent(self);
					dropdownMenuFont:ClearAllPoints();
					dropdownMenuFont:SetPoint("TOP", self, "BOTTOM", 0, 0);
					dropdownMenuFont:Show();
				end
			end);
			table_insert(GUIFrame.Categories[index], button);
			
		end
	
		-- // textSizeArea
		do
		
			textSizeArea = CreateFrame("Frame", nil, GUIFrame, BackdropTemplateMixin and "BackdropTemplate");
			textSizeArea:SetBackdrop({
				bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
				edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
				tile = 1,
				tileSize = 16,
				edgeSize = 16,
				insets = { left = 4, right = 4, top = 4, bottom = 4 }
			});
			textSizeArea:SetBackdropColor(0.1, 0.1, 0.2, 1);
			textSizeArea:SetBackdropBorderColor(0.8, 0.8, 0.9, 0.4);
			textSizeArea:SetPoint("TOPLEFT", 155, -60);
			textSizeArea:SetWidth(360);
			textSizeArea:SetHeight(71);
			table_insert(GUIFrame.Categories[index], textSizeArea);
			
		end
		
		-- // sliderTimerFontScale
		do
			
			local minValue, maxValue = 0.3, 3;
			sliderTimerFontScale = LRD.CreateSlider();
			sliderTimerFontScale:SetParent(textSizeArea);
			sliderTimerFontScale:SetWidth(200);
			sliderTimerFontScale:SetPoint("TOPLEFT", 150, -15);
			sliderTimerFontScale.label:SetText(L["options:text:font-scale"]);
			sliderTimerFontScale.slider:SetValueStep(0.1);
			sliderTimerFontScale.slider:SetMinMaxValues(minValue, maxValue);
			sliderTimerFontScale.slider:SetValue(db.FontScale);
			sliderTimerFontScale.slider:SetScript("OnValueChanged", function(self, value)
				local actualValue = tonumber(string_format("%.1f", value));
				sliderTimerFontScale.editbox:SetText(tostring(actualValue));
				db.FontScale = actualValue;
				ReallocateAllIcons(false);
			end);
			sliderTimerFontScale.editbox:SetText(tostring(db.FontScale));
			sliderTimerFontScale.editbox:SetScript("OnEnterPressed", function(self, value)
				if (sliderTimerFontScale.editbox:GetText() ~= "") then
					local v = tonumber(sliderTimerFontScale.editbox:GetText());
					if (v == nil) then
						sliderTimerFontScale.editbox:SetText(tostring(db.FontScale));
						addonTable.msg(L["Value must be a number"]);
					else
						if (v > maxValue) then
							v = maxValue;
						end
						if (v < minValue) then
							v = minValue;
						end
						sliderTimerFontScale.slider:SetValue(v);
					end
					sliderTimerFontScale.editbox:ClearFocus();
				end
			end);
			sliderTimerFontScale.lowtext:SetText(tostring(minValue));
			sliderTimerFontScale.hightext:SetText(tostring(maxValue));
			table_insert(GUIFrame.OnDBChangedHandlers, function() sliderTimerFontScale.editbox:SetText(tostring(db.FontScale)); sliderTimerFontScale.slider:SetValue(db.FontScale); end);
			
		end
	
		-- // sliderTimerFontSize
		do
			
			local minValue, maxValue = 6, 96;
			sliderTimerFontSize = LRD.CreateSlider();
			sliderTimerFontSize:SetParent(textSizeArea);
			sliderTimerFontSize:SetWidth(200);
			sliderTimerFontSize:SetPoint("TOPLEFT", 150, -15);
			sliderTimerFontSize.label:SetText(L["options:text:font-size"]);
			sliderTimerFontSize.slider:SetValueStep(1);
			sliderTimerFontSize.slider:SetMinMaxValues(minValue, maxValue);
			sliderTimerFontSize.slider:SetValue(db.TimerTextSize);
			sliderTimerFontSize.slider:SetScript("OnValueChanged", function(self, value)
				local actualValue = tonumber(string_format("%.0f", value));
				sliderTimerFontSize.editbox:SetText(tostring(actualValue));
				db.TimerTextSize = actualValue;
				ReallocateAllIcons(false);
			end);
			sliderTimerFontSize.editbox:SetText(tostring(db.TimerTextSize));
			sliderTimerFontSize.editbox:SetScript("OnEnterPressed", function(self, value)
				if (sliderTimerFontSize.editbox:GetText() ~= "") then
					local v = tonumber(sliderTimerFontSize.editbox:GetText());
					if (v == nil) then
						sliderTimerFontSize.editbox:SetText(tostring(db.TimerTextSize));
						addonTable.msg(L["Value must be a number"]);
					else
						if (v > maxValue) then
							v = maxValue;
						end
						if (v < minValue) then
							v = minValue;
						end
						sliderTimerFontSize.slider:SetValue(v);
					end
					sliderTimerFontSize.editbox:ClearFocus();
				end
			end);
			sliderTimerFontSize.lowtext:SetText(tostring(minValue));
			sliderTimerFontSize.hightext:SetText(tostring(maxValue));
			table_insert(GUIFrame.OnDBChangedHandlers, function() sliderTimerFontSize.editbox:SetText(tostring(db.TimerTextSize)); sliderTimerFontSize.slider:SetValue(db.TimerTextSize); end);
			
		end
	
		-- // checkBoxUseRelativeFontSize
		do
		
			local checkBoxUseRelativeFontSize = LRD.CreateCheckBox();
			checkBoxUseRelativeFontSize:SetText(L["options:timer-text:scale-font-size"]);
			checkBoxUseRelativeFontSize:SetOnClickHandler(function(this)
				db.TimerTextUseRelativeScale = this:GetChecked();
				if (db.TimerTextUseRelativeScale) then
					sliderTimerFontScale:Show();
					sliderTimerFontSize:Hide();
				else
					sliderTimerFontScale:Hide();
					sliderTimerFontSize:Show();
				end
				ReallocateAllIcons(false);
			end);
			checkBoxUseRelativeFontSize:SetChecked(db.TimerTextUseRelativeScale);
			checkBoxUseRelativeFontSize:SetParent(textSizeArea);
			checkBoxUseRelativeFontSize:SetPoint("TOPLEFT", 10, -25);
			table_insert(GUIFrame.Categories[index], checkBoxUseRelativeFontSize);
			table_insert(GUIFrame.OnDBChangedHandlers, function()
				checkBoxUseRelativeFontSize:SetChecked(db.TimerTextUseRelativeScale);
			end);
			checkBoxUseRelativeFontSize:SetScript("OnShow", function(self)
				if (db.TimerTextUseRelativeScale) then
					sliderTimerFontScale:Show();
					sliderTimerFontSize:Hide();
				else
					sliderTimerFontScale:Hide();
					sliderTimerFontSize:Show();
				end
			end);
			checkBoxUseRelativeFontSize:SetScript("OnHide", function(self)
				sliderTimerFontScale:Hide();
				sliderTimerFontSize:Hide();
			end);
		end
	
		-- // textAnchorArea
		do
				
			textAnchorArea = CreateFrame("Frame", nil, GUIFrame, BackdropTemplateMixin and "BackdropTemplate");
			textAnchorArea:SetBackdrop({
				bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
				edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
				tile = 1,
				tileSize = 16,
				edgeSize = 16,
				insets = { left = 4, right = 4, top = 4, bottom = 4 }
			});
			textAnchorArea:SetBackdropColor(0.1, 0.1, 0.2, 1);
			textAnchorArea:SetBackdropBorderColor(0.8, 0.8, 0.9, 0.4);
			textAnchorArea:SetPoint("TOP", textSizeArea, "BOTTOM", 0, -10);
			textAnchorArea:SetWidth(textSizeArea:GetWidth());
			textAnchorArea:SetHeight(100);
			table_insert(GUIFrame.Categories[index], textAnchorArea);
		end

		-- // dropdownTimerTextAnchor
		do
			
			local dropdownTimerTextAnchor = CreateFrame("Frame", "NC.GUI.Fonts.DropdownTimerTextAnchor", textAnchorArea, "UIDropDownMenuTemplate");
			UIDropDownMenu_SetWidth(dropdownTimerTextAnchor, 145);
			dropdownTimerTextAnchor:SetPoint("TOPLEFT", 0, -15);
			local info = {};
			dropdownTimerTextAnchor.initialize = function()
				wipe(info);
				for _, anchorPoint in pairs(textAnchors) do
					info.text = textAnchorsLocalization[anchorPoint];
					info.value = anchorPoint;
					info.func = function(self)
						db.TimerTextAnchor = self.value;
						_G[dropdownTimerTextAnchor:GetName() .. "Text"]:SetText(self:GetText());
						ReallocateAllIcons(false);
					end
					info.checked = anchorPoint == db.TimerTextAnchor;
					UIDropDownMenu_AddButton(info);
				end
			end
			_G[dropdownTimerTextAnchor:GetName() .. "Text"]:SetText(textAnchorsLocalization[db.TimerTextAnchor]);
			dropdownTimerTextAnchor.text = dropdownTimerTextAnchor:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall");
			dropdownTimerTextAnchor.text:SetPoint("LEFT", 20, 15);
			dropdownTimerTextAnchor.text:SetText(L["options:text:anchor-point"]);
			table_insert(GUIFrame.Categories[index], dropdownTimerTextAnchor);
			table_insert(GUIFrame.OnDBChangedHandlers, function() _G[dropdownTimerTextAnchor:GetName() .. "Text"]:SetText(L[db.TimerTextAnchor]); end);
			
		end
	
		-- // dropdownTimerTextAnchorIcon
		do
			
			local dropdownTimerTextAnchorIcon = CreateFrame("Frame", "NC.GUI.Fonts.DropdownTimerTextAnchorIcon", textAnchorArea, "UIDropDownMenuTemplate");
			UIDropDownMenu_SetWidth(dropdownTimerTextAnchorIcon, 145);
			dropdownTimerTextAnchorIcon:SetPoint("TOPLEFT", 165, -15);
			local info = {};
			dropdownTimerTextAnchorIcon.initialize = function()
				wipe(info);
				for _, anchorPoint in pairs(textAnchors) do
					info.text = textAnchorsLocalization[anchorPoint];
					info.value = anchorPoint;
					info.func = function(self)
						db.TimerTextAnchorIcon = self.value;
						_G[dropdownTimerTextAnchorIcon:GetName() .. "Text"]:SetText(self:GetText());
						ReallocateAllIcons(false);
					end
					info.checked = anchorPoint == db.TimerTextAnchorIcon;
					UIDropDownMenu_AddButton(info);
				end
			end
			_G[dropdownTimerTextAnchorIcon:GetName() .. "Text"]:SetText(textAnchorsLocalization[db.TimerTextAnchorIcon]);
			dropdownTimerTextAnchorIcon.text = dropdownTimerTextAnchorIcon:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall");
			dropdownTimerTextAnchorIcon.text:SetPoint("LEFT", 20, 15);
			dropdownTimerTextAnchorIcon.text:SetText(L["options:text:anchor-to-icon"]);
			table_insert(GUIFrame.Categories[index], dropdownTimerTextAnchorIcon);
			table_insert(GUIFrame.OnDBChangedHandlers, function() _G[dropdownTimerTextAnchorIcon:GetName() .. "Text"]:SetText(L[db.TimerTextAnchorIcon]); end);
			
		end
			
		-- // sliderTimerTextXOffset
		do
			
			local minValue, maxValue = -100, 100;
			local sliderTimerTextXOffset = LRD.CreateSlider();
			sliderTimerTextXOffset:SetParent(textAnchorArea);
			sliderTimerTextXOffset:SetWidth(165);
			sliderTimerTextXOffset:SetPoint("TOPLEFT", 15, -50);
			sliderTimerTextXOffset.label:SetText(L["anchor-point:x-offset"]);
			sliderTimerTextXOffset.slider:SetValueStep(1);
			sliderTimerTextXOffset.slider:SetMinMaxValues(minValue, maxValue);
			sliderTimerTextXOffset.slider:SetValue(db.TimerTextXOffset);
			sliderTimerTextXOffset.slider:SetScript("OnValueChanged", function(self, value)
				local actualValue = tonumber(string_format("%.0f", value));
				sliderTimerTextXOffset.editbox:SetText(tostring(actualValue));
				db.TimerTextXOffset = actualValue;
				ReallocateAllIcons(false);
			end);
			sliderTimerTextXOffset.editbox:SetText(tostring(db.TimerTextXOffset));
			sliderTimerTextXOffset.editbox:SetScript("OnEnterPressed", function(self, value)
				if (sliderTimerTextXOffset.editbox:GetText() ~= "") then
					local v = tonumber(sliderTimerTextXOffset.editbox:GetText());
					if (v == nil) then
						sliderTimerTextXOffset.editbox:SetText(tostring(db.TimerTextXOffset));
						addonTable.msg(L["Value must be a number"]);
					else
						if (v > maxValue) then
							v = maxValue;
						end
						if (v < minValue) then
							v = minValue;
						end
						sliderTimerTextXOffset.slider:SetValue(v);
					end
					sliderTimerTextXOffset.editbox:ClearFocus();
				end
			end);
			sliderTimerTextXOffset.lowtext:SetText(tostring(minValue));
			sliderTimerTextXOffset.hightext:SetText(tostring(maxValue));
			table_insert(GUIFrame.Categories[index], sliderTimerTextXOffset);
			table_insert(GUIFrame.OnDBChangedHandlers, function() sliderTimerTextXOffset.editbox:SetText(tostring(db.TimerTextXOffset)); sliderTimerTextXOffset.slider:SetValue(db.TimerTextXOffset); end);
			
		end
	
		-- // sliderTimerTextYOffset
		do
			
			local minValue, maxValue = -100, 100;
			local sliderTimerTextYOffset = LRD.CreateSlider();
			sliderTimerTextYOffset:SetParent(textAnchorArea);
			sliderTimerTextYOffset:SetWidth(165);
			sliderTimerTextYOffset:SetPoint("TOPLEFT", 185, -50);
			sliderTimerTextYOffset.label:SetText(L["anchor-point:y-offset"]);
			sliderTimerTextYOffset.slider:SetValueStep(1);
			sliderTimerTextYOffset.slider:SetMinMaxValues(minValue, maxValue);
			sliderTimerTextYOffset.slider:SetValue(db.TimerTextYOffset);
			sliderTimerTextYOffset.slider:SetScript("OnValueChanged", function(self, value)
				local actualValue = tonumber(string_format("%.0f", value));
				sliderTimerTextYOffset.editbox:SetText(tostring(actualValue));
				db.TimerTextYOffset = actualValue;
				ReallocateAllIcons(false);
			end);
			sliderTimerTextYOffset.editbox:SetText(tostring(db.TimerTextYOffset));
			sliderTimerTextYOffset.editbox:SetScript("OnEnterPressed", function(self, value)
				if (sliderTimerTextYOffset.editbox:GetText() ~= "") then
					local v = tonumber(sliderTimerTextYOffset.editbox:GetText());
					if (v == nil) then
						sliderTimerTextYOffset.editbox:SetText(tostring(db.TimerTextYOffset));
						addonTable.msg(L["Value must be a number"]);
					else
						if (v > maxValue) then
							v = maxValue;
						end
						if (v < minValue) then
							v = minValue;
						end
						sliderTimerTextYOffset.slider:SetValue(v);
					end
					sliderTimerTextYOffset.editbox:ClearFocus();
				end
			end);
			sliderTimerTextYOffset.lowtext:SetText(tostring(minValue));
			sliderTimerTextYOffset.hightext:SetText(tostring(maxValue));
			table_insert(GUIFrame.Categories[index], sliderTimerTextYOffset);
			table_insert(GUIFrame.OnDBChangedHandlers, function() sliderTimerTextYOffset.editbox:SetText(tostring(db.TimerTextYOffset)); sliderTimerTextYOffset.slider:SetValue(db.TimerTextYOffset); end);
			
		end
	
		-- // colorPickerTimerTextMore
		do
		
			local colorPickerTimerTextMore = LRD.CreateColorPicker();
			colorPickerTimerTextMore:SetParent(GUIFrame);
			colorPickerTimerTextMore:SetPoint("TOPLEFT", 160, -250);
			colorPickerTimerTextMore:SetText(L["options:text:color"]);
			colorPickerTimerTextMore.colorSwatch:SetVertexColor(unpack(db.TimerTextColor));
			colorPickerTimerTextMore:SetScript("OnClick", function()
				ColorPickerFrame:Hide();
				local function callback(restore)
					local r, g, b;
					if (restore) then
						r, g, b = unpack(restore);
					else
						r, g, b = ColorPickerFrame:GetColorRGB();
					end
					db.TimerTextColor = {r, g, b};
					colorPickerTimerTextMore.colorSwatch:SetVertexColor(unpack(db.TimerTextColor));
					ReallocateAllIcons(false);
				end
				ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc = callback, callback, callback;
				ColorPickerFrame:SetColorRGB(unpack(db.TimerTextColor));
				ColorPickerFrame.hasOpacity = false;
				ColorPickerFrame.previousValues = { unpack(db.TimerTextColor) };
				ColorPickerFrame:Show();
			end);
			table_insert(GUIFrame.Categories[index], colorPickerTimerTextMore);
			table_insert(GUIFrame.OnDBChangedHandlers, function() colorPickerTimerTextMore.colorSwatch:SetVertexColor(unpack(db.TimerTextColor)); end);
		end

	end

	function InitializeGUI()
		GUIFrame = CreateFrame("Frame", "NC_GUIFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate");
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
		
		GUIFrame.outline = CreateFrame("Frame", nil, GUIFrame, BackdropTemplateMixin and "BackdropTemplate");
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
		
		for index, value in pairs({ L["General"], L["Filters"], L["options:category:borders"], L["options:category:text"], L["Profiles"], L["options:category:spells"] }) do
			local b = CreateGUICategory();
			b.index = index;
			b.text:SetText(value);
			if (index == 1) then
				b:LockHighlight();
				b.text:SetTextColor(1, 1, 1);
			end
			if (index < 6) then
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
			elseif (value == L["options:category:text"]) then
				GUICategory_Text(index, value);
			else
				GUICategory_Other(index, value);
			end
		end
	end

	function GUICategory_General(index, value)
		local checkBoxFullOpacityAlways, checkboxShowCDOnAllies, checkboxShowInactiveCD;
		local frameAnchors = { "TOPRIGHT", "RIGHT", "BOTTOMRIGHT", "TOP", "CENTER", "BOTTOM", "TOPLEFT", "LEFT", "BOTTOMLEFT" };
		local frameAnchorsLocalization = {
			[frameAnchors[1]] = L["anchor-point:topright"],
			[frameAnchors[2]] = L["anchor-point:right"],
			[frameAnchors[3]] = L["anchor-point:bottomright"],
			[frameAnchors[4]] = L["anchor-point:top"],
			[frameAnchors[5]] = L["anchor-point:center"],
			[frameAnchors[6]] = L["anchor-point:bottom"],
			[frameAnchors[7]] = L["anchor-point:topleft"],
			[frameAnchors[8]] = L["anchor-point:left"],
			[frameAnchors[9]] = L["anchor-point:bottomleft"]
		};


		local buttonEnableDisableAddon = LRD.CreateButton();
		buttonEnableDisableAddon:SetParent(GUIFrame);
		buttonEnableDisableAddon:SetText(db.AddonEnabled and L["options:general:disable-addon-btn"] or L["options:general:enable-addon-btn"]);
		buttonEnableDisableAddon:SetWidth(340);
		buttonEnableDisableAddon:SetHeight(20);
		buttonEnableDisableAddon:SetPoint("TOPLEFT", GUIFrame.outline, "TOPRIGHT", 15, -5);
		buttonEnableDisableAddon:SetScript("OnClick", function(self, ...)
			if (db.AddonEnabled) then
				EventFrame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
				wipe(SpellsPerPlayerGUID);
			else
				EventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
			end
			OnUpdate();
			db.AddonEnabled = not db.AddonEnabled;
			buttonEnableDisableAddon.Text:SetText(db.AddonEnabled and L["options:general:disable-addon-btn"] or L["options:general:enable-addon-btn"]);
			addonTable.Print(db.AddonEnabled and L["chat:addon-is-enabled"] or L["chat:addon-is-disabled"]);
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
					addonTable.Print(L["Value must be a number"]);
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
						addonTable.msg(L["Value must be a number"]);
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
					addonTable.Print(L["Value must be a number"]);
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
					addonTable.Print(L["Value must be a number"]);
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
		
		
		-- // dropdownFrameAnchor
		do
			
			local dropdownFrameAnchor = CreateFrame("Frame", "NC.GUI.Fonts.DropdownFrameAnchor", GUIFrame, "UIDropDownMenuTemplate");
			UIDropDownMenu_SetWidth(dropdownFrameAnchor, 140);
			dropdownFrameAnchor:SetPoint("TOPLEFT", 155, -200);
			local info = {};
			dropdownFrameAnchor.initialize = function()
				wipe(info);
				for _, anchorPoint in pairs(frameAnchors) do
					info.text = frameAnchorsLocalization[anchorPoint];
					info.value = anchorPoint;
					info.func = function(self)
						db.CDFrameAnchor = self.value;
						_G[dropdownFrameAnchor:GetName() .. "Text"]:SetText(self:GetText());
						ReallocateAllIcons(false);
					end
					info.checked = anchorPoint == db.CDFrameAnchor;
					UIDropDownMenu_AddButton(info);
				end
			end
			_G[dropdownFrameAnchor:GetName() .. "Text"]:SetText(frameAnchorsLocalization[db.CDFrameAnchor]);
			dropdownFrameAnchor.text = dropdownFrameAnchor:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall");
			dropdownFrameAnchor.text:SetPoint("LEFT", 20, 15);
			dropdownFrameAnchor.text:SetText(L["options:general:anchor-point"]);
			table_insert(GUIFrame.Categories[index], dropdownFrameAnchor);
			table_insert(GUIFrame.OnDBChangedHandlers, function() _G[dropdownFrameAnchor:GetName() .. "Text"]:SetText(frameAnchorsLocalization[db.CDFrameAnchor]); end);
			
		end
	
		-- // dropdownFrameAnchorToParent
		do
			
			local dropdownFrameAnchorToParent = CreateFrame("Frame", "NC.GUI.Fonts.DropdownFrameAnchorToParent", GUIFrame, "UIDropDownMenuTemplate");
			UIDropDownMenu_SetWidth(dropdownFrameAnchorToParent, 140);
			dropdownFrameAnchorToParent:SetPoint("TOPLEFT", 315, -200);
			local info = {};
			dropdownFrameAnchorToParent.initialize = function()
				wipe(info);
				for _, anchorPoint in pairs(frameAnchors) do
					info.text = frameAnchorsLocalization[anchorPoint];
					info.value = anchorPoint;
					info.func = function(self)
						db.CDFrameAnchorToParent = self.value;
						_G[dropdownFrameAnchorToParent:GetName() .. "Text"]:SetText(self:GetText());
						ReallocateAllIcons(false);
					end
					info.checked = anchorPoint == db.CDFrameAnchorToParent;
					UIDropDownMenu_AddButton(info);
				end
			end
			_G[dropdownFrameAnchorToParent:GetName() .. "Text"]:SetText(frameAnchorsLocalization[db.CDFrameAnchorToParent]);
			dropdownFrameAnchorToParent.text = dropdownFrameAnchorToParent:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall");
			dropdownFrameAnchorToParent.text:SetPoint("LEFT", 20, 15);
			dropdownFrameAnchorToParent.text:SetText(L["options:general:anchor-point-to-parent"]);
			table_insert(GUIFrame.Categories[index], dropdownFrameAnchorToParent);
			table_insert(GUIFrame.OnDBChangedHandlers, function() _G[dropdownFrameAnchorToParent:GetName() .. "Text"]:SetText(frameAnchorsLocalization[db.CDFrameAnchorToParent]); end);
			
		end
		
		-- // checkBoxFullOpacityAlways
		do
			checkBoxFullOpacityAlways = LRD.CreateCheckBox();
			checkBoxFullOpacityAlways:SetText(L["options:general:full-opacity-always"]);
			LRD.SetTooltip(checkBoxFullOpacityAlways, L["options:general:full-opacity-always:tooltip"]);
			checkBoxFullOpacityAlways:SetOnClickHandler(function(this)
				db.FullOpacityAlways = this:GetChecked();
				ReallocateAllIcons(true);
			end);
			checkBoxFullOpacityAlways:SetParent(GUIFrame.outline);
			checkBoxFullOpacityAlways:SetPoint("TOPLEFT", 155, -320);
			checkBoxFullOpacityAlways:SetChecked(db.FullOpacityAlways);
			table.insert(GUIFrame.Categories[index], checkBoxFullOpacityAlways);
			table_insert(GUIFrame.OnDBChangedHandlers, function() checkBoxFullOpacityAlways:SetChecked(db.FullOpacityAlways); end);
			
		end

		-- // checkBoxIgnoreNameplateScale
		do
			checkBoxIgnoreNameplateScale = LRD.CreateCheckBox();
			checkBoxIgnoreNameplateScale:SetText(L["options:general:ignore-nameplate-scale"]);
			LRD.SetTooltip(checkBoxIgnoreNameplateScale, L["options:general:ignore-nameplate-scale:tooltip"]);
			checkBoxIgnoreNameplateScale:SetOnClickHandler(function(this)
				db.IgnoreNameplateScale = this:GetChecked();
				ReallocateAllIcons(true);
			end);
			checkBoxIgnoreNameplateScale:SetParent(GUIFrame.outline);
			checkBoxIgnoreNameplateScale:SetPoint("TOPLEFT", checkBoxFullOpacityAlways, "BOTTOMLEFT", 0, 0);
			checkBoxIgnoreNameplateScale:SetChecked(db.IgnoreNameplateScale);
			table.insert(GUIFrame.Categories[index], checkBoxIgnoreNameplateScale);
			table_insert(GUIFrame.OnDBChangedHandlers, function() checkBoxIgnoreNameplateScale:SetChecked(db.IgnoreNameplateScale); ReallocateAllIcons(true); end);
			
		end
		
		-- checkboxShowCDOnAllies
		do
			checkboxShowCDOnAllies = LRD.CreateCheckBox();
			checkboxShowCDOnAllies:SetText(L["options:general:show-cd-on-allies"]);
			checkboxShowCDOnAllies:SetOnClickHandler(function(this)
				db.ShowCDOnAllies = this:GetChecked();
			end);
			checkboxShowCDOnAllies:SetParent(GUIFrame.outline);
			checkboxShowCDOnAllies:SetPoint("TOPLEFT", checkBoxIgnoreNameplateScale, "BOTTOMLEFT", 0, 0);
			checkboxShowCDOnAllies:SetChecked(db.ShowCDOnAllies);
			table.insert(GUIFrame.Categories[index], checkboxShowCDOnAllies);
			table_insert(GUIFrame.OnDBChangedHandlers, function() checkboxShowCDOnAllies:SetChecked(db.ShowCDOnAllies); end);
		end

		-- checkboxShowInactiveCD
		do
			checkboxShowInactiveCD = LRD.CreateCheckBox();
			checkboxShowInactiveCD:SetText(L["options:general:show-inactive-cd"]);
			LRD.SetTooltip(checkboxShowInactiveCD, L["options:general:show-inactive-cd:tooltip"])
			checkboxShowInactiveCD:SetOnClickHandler(function(this)
				db.ShowInactiveCD = this:GetChecked();
				for frame, unitGUID in pairs(NameplatesVisible) do
					UpdateOnlyOneNameplate(frame, unitGUID);
				end
			end);
			checkboxShowInactiveCD:SetParent(GUIFrame.outline);
			checkboxShowInactiveCD:SetPoint("TOPLEFT", checkboxShowCDOnAllies, "BOTTOMLEFT", 0, 0);
			checkboxShowInactiveCD:SetChecked(db.ShowInactiveCD);
			table.insert(GUIFrame.Categories[index], checkboxShowInactiveCD);
			table_insert(GUIFrame.OnDBChangedHandlers, function() checkboxShowInactiveCD:SetChecked(db.ShowInactiveCD); end);
		end

		-- // dropdownIconSortMode
		do
			local sortModes = {
				[SORT_MODE_NONE] = "none",
				[SORT_MODE_TRINKET_INTERRUPT_OTHER] = "trinkets, then interrupts, then other spells",
				[SORT_MODE_INTERRUPT_TRINKET_OTHER] = "interrupts, then trinkets, then other spells",
				[SORT_MODE_TRINKET_OTHER] = "trinkets, then other spells",
				[SORT_MODE_INTERRUPT_OTHER] = "interrupts, then other spells",
			};

			local dropdownIconSortMode = CreateFrame("Frame", "NC.GUI.General.DropdownIconSortMode", GUIFrame, "UIDropDownMenuTemplate");
			UIDropDownMenu_SetWidth(dropdownIconSortMode, 300);
			dropdownIconSortMode:SetPoint("TOPLEFT", 155, -280);
			local info = {};
			dropdownIconSortMode.initialize = function()
				wipe(info);
				for sortMode, sortModeL in pairs(sortModes) do
					info.text = sortModeL;
					info.value = sortMode;
					info.func = function(self)
						db.IconSortMode = self.value;
						_G[dropdownIconSortMode:GetName().."Text"]:SetText(self:GetText());
					end
					info.checked = (db.IconSortMode == info.value);
					UIDropDownMenu_AddButton(info);
				end
			end
			_G[dropdownIconSortMode:GetName().."Text"]:SetText(sortModes[db.IconSortMode]);
			dropdownIconSortMode.text = dropdownIconSortMode:CreateFontString("NC.GUI.General.DropdownIconSortMode.Label", "ARTWORK", "GameFontNormalSmall");
			dropdownIconSortMode.text:SetPoint("LEFT", 20, 15);
			dropdownIconSortMode.text:SetText(L["general.sort-mode"]);
			table.insert(GUIFrame.Categories[index], dropdownIconSortMode);
			table_insert(GUIFrame.OnDBChangedHandlers, function() _G[dropdownIconSortMode:GetName().."Text"]:SetText(sortModes[db.IconSortMode]); end);
		end

		-- // dropdownIconGrowDirection
		do

			local iconGrowDirections = {
				[ICON_GROW_DIRECTION_RIGHT] = L["icon-grow-direction:right"],
				[ICON_GROW_DIRECTION_LEFT] = L["icon-grow-direction:left"],
				[ICON_GROW_DIRECTION_UP] = L["icon-grow-direction:up"],
				[ICON_GROW_DIRECTION_DOWN] = L["icon-grow-direction:down"],
			};

			local dropdownIconGrowDirection = CreateFrame("Frame", "NC.GUI.General.DropdownIconGrowDirection", GUIFrame, "UIDropDownMenuTemplate");
			UIDropDownMenu_SetWidth(dropdownIconGrowDirection, 300);
			dropdownIconGrowDirection:SetPoint("TOPLEFT", 155, -240);
			local info = {};
			dropdownIconGrowDirection.initialize = function()
				wipe(info);
				for direction, directionL in pairs(iconGrowDirections) do
					info.text = directionL;
					info.value = direction;
					info.func = function(self)
						db.IconGrowDirection = self.value;
						_G[dropdownIconGrowDirection:GetName().."Text"]:SetText(self:GetText());
						ReallocateAllIcons(false);
					end
					info.checked = (db.IconGrowDirection == info.value);
					UIDropDownMenu_AddButton(info);
				end
			end
			_G[dropdownIconGrowDirection:GetName().."Text"]:SetText(iconGrowDirections[db.IconGrowDirection]);
			dropdownIconGrowDirection.text = dropdownIconGrowDirection:CreateFontString("NC.GUI.General.DropdownIconGrowDirection.Label", "ARTWORK", "GameFontNormalSmall");
			dropdownIconGrowDirection.text:SetPoint("LEFT", 20, 15);
			dropdownIconGrowDirection.text:SetText(L["options:general:icon-grow-direction"]);
			table.insert(GUIFrame.Categories[index], dropdownIconGrowDirection);
			table_insert(GUIFrame.OnDBChangedHandlers, function() _G[dropdownIconGrowDirection:GetName().."Text"]:SetText(iconGrowDirections[db.IconGrowDirection]); end);
			
		end
				
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
				addonTable.coroutine_queue("scanAllSpells", scanAllSpells);
			end);
			GUIFrame:HookScript("OnHide", function()
				addonTable.coroutine_delete("scanAllSpells");
				wipe(AllSpellIDsAndIconsByName);
			end);
			
		end
			
			
		-- // spellArea
		do
		
			spellArea = CreateFrame("Frame", nil, GUIFrame, BackdropTemplateMixin and "BackdropTemplate");
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
			
			spellArea.scrollBG = CreateFrame("Frame", nil, spellArea, BackdropTemplateMixin and "BackdropTemplate")
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
					addonTable.Print(L["Empty spell name!"]);
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
								addonTable.msg(format(L["Spell already exists (%s)"], spellName));
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
							addonTable.msg(L["Spell seems to be nonexistent"]);
						end
					else
						addonTable.msg(L["Spell seems to be nonexistent"]);
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
						onCloseButtonClick = function(buttonInfo)
							OnSpellSelected(buttonInfo);
							buttonDeleteSpell:Click();
							selectSpell:Click();
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
		
			areaCooldown = CreateFrame("Frame", nil, spellArea.controlsFrame, BackdropTemplateMixin and "BackdropTemplate");
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
						addonTable.Print(L["Value must be a number"]);
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
		
			areaGlow = CreateFrame("Frame", nil, spellArea.controlsFrame, BackdropTemplateMixin and "BackdropTemplate");
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
				addonTable.colorize_text(L["options:spells:icon-glow"], 1, 1, 1),
				addonTable.colorize_text(L["options:spells:icon-glow-threshold"], 0, 1, 1),
				addonTable.colorize_text(L["options:spells:icon-glow-always"], 0, 1, 0),
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
						addonTable.Print(L["Value must be a number"]);
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
		
			areaIDs = CreateFrame("Frame", nil, spellArea.controlsFrame, BackdropTemplateMixin and "BackdropTemplate");
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
		
			editboxSpellID = CreateFrame("EditBox", nil, areaIDs, BackdropTemplateMixin and "BackdropTemplate");
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
				db.SpellCDs[selectedSpellName].spellIDs = (addonTable.table_count(t) > 0) and t or nil;
				ReallocateAllIcons(true);
				if (addonTable.table_count(t) == 0) then
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
						addonTable.Print(string_format(L["chat:default-spell-is-added-to-ignore-list"], GetSpellLink(spellID)));
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
----- Frame for events
-------------------------------------------------------------------------------------------------
do

	local COMBATLOG_OBJECT_IS_HOSTILE = COMBATLOG_OBJECT_REACTION_HOSTILE;

	EventFrame = CreateFrame("Frame");
	EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
	EventFrame:RegisterEvent("CHAT_MSG_ADDON");
	EventFrame:SetScript("OnEvent", function(self, event, ...) self[event](...); end);
	C_ChatInfo.RegisterAddonMessagePrefix("NC_prefix");
	
	EventFrame.COMBAT_LOG_EVENT_UNFILTERED = function()
		local cTime = GetTime();
		local _, eventType, _, srcGUID, srcName, srcFlags, _, _, _, _, _, spellID, spellName = CombatLogGetCurrentEventInfo();
		if (bit_band(srcFlags, COMBATLOG_OBJECT_IS_HOSTILE) ~= 0 or (db.ShowCDOnAllies == true and srcGUID ~= LocalPlayerGUID)) then
			local entry = db.SpellCDs[spellName];
			if (entry and entry.enabled and (entry.spellIDs == nil or entry.spellIDs[spellID])) then
				if (eventType == "SPELL_CAST_SUCCESS" or eventType == "SPELL_AURA_APPLIED" or eventType == "SPELL_MISSED" or eventType == "SPELL_SUMMON") then
					entry.refSpellID = spellID;
					entry.texture = SpellTextureByID[spellID];
					if (not SpellsPerPlayerGUID[srcGUID]) then SpellsPerPlayerGUID[srcGUID] = { }; end
					local expires = cTime + entry.cooldown;
					SpellsPerPlayerGUID[srcGUID][spellName] = { ["spellName"] = spellName, ["expires"] = expires, ["texture"] = SpellTextureByID[spellID] };
					for frame, unitGUID in pairs(NameplatesVisible) do
						if (unitGUID == srcGUID) then
							UpdateOnlyOneNameplate(frame, unitGUID);
							break;
						end
					end
				end
			end
			-- reductions
			if (Reductions[spellID] ~= nil and eventType == "SPELL_CAST_SUCCESS") then
				if (SpellsPerPlayerGUID[srcGUID]) then
					for _, sp in pairs(Reductions[spellID].spells) do
						if (SpellsPerPlayerGUID[srcGUID][SpellNameByID[sp]] ~= nil) then
							SpellsPerPlayerGUID[srcGUID][SpellNameByID[sp]].expires = SpellsPerPlayerGUID[srcGUID][SpellNameByID[sp]].expires - Reductions[spellID].reduction;
						end
					end
					for frame, unitGUID in pairs(NameplatesVisible) do
						if (unitGUID == srcGUID) then
							UpdateOnlyOneNameplate(frame, unitGUID);
							break;
						end
					end
				end
			-- // pvptier 1/2 used, correcting cd of PvP trinket
			elseif (spellID == SPELL_PVPADAPTATION and db.SpellCDs[SpellNameByID[SPELL_PVPTRINKET]] ~= nil and db.SpellCDs[SpellNameByID[SPELL_PVPTRINKET]].enabled and eventType == "SPELL_AURA_APPLIED") then
				if (SpellsPerPlayerGUID[srcGUID]) then
					SpellsPerPlayerGUID[srcGUID][SpellNameByID[SPELL_PVPTRINKET]] = { ["spellName"] = SpellNameByID[SPELL_PVPTRINKET], ["expires"] = cTime + 60, ["texture"] = SpellTextureByID[SPELL_PVPTRINKET] };
					for frame, unitGUID in pairs(NameplatesVisible) do
						if (unitGUID == srcGUID) then
							UpdateOnlyOneNameplate(frame, unitGUID);
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
		wipe(SpellsPerPlayerGUID);
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
		local nameplate = C_NamePlate_GetNamePlateForUnit(unitID);
		local unitGUID = UnitGUID(unitID);
		NameplatesVisible[nameplate] = unitGUID;
		if (not Nameplates[nameplate]) then
			nameplate.NCIcons = {};
			nameplate.NCIconsCount = 0;	-- // it's faster than #nameplate.NCIcons
			Nameplates[nameplate] = true;
		end
		UpdateOnlyOneNameplate(nameplate, unitGUID);
	end
	
	EventFrame.NAME_PLATE_UNIT_REMOVED = function(unitID)
		local nameplate = C_NamePlate_GetNamePlateForUnit(unitID);
		NameplatesVisible[nameplate] = nil;
	end
	
	EventFrame.PLAYER_TARGET_CHANGED = function()
		ReallocateAllIcons(true);
	end
	
	EventFrame.CHAT_MSG_ADDON = function(prefix, message, channel, sender)
		if (prefix == "NC_prefix") then
			if (string_find(message, "reporting")) then
				local _, toWhom = strsplit(":", message, 2);
				local myName = UnitName("player").."-"..string_gsub(GetRealmName(), " ", "");
				if (toWhom == myName and sender ~= myName) then
					addonTable.Print(sender.." is using NC");
				end
			elseif (string_find(message, "requesting")) then
				C_ChatInfo.SendAddonMessage("NC_prefix", "reporting:"..sender, channel);
			end
		end
	end

end
