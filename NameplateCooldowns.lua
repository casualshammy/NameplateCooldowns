local _, addonTable = ...;
local L = addonTable.L;
local CDs = addonTable.CDs;
local Interrupts = addonTable.Interrupts;
local Resets = addonTable.Resets;
local Trinkets = addonTable.Trinkets;

local SML = LibStub("LibSharedMedia-3.0");
SML:Register("font", "NC_TeenBold", "Interface\\AddOns\\NameplateCooldowns\\media\\teen_bold.ttf", 255);

NameplateCooldownsDB = {};
local charactersDB = {};
local CDTimeCache = {};
local CDEnabledCache = {};
local TextureCache = {};
local ElapsedTimer = 0;
local Nameplates = {};
local NameplatesVisible = {};
local WorldFrameNumChildren = 0;
local LocalPlayerFullName = UnitName("player").." - "..GetRealmName();
local GUIFrame, EventFrame, TestFrame, db;

local _G, pairs, select, WorldFrame, string_match, string_gsub, string_find, bit_band, GetTime, table_contains_value, math_ceil =
	  _G, pairs, select, WorldFrame, strmatch,	   gsub,		strfind,	 bit.band, GetTime, tContains,			  ceil;

local OnStartup, InitializeDB, AddButtonToBlizzOptions;
local AllocateIcon, ReallocateAllIcons, InitializeFrame, UpdateOnlyOneNameplate, Nameplate_SetBorder, Nameplate_SetCooldown, Nameplate_SortAuras, HideCDIcon, ShowCDIcon;
local OnUpdate;
local PLAYER_ENTERING_WORLD, COMBAT_LOG_EVENT_UNFILTERED, NAME_PLATE_UNIT_ADDED, NAME_PLATE_UNIT_REMOVED;
local EnableTestMode, DisableTestMode;
local ShowGUI, InitializeGUI, GUICategory_1, GUICategory_2, GUICategory_Other, OnGUICategoryClick, ShowGUICategory, RebuildDropdowns, CreateGUICategory, GUICreateSlider, GUICreateButton;
local Print, deepcopy, table_contains_key;

-- // consts: you should not change existing values
local CONST_SORT_MODES = { "none", "trinket-interrupt-other", "interrupt-trinket-other", "trinket-other", "interrupt-other" };
local CONST_SORT_MODES_L = {
	[CONST_SORT_MODES[1]] = "none",
	[CONST_SORT_MODES[2]] = "trinkets, then interrupts, then other spells",
	[CONST_SORT_MODES[3]] = "interrupts, then trinkets, then other spells",
	[CONST_SORT_MODES[4]] = "trinkets, then other spells",
	[CONST_SORT_MODES[5]] = "interrupts, then other spells",
};

-------------------------------------------------------------------------------------------------
----- Initialize
-------------------------------------------------------------------------------------------------
do

	function OnStartup()
		InitializeDB();
		-- // remove non-existent spells
		local badSkills = {};
		for _, k in pairs(CDs) do
			for spellID in pairs(k) do
				if (GetSpellLink(spellID) == nil) then
					db.CDsTable[spellID] = nil;
					table.insert(badSkills, spellID);
					Print("This spell doesn't exist -->> "..spellID);
				end
			end
		end
		-- // add new spells to user's db
		for _, k in pairs(CDs) do
			for spellID in pairs(k) do
				if (db.CDsTable[spellID] == nil and not table_contains_value(badSkills, spellID)) then
					db.CDsTable[spellID] = true;
					Print(format(L["New spell has been added: %s"], GetSpellLink(spellID)));
				end
			end
		end
		-- // cache initialisation
		for _, k in pairs(CDs) do
			for spellID, timeInSec in pairs(k) do
				if (db.CDsTable[spellID] == true) then
					CDEnabledCache[spellID] = true;
				end
				CDTimeCache[spellID] = timeInSec;
				TextureCache[spellID] = select(3, GetSpellInfo(spellID));
			end
		end
		if (UnitFactionGroup("player") == "Alliance") then
			TextureCache[42292] = "Interface\\Icons\\INV_Jewelry_TrinketPVP_01";
		else
			TextureCache[42292] = "Interface\\Icons\\INV_Jewelry_TrinketPVP_02";
		end
		-- // starting OnUpdate()
		EventFrame:SetScript("OnUpdate", function(self, elapsed)
			ElapsedTimer = ElapsedTimer + elapsed;
			if (ElapsedTimer >= 1) then
				OnUpdate();
				ElapsedTimer = 0;
			end
		end);
		-- // starting listening for events
		EventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
		EventFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED");
		EventFrame:RegisterEvent("NAME_PLATE_UNIT_REMOVED");
		AddButtonToBlizzOptions();
		SLASH_NAMEPLATECOOLDOWNS1 = '/nc';
		SlashCmdList["NAMEPLATECOOLDOWNS"] = function(msg, editBox)
			if (msg == "t" or msg == "ver") then
				Print("Waiting for replies...");
				SendAddonMessage("NC_prefix", "requesting", IsInGroup(2) and "INSTANCE_CHAT" or "RAID");
			else
				ShowGUI();
			end
		end
		OnStartup = nil;
	end

	function InitializeDB()
		if (NameplateCooldownsDB[LocalPlayerFullName] == nil) then
			NameplateCooldownsDB[LocalPlayerFullName] = { };
		end
		local defaults = {
			CDsTable = { },
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
		};
		for key, value in pairs(defaults) do
			if (NameplateCooldownsDB[LocalPlayerFullName][key] == nil) then
				NameplateCooldownsDB[LocalPlayerFullName][key] = value;
			end
		end
		db = NameplateCooldownsDB[LocalPlayerFullName];
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
		if (not frame.NCFrame) then
			frame.NCFrame = CreateFrame("frame", nil, db.FullOpacityAlways and WorldFrame or frame);
			frame.NCFrame:SetWidth(db.IconSize);
			frame.NCFrame:SetHeight(db.IconSize);
			frame.NCFrame:SetPoint("TOPLEFT", frame, db.IconXOffset, db.IconYOffset);
			frame.NCFrame:Show();
		end
		local texture = frame.NCFrame:CreateTexture(nil, "BORDER");
		texture:SetPoint("LEFT", frame.NCFrame, frame.NCIconsCount * db.IconSize, 0);
		texture:SetWidth(db.IconSize);
		texture:SetHeight(db.IconSize);
		texture:Hide();
		texture.cooldown = frame.NCFrame:CreateFontString(nil, "OVERLAY");
		texture.cooldown:SetTextColor(0.7, 1, 0);
		texture.cooldown:SetAllPoints(texture);
		texture.cooldown:SetFont(SML:Fetch("font", db.Font), math_ceil(db.IconSize - db.IconSize / 2), "OUTLINE");
		texture.border = frame.NCFrame:CreateTexture(nil, "OVERLAY");
		texture.border:SetTexture("Interface\\AddOns\\NameplateCooldowns\\media\\CooldownFrameBorder.tga");
		texture.border:SetVertexColor(1, 0.35, 0);
		texture.border:SetAllPoints(texture);
		texture.border:Hide();
		frame.NCIconsCount = frame.NCIconsCount + 1;
		tinsert(frame.NCIcons, texture);
	end
	
	function ReallocateAllIcons(clearSpells)
		for frame in pairs(Nameplates) do
			if (frame.NCFrame) then
				frame.NCFrame:SetPoint("TOPLEFT", frame, db.IconXOffset, db.IconYOffset);
				local counter = 0;
				for _, icon in pairs(frame.NCIcons) do
					icon:SetWidth(db.IconSize);
					icon:SetHeight(db.IconSize);
					icon:SetPoint("LEFT", frame.NCFrame, counter * db.IconSize, 0);
					icon.cooldown:SetFont(SML:Fetch("font", db.Font), math_ceil(db.IconSize - db.IconSize / 2), "OUTLINE");
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
	
	function UpdateOnlyOneNameplate(frame, name)
		local counter = 1;
		if (charactersDB[name]) then
			local currentTime = GetTime();
			local sortedCDs = Nameplate_SortAuras(charactersDB[name]);
			for _, spellInfo in pairs(sortedCDs) do
				local spellID = spellInfo.spellID;
				if (spellInfo.expires > currentTime) then
					if (counter > frame.NCIconsCount) then
						AllocateIcon(frame);
					end
					local icon = frame.NCIcons[counter];
					if (icon.spellID ~= spellID) then
						icon:SetTexture(TextureCache[spellID]);
						icon.spellID = spellID;
						Nameplate_SetBorder(icon, spellID);
					end
					local remain = spellInfo.expires - currentTime;
					Nameplate_SetCooldown(icon, remain)
					if (not icon.shown) then
						ShowCDIcon(icon);
					end
					counter = counter + 1;
				else
					charactersDB[name][spellID] = nil;
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
	
	function Nameplate_SetBorder(icon, spellID)
		if (db.ShowBorderInterrupts and table_contains_value(Interrupts, spellID)) then
			if (icon.borderState ~= 1) then
				icon.border:SetVertexColor(unpack(db.BorderInterruptsColor));
				icon.border:Show();
				icon.borderState = 1;
			end
		elseif (db.ShowBorderTrinkets and table_contains_value(Trinkets, spellID)) then
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
			icon.cooldown:SetText(math_ceil(remain/60).."m");
		else
			icon.cooldown:SetText(math_ceil(remain));
		end
	end
	
	function Nameplate_SortAuras(cds)
		local t = { };
		for spellID, spellInfo in pairs(cds) do
			if (spellID ~= nil) then
				table.insert(t, spellInfo);
			end
		end
		if (db.IconSortMode == CONST_SORT_MODES[1]) then
			-- // do nothing
		elseif (db.IconSortMode == CONST_SORT_MODES[2]) then
			table.sort(t, function(item1, item2)
				if (table_contains_value(Trinkets, item1.spellID)) then
					if (table_contains_value(Trinkets, item2.spellID)) then
						return item1.expires < item2.expires;
					else
						return true;
					end
				elseif (table_contains_value(Trinkets, item2.spellID)) then
					return false;
				elseif (table_contains_value(Interrupts, item1.spellID)) then
					if (table_contains_value(Interrupts, item2.spellID)) then
						return item1.expires < item2.expires;
					else
						return true;
					end
				elseif (table_contains_value(Interrupts, item2.spellID)) then
					return false;
				else
					return item1.expires < item2.expires;
				end
			end);
		elseif (db.IconSortMode == CONST_SORT_MODES[3]) then
			table.sort(t, function(item1, item2)
				if (table_contains_value(Interrupts, item1.spellID)) then
					if (table_contains_value(Interrupts, item2.spellID)) then
						return item1.expires < item2.expires;
					else
						return true;
					end
				elseif (table_contains_value(Interrupts, item2.spellID)) then
					return false;
				elseif (table_contains_value(Trinkets, item1.spellID)) then
					if (table_contains_value(Trinkets, item2.spellID)) then
						return item1.expires < item2.expires;
					else
						return true;
					end
				elseif (table_contains_value(Trinkets, item2.spellID)) then
					return false;
				else
					return item1.expires < item2.expires;
				end
			end);
		elseif (db.IconSortMode == CONST_SORT_MODES[4]) then
			table.sort(t, function(item1, item2)
				if (table_contains_value(Trinkets, item1.spellID)) then
					if (table_contains_value(Trinkets, item2.spellID)) then
						return item1.expires < item2.expires;
					else
						return true;
					end
				elseif (table_contains_value(Trinkets, item2.spellID)) then
					return false;
				else
					return item1.expires < item2.expires;
				end
			end);
		elseif (db.IconSortMode == CONST_SORT_MODES[5]) then
			table.sort(t, function(item1, item2)
				if (table_contains_value(Interrupts, item1.spellID)) then
					if (table_contains_value(Interrupts, item2.spellID)) then
						return item1.expires < item2.expires;
					else
						return true;
					end
				elseif (table_contains_value(Interrupts, item2.spellID)) then
					return false;
				else
					return item1.expires < item2.expires;
				end
			end);
		end
		return t;
	end
	
	function HideCDIcon(icon)
		icon.border:Hide();
		icon.borderState = nil;
		icon.cooldown:Hide();
		icon:Hide();
		icon.shown = false;
		icon.spellID = 0;
	end
	
	function ShowCDIcon(icon)
		icon.cooldown:Show();
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
		local cTime = GetTime();
		local _, eventType, _, _, srcName, srcFlags, _, _, _, _, _, spellID = ...;
		if (bit_band(srcFlags, COMBATLOG_OBJECT_IS_HOSTILE) ~= 0) then
			if (CDEnabledCache[spellID]) then
				if (eventType == "SPELL_CAST_SUCCESS" or eventType == "SPELL_AURA_APPLIED" or eventType == "SPELL_MISSED" or eventType == "SPELL_SUMMON") then
					local Name = string_match(srcName, "[%P]+");
					if (not charactersDB[Name]) then
						charactersDB[Name] = {};
					end
					local duration = CDTimeCache[spellID];
					local expires = cTime + duration;
					charactersDB[Name][spellID] = { ["spellID"] = spellID, ["duration"] = duration, ["expires"] = expires };
					for frame, charName in pairs(NameplatesVisible) do
						if (charName == Name) then
							UpdateOnlyOneNameplate(frame, charName);
							break;
						end
					end
				end
			end
			-- // resets
			if (table_contains_key(Resets, spellID)) then
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
				if (CDEnabledCache[6552] and eventType == "SPELL_CAST_SUCCESS") then
					local Name = string_match(srcName, "[%P]+");
					if (not charactersDB[Name]) then
						charactersDB[Name] = {};
					end
					local duration = CDTimeCache[6552];
					local expires = cTime + duration;
					charactersDB[Name][6552] = { ["spellID"] = 6552, ["duration"] = duration, ["expires"] = expires };
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

	function NAME_PLATE_UNIT_ADDED(...)
		local unitID = ...;
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
	
	function NAME_PLATE_UNIT_REMOVED(...)
		local unitID = ...;
		local nameplate = C_NamePlate.GetNamePlateForUnit(unitID);
		NameplatesVisible[nameplate] = nil;
		if (db.FullOpacityAlways and nameplate.NCFrame) then
			nameplate.NCFrame:Hide();
		end
	end
	
end

-------------------------------------------------------------------------------------------------
----- Test mode
-------------------------------------------------------------------------------------------------
do

	local _t = 0;
	local _charactersDB;
	local _spellIDs = {2139, 108194, 100};
	
	local function refreshCDs()
		local cTime = GetTime();
		for _, unitName in pairs(NameplatesVisible) do
			if (not charactersDB[unitName]) then
				charactersDB[unitName] = {};
			end
			charactersDB[unitName][42292] = { ["spellID"] = 42292, ["duration"] = CDTimeCache[42292], ["expires"] = cTime + CDTimeCache[42292] }; -- // 2m test
			for _, spellID in pairs(_spellIDs) do
				if (not charactersDB[unitName][spellID]) then
					charactersDB[unitName][spellID] = { ["spellID"] = spellID, ["duration"] = CDTimeCache[spellID], ["expires"] = cTime + CDTimeCache[spellID] };
				else
					if (cTime - charactersDB[unitName][spellID]["expires"] > 0) then
						charactersDB[unitName][spellID] = { ["spellID"] = spellID, ["duration"] = CDTimeCache[spellID], ["expires"] = cTime + CDTimeCache[spellID] };
					end
				end
			end
		end
	end
	
	function EnableTestMode()
		_charactersDB = deepcopy(charactersDB);
		if (not TestFrame) then
			TestFrame = CreateFrame("frame");
		end
		TestFrame:SetScript("OnUpdate", function(self, elapsed)
			_t = _t + elapsed;
			if (_t >= 2) then
				refreshCDs();
				_t = 0;
			end
		end);
		refreshCDs(); 	-- // for instant start
		OnUpdate();		-- // for instant start
	end
	
	function DisableTestMode()
		TestFrame:SetScript("OnUpdate", nil);
		charactersDB = deepcopy(_charactersDB);
		OnUpdate();		-- // for instant start
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
	
	local function GUICreateCheckBoxWithColorPicker(publicName, x, y, text, checkedChangedCallback)
		local checkBox = GUICreateCheckBox(x, y, text, checkedChangedCallback, publicName);
		checkBox.Text:SetPoint("LEFT", 40, 0);
		
		checkBox.ColorButton = CreateFrame("Button", nil, checkBox);
		checkBox.ColorButton:SetPoint("LEFT", 19, 0);
		checkBox.ColorButton:SetWidth(20);
		checkBox.ColorButton:SetHeight(20);
		checkBox.ColorButton:Hide();

		checkBox.ColorButton:EnableMouse(true);

		checkBox.ColorButton.colorSwatch = checkBox.ColorButton:CreateTexture(nil, "OVERLAY");
		checkBox.ColorButton.colorSwatch:SetWidth(19);
		checkBox.ColorButton.colorSwatch:SetHeight(19);
		checkBox.ColorButton.colorSwatch:SetTexture("Interface\\ChatFrame\\ChatFrameColorSwatch");
		checkBox.ColorButton.colorSwatch:SetPoint("LEFT");
		checkBox.ColorButton.SetColor = checkBox.ColorButton.colorSwatch.SetVertexColor;

		checkBox.ColorButton.texture = checkBox.ColorButton:CreateTexture(nil, "BACKGROUND");
		checkBox.ColorButton.texture:SetWidth(16);
		checkBox.ColorButton.texture:SetHeight(16);
		checkBox.ColorButton.texture:SetTexture(1, 1, 1);
		checkBox.ColorButton.texture:SetPoint("CENTER", checkBox.ColorButton.colorSwatch);
		checkBox.ColorButton.texture:Show();

		checkBox.ColorButton.checkers = checkBox.ColorButton:CreateTexture(nil, "BACKGROUND");
		checkBox.ColorButton.checkers:SetWidth(14);
		checkBox.ColorButton.checkers:SetHeight(14);
		checkBox.ColorButton.checkers:SetTexture("Tileset\\Generic\\Checkers");
		checkBox.ColorButton.checkers:SetTexCoord(.25, 0, 0.5, .25);
		checkBox.ColorButton.checkers:SetDesaturated(true);
		checkBox.ColorButton.checkers:SetVertexColor(1, 1, 1, 0.75);
		checkBox.ColorButton.checkers:SetPoint("CENTER", checkBox.ColorButton.colorSwatch);
		checkBox.ColorButton.checkers:Show();
		
		checkBox:HookScript("OnShow", function(self) self.ColorButton:Show(); end);
		checkBox:HookScript("OnHide", function(self) self.ColorButton:Hide(); end);
		
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
		scrollFramesTipText:SetPoint("CENTER", GUIFrame, "LEFT", 300, 130);
		scrollFramesTipText:SetText(L["Click on icon to enable/disable tracking"]);
		
		GUIFrame.Categories = {};
		GUIFrame.SpellIcons = {};
		
		for index, value in pairs({L["General"], L["Profiles"], L["WARRIOR"], L["DRUID"], L["PRIEST"], L["MAGE"], L["MONK"], L["HUNTER"], L["PALADIN"], L["ROGUE"], L["DEATHKNIGHT"], L["WARLOCK"], L["SHAMAN"], L["DEMONHUNTER"], L["MISC"]}) do
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
		buttonSwitchTestMode:SetPoint("TOPLEFT", GUIFrame, "TOPLEFT", 130, -20);
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
		
		local sliderIconSize = GUICreateSlider(GUIFrame, 130, -70, 340, "NC_GUIGeneralSliderIconSize");
		sliderIconSize.label:SetText(L["Icon size"]);
		sliderIconSize.slider:SetValueStep(1);
		sliderIconSize.slider:SetMinMaxValues(1, 50);
		sliderIconSize.slider:SetValue(db.IconSize);
		sliderIconSize.slider:SetScript("OnValueChanged", function(self, value)
			sliderIconSize.editbox:SetText(tostring(math_ceil(value)));
			db.IconSize = math_ceil(value);
			ReallocateAllIcons(false);
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
		
		local sliderIconXOffset = GUICreateSlider(GUIFrame, 130, -125, 155, "NC_GUIGeneralSliderIconXOffset");
		sliderIconXOffset.label:SetText(L["Icon X-coord offset"]);
		sliderIconXOffset.slider:SetValueStep(1);
		sliderIconXOffset.slider:SetMinMaxValues(-200, 200);
		sliderIconXOffset.slider:SetValue(db.IconXOffset);
		sliderIconXOffset.slider:SetScript("OnValueChanged", function(self, value)
			sliderIconXOffset.editbox:SetText(tostring(math_ceil(value)));
			db.IconXOffset = math_ceil(value);
			ReallocateAllIcons(false);
		end);
		sliderIconXOffset.editbox:SetText(tostring(db.IconXOffset));
		sliderIconXOffset.editbox:SetScript("OnEnterPressed", function(self, value)
			if (sliderIconXOffset.editbox:GetText() ~= "") then
				local v = tonumber(sliderIconXOffset.editbox:GetText());
				if (v == nil) then
					sliderIconXOffset.editbox:SetText(tostring(db.IconXOffset));
					Print(L["Value must be a number"]);
				else
					if (v > 200) then
						v = 200;
					end
					if (v < -200) then
						v = -200;
					end
					sliderIconXOffset.slider:SetValue(v);
				end
				sliderIconXOffset.editbox:ClearFocus();
			end
		end);
		sliderIconXOffset.lowtext:SetText("-200");
		sliderIconXOffset.hightext:SetText("200");
		table.insert(GUIFrame.Categories[index], sliderIconXOffset);
		
		local sliderIconYOffset = GUICreateSlider(GUIFrame, 315, -125, 155, "NC_GUIGeneralSliderIconYOffset");
		sliderIconYOffset.label:SetText(L["Icon Y-coord offset"]);
		sliderIconYOffset.slider:SetValueStep(1);
		sliderIconYOffset.slider:SetMinMaxValues(-200, 200);
		sliderIconYOffset.slider:SetValue(db.IconYOffset);
		sliderIconYOffset.slider:SetScript("OnValueChanged", function(self, value)
			sliderIconYOffset.editbox:SetText(tostring(math_ceil(value)));
			db.IconYOffset = math_ceil(value);
			ReallocateAllIcons(false);
		end);
		sliderIconYOffset.editbox:SetText(tostring(db.IconYOffset));
		sliderIconYOffset.editbox:SetScript("OnEnterPressed", function(self, value)
			if (sliderIconYOffset.editbox:GetText() ~= "") then
				local v = tonumber(sliderIconYOffset.editbox:GetText());
				if (v == nil) then
					sliderIconYOffset.editbox:SetText(tostring(db.IconYOffset));
					Print(L["Value must be a number"]);
				else
					if (v > 200) then
						v = 200;
					end
					if (v < -200) then
						v = -200;
					end
					sliderIconYOffset.slider:SetValue(v);
				end
				sliderIconYOffset.editbox:ClearFocus();
			end
		end);
		sliderIconYOffset.lowtext:SetText("-200");
		sliderIconYOffset.hightext:SetText("200");
		table.insert(GUIFrame.Categories[index], sliderIconYOffset);
		
		local checkBoxFullOpacityAlways = GUICreateCheckBox(130, -195, L["Always display CD icons at full opacity (ReloadUI is needed)"], function(this)
			db.FullOpacityAlways = this:GetChecked();
		end, "NC_GUI_General_CheckBoxFullOpacityAlways");
		checkBoxFullOpacityAlways:SetChecked(db.FullOpacityAlways);
		table.insert(GUIFrame.Categories[index], checkBoxFullOpacityAlways);
		
		local checkBoxBorderTrinkets = GUICreateCheckBoxWithColorPicker("NC_GUI_General_CheckBoxBorderTrinkets", 130, -225, L["Show border around trinkets"], function(this)
			db.ShowBorderTrinkets = this:GetChecked();
			ReallocateAllIcons(true);
		end);
		checkBoxBorderTrinkets:SetChecked(db.ShowBorderTrinkets);
		checkBoxBorderTrinkets.ColorButton.colorSwatch:SetVertexColor(unpack(db.BorderTrinketsColor));
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
				checkBoxBorderTrinkets.ColorButton.colorSwatch:SetVertexColor(unpack(db.BorderTrinketsColor));
				ReallocateAllIcons(true);
			end
			ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc = callback, callback, callback;
			ColorPickerFrame:SetColorRGB(unpack(db.BorderTrinketsColor));
			ColorPickerFrame.hasOpacity = false;
			ColorPickerFrame.previousValues = { unpack(db.BorderTrinketsColor) };
			ColorPickerFrame:Show();
		end);
		table.insert(GUIFrame.Categories[index], checkBoxBorderTrinkets);
		
		local checkBoxBorderInterrupts = GUICreateCheckBoxWithColorPicker("NC_GUI_General_CheckBoxBorderInterrupts", 130, -245, L["Show border around interrupts"], function(this)
			db.ShowBorderInterrupts = this:GetChecked();
			ReallocateAllIcons(true);
		end);
		checkBoxBorderInterrupts:SetChecked(db.ShowBorderInterrupts);
		checkBoxBorderInterrupts.ColorButton.colorSwatch:SetVertexColor(unpack(db.BorderInterruptsColor));
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
				checkBoxBorderInterrupts.ColorButton.colorSwatch:SetVertexColor(unpack(db.BorderInterruptsColor));
				ReallocateAllIcons(true);
			end
			ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc = callback, callback, callback;
			ColorPickerFrame:SetColorRGB(unpack(db.BorderInterruptsColor));
			ColorPickerFrame.hasOpacity = false;
			ColorPickerFrame.previousValues = { unpack(db.BorderInterruptsColor) };
			ColorPickerFrame:Show();
		end);
		table.insert(GUIFrame.Categories[index], checkBoxBorderInterrupts);
		
		local dropdownIconSortMode = CreateFrame("Frame", "NC.GUI.General.DropdownIconSortMode", GUIFrame, "UIDropDownMenuTemplate");
		UIDropDownMenu_SetWidth(dropdownIconSortMode, 300);
		dropdownIconSortMode:SetPoint("TOPLEFT", GUIFrame, "TOPLEFT", 116, -275);
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
		dropdownIconSortMode.text:SetText("Sort mode:"); -- // todo:localize
		table.insert(GUIFrame.Categories[index], dropdownIconSortMode);
		
		local dropdownFont = CreateFrame("Frame", "NC_GUI_General_DropdownFont", GUIFrame, "UIDropDownMenuTemplate");
		UIDropDownMenu_SetWidth(dropdownFont, 300);
		dropdownFont:SetPoint("TOPLEFT", GUIFrame, "TOPLEFT", 116, -310);
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
	end
	
	function GUICategory_2(index, value)
		local textProfilesCurrentProfile = GUIFrame:CreateFontString("NC_GUIProfilesTextCurrentProfile", "OVERLAY", "GameFontNormal");
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
		
		
		-- /////////////////////////
		
		-- local editboxNewProfile = CreateFrame("EditBox", "NC_GUIProfilesEditboxNewProfile", GUIFrame)
		-- editboxNewProfile:SetAutoFocus(false);
		-- editboxNewProfile:SetFont("Fonts\\FRIZQT__.TTF", 12, nil);
		-- editboxNewProfile:SetPoint("TOPLEFT", GUIFrame, "TOPLEFT", 135, -162);
		-- editboxNewProfile:SetHeight(24);
		-- editboxNewProfile:SetWidth(230);
		-- editboxNewProfile:SetJustifyH("LEFT");
		-- editboxNewProfile:EnableMouse(true);
		-- editboxNewProfile:SetBackdrop({
			-- bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
			-- edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
			-- tile = true, edgeSize = 1, tileSize = 5,
		-- });
		-- editboxNewProfile:SetBackdropColor(0, 0, 0, 0.5)
		-- editboxNewProfile:SetBackdropBorderColor(0.3, 0.3, 0.30, 0.80)
		-- editboxNewProfile:SetScript("OnEscapePressed", function() editboxNewProfile:ClearFocus(); end);
		-- table.insert(GUIFrame.Categories[index], editboxNewProfile);
		
		-- local buttonNewProfile = GUICreateButton("NC_GUIProfilesButtonNewProfile", GUIFrame, "Add"); -- // todo: localize
		-- buttonNewProfile:SetWidth(90);
		-- buttonNewProfile:SetHeight(24);
		-- buttonNewProfile:SetPoint("TOPLEFT", GUIFrame, "TOPLEFT", 380, -162);
		-- buttonNewProfile:SetScript("OnClick", function(self, ...)
			
		-- end);
		-- table.insert(GUIFrame.Categories[index], buttonNewProfile);
		
		-- /////////////////////////
		
		
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
		local bRed, bGreen, bBlue = GUIFrame:GetBackdropColor();
		scrollAreaBackground:SetBackdropColor(bRed, bGreen, bBlue, 0.8)
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
			
			spellItem.Text = spellItem:CreateFontString(nil, "OVERLAY", "GameFontNormal");
			spellItem.Text:SetPoint("LEFT", 22, 0);
			spellItem.Text:SetText(n);
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
					CDEnabledCache[spellID] = nil;
					self.tex:SetAlpha(0.3);
				else
					db.CDsTable[spellID] = true;
					CDEnabledCache[spellID] = true;
					self.tex:SetAlpha(1.0);
				end
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
		button.Background:SetColorTexture(0, 0, 0, 1);

		button.Border = button:CreateTexture(nil, "BACKGROUND");
		button.Border:SetPoint("TOPLEFT", 0, 0);
		button.Border:SetPoint("BOTTOMRIGHT", 0, 0);
		button.Border:SetColorTexture(unpack({0.73, 0.26, 0.21, 1}));

		button.Normal = button:CreateTexture(nil, "ARTWORK");
		button.Normal:SetPoint("TOPLEFT", 2, -2);
		button.Normal:SetPoint("BOTTOMRIGHT", -2, 2);
		button.Normal:SetColorTexture(unpack({0.38, 0, 0, 1}));
		button:SetNormalTexture(button.Normal);

		button.Disabled = button:CreateTexture(nil, "OVERLAY");
		button.Disabled:SetPoint("TOPLEFT", 3, -3);
		button.Disabled:SetPoint("BOTTOMRIGHT", -3, 3);
		button.Disabled:SetColorTexture(0.6, 0.6, 0.6, 0.2);
		button:SetDisabledTexture(button.Disabled);

		button.Highlight = button:CreateTexture(nil, "OVERLAY");
		button.Highlight:SetPoint("TOPLEFT", 3, -3);
		button.Highlight:SetPoint("BOTTOMRIGHT", -3, 3);
		button.Highlight:SetColorTexture(0.6, 0.6, 0.6, 0.2);
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
	
	function table_contains_key(t, key)
		for index in pairs(t) do
			if (index == key) then
				return true;
			end
		end
		return false;
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
	elseif (event == "PLAYER_ENTERING_WORLD") then
		PLAYER_ENTERING_WORLD();
	elseif (event == "NAME_PLATE_UNIT_ADDED") then
		NAME_PLATE_UNIT_ADDED(...);
	elseif (event == "NAME_PLATE_UNIT_REMOVED") then
		NAME_PLATE_UNIT_REMOVED(...);
	end
end);

-------------------------------------------------------------------------------------------------
----- Frame for fun
-------------------------------------------------------------------------------------------------
local funFrame = CreateFrame("Frame");
funFrame:RegisterEvent("CHAT_MSG_ADDON");
funFrame:SetScript("OnEvent", function(self, event, ...)
	local prefix, message, _, sender = ...;
	if (prefix == "NC_prefix") then
		if (string_find(message, "reporting")) then
			local _, toWhom = strsplit(":", message, 2);
			local myName = UnitName("player").."-"..string_gsub(GetRealmName(), " ", "");
			if (toWhom == myName and sender ~= myName) then
				Print(sender.." is using NC");
			end
		elseif (string_find(message, "requesting")) then
			SendAddonMessage("NC_prefix", "reporting:"..sender, IsInGroup(2) and "INSTANCE_CHAT" or "RAID");
		end
	end
end);
RegisterAddonMessagePrefix("NC_prefix");
