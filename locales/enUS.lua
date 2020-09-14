local L = LibStub("AceLocale-3.0"):NewLocale("NameplateCooldowns", "enUS", true);
L = L or {}
--[===[@non-debug@
@localization(locale="enUS", format="lua_additive_table", handle-unlocalized="english", table-name="L")@
--@end-non-debug@]===]
--@debug@
L = L or {}
L["options:general:show-cd-on-allies"] = "Show cooldowns on nameplates of allies"
L["chat:addon-is-disabled"] = "Addon is disabled";
L["chat:addon-is-disabled-note"] = "Please note: this addon is disabled. You can enable it in options dialog (/nc)";
L["chat:addon-is-enabled"] = "Addon is enabled";
L["chat:default-spell-is-added-to-ignore-list"] = "Default spell is added to ignore list: %s. You will not receive cooldown time updates for this spell.";
L["chat:enable-only-for-target-nameplate"] = "Cooldowns will be shown on target nameplate only";
L["chat:print-updated-spells"] = "%s: your cooldown: %s sec, new cooldown: %s sec";
L["Click on icon to enable/disable tracking"] = "Click on icon to enable/disable tracking";
L["Copy"] = "Copy";
L["Copy other profile to current profile:"] = "Copy other profile to current profile:";
L["Current profile: [%s]"] = "Current profile: [%s]";
L["Data from '%s' has been successfully copied to '%s'"] = "Data from '%s' has been successfully copied to '%s'";
L["Delete"] = "Delete";
L["Delete profile:"] = "Delete profile:";
L["Disable test mode"] = "Disable test mode";
L["Enable test mode (need at least one visible nameplate)"] = "Enable test mode (need at least one visible nameplate)";
L["Filters"] = "Filters";
L["filters.instance-types"] = [=[Set the visibility of the cooldowns
in different types of locations]=];
L["Font:"] = "Font:";
L["General"] = "General";
L["general.sort-mode"] = "Sort mode:";
L["Icon size"] = "Icon size";
L["Icon X-coord offset"] = "Icon X-coord offset";
L["Icon Y-coord offset"] = "Icon Y-coord offset";
L["instance-type:arena"] = "Arenas";
L["instance-type:none"] = "Open World";
L["instance-type:party"] = "5ppl dungeons";
L["instance-type:pvp"] = "Battlegrounds";
L["instance-type:raid"] = "Raid dungeons";
L["instance-type:scenario"] = "Scenarios";
L["instance-type:unknown"] = "Unknown dungeons (some quest scenarios)";
L["MISC"] = "Misc";
L["msg:question:import-existing-spells"] = [=[NameplateCooldowns
There are updated cooldowns for some of your spells. Do you want to apply update?]=];
L["New spell has been added: %s"] = "New spell has been added: %s";
L["Options are not available in combat!"] = "Options are not available in combat!";
L["options:category:spells"] = "Spells";
L["options:general:disable-addon-btn"] = "Disable addon";
L["options:general:enable-addon-btn"] = "Enable addon";
L["options:general:enable-only-for-target-nameplate"] = "Show the cooldowns on the current target nameplate only";
L["options:general:space-between-icons"] = "Space between icons (px)";
L["options:profiles:open-profiles-dialog"] = "Open profiles dialog";
L["options:spells:add-new-spell"] = "Add new spell (name or id):";
L["options:spells:add-spell"] = "Add spell";
L["options:spells:click-to-select-spell"] = "Click to select spell";
L["options:spells:cooldown-time"] = "Cooldown time";
L["options:spells:delete-all-spells"] = "Delete all spells";
L["options:spells:delete-all-spells-confirmation"] = "Do you really want to delete ALL spells?";
L["options:spells:delete-spell"] = "Delete spell";
L["options:spells:disable-all-spells"] = "Disable all spells";
L["options:spells:enable-all-spells"] = "Enable all spells";
L["options:spells:enable-tracking-of-this-spell"] = "Enable tracking of this spell";
L["options:spells:icon-glow"] = "Icon glow is disabled";
L["options:spells:icon-glow-always"] = "Icon will glow if spell is on cooldown";
L["options:spells:icon-glow-threshold"] = "Icon will glow if remaining time is less than";
L["options:spells:please-push-once-more"] = "Please push once more";
L["options:spells:track-only-this-spellid"] = [=[Track only these spell IDs
(comma-separated)]=];
L["Profile '%s' has been successfully deleted"] = "Profile '%s' has been successfully deleted";
L["Profiles"] = "Profiles";
L["Show border around interrupts"] = "Show border around interrupts";
L["Show border around trinkets"] = "Show border around trinkets";
L["Unknown spell: %s"] = "Unknown spell: %s";
L["Value must be a number"] = "Value must be a number";
L["options:category:borders"] = "Borders";
L["options:borders:show-blizz-borders"] = "Show Blizzard's borders around icons";
L["options:category:text"] = "Text";
L["anchor-point:top"] = "Top";
L["anchor-point:topleft"] = "Top left";
L["anchor-point:topright"] = "Top right";
L["anchor-point:right"] = "Right";
L["anchor-point:left"] = "Left";
L["anchor-point:bottom"] = "Bottom";
L["anchor-point:bottomleft"] = "Bottom left";
L["anchor-point:bottomright"] = "Bottom right";
L["anchor-point:x-offset"] = "X offset";
L["anchor-point:y-offset"] = "Y offset";
L["anchor-point:center"] = "Center";
L["options:text:font"] = "Font";
L["options:text:font-scale"] = "Font scale";
L["options:text:font-size"] = "Font size";
L["options:timer-text:scale-font-size"] = [=[Scale font size
according to
icon size]=];
L["options:text:anchor-point"] = "Anchor point";
L["options:text:anchor-to-icon"] = "Anchor to icon";
L["options:text:color"] = "Text color";
L["options:general:icon-grow-direction"] = "Icons' growth direction";
L["icon-grow-direction:right"] = "Right";
L["icon-grow-direction:left"] = "Left";
L["icon-grow-direction:up"] = "Up";
L["icon-grow-direction:down"] = "Down";
L["options:general:anchor-point"] = "Anchor point";
L["options:general:anchor-point-to-parent"] = "Anchor point (to parent)"
L["options:general:show-inactive-cd"] = "Show inactive cooldowns";
L["options:general:show-inactive-cd:tooltip"] = 
[[Pay attention: you will NOT be able to see all available cooldowns!
You will see ONLY those cooldowns that foe has already used]];
L["options:general:full-opacity-always"] = "Icons are always completely opaque"
L["options:general:full-opacity-always:tooltip"] = 
[[If this option is enabled, the icons will 
always be completely opaque. If not, the opacity
will be the same as the health bar]]
L["options:general:ignore-nameplate-scale"] = "Ignore nameplate scale";
L["options:general:ignore-nameplate-scale:tooltip"] = 
[[If this option is checked, icon size will not
change accordingly to nameplate scale
(for example, if nameplate of your target becomes bigger)]];

--@end-debug@