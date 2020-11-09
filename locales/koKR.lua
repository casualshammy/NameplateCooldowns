-- luacheck: no max line length
-- luacheck: globals LibStub

local L = LibStub("AceLocale-3.0"):NewLocale("NameplateCooldowns", "koKR");
L = L or {}
--[[Translation missing --]]
L["anchor-point:bottom"] = "Bottom"
--[[Translation missing --]]
L["anchor-point:bottomleft"] = "Bottom left"
--[[Translation missing --]]
L["anchor-point:bottomright"] = "Bottom right"
--[[Translation missing --]]
L["anchor-point:center"] = "Center"
--[[Translation missing --]]
L["anchor-point:left"] = "Left"
--[[Translation missing --]]
L["anchor-point:right"] = "Right"
--[[Translation missing --]]
L["anchor-point:top"] = "Top"
--[[Translation missing --]]
L["anchor-point:topleft"] = "Top left"
--[[Translation missing --]]
L["anchor-point:topright"] = "Top right"
--[[Translation missing --]]
L["anchor-point:x-offset"] = "X offset"
--[[Translation missing --]]
L["anchor-point:y-offset"] = "Y offset"
--[[Translation missing --]]
L["chat:addon-is-disabled"] = "Addon is disabled"
--[[Translation missing --]]
L["chat:addon-is-disabled-note"] = "Please note: this addon is disabled. You can enable it in options dialog (/nc)"
--[[Translation missing --]]
L["chat:addon-is-enabled"] = "Addon is enabled"
--[[Translation missing --]]
L["chat:default-spell-is-added-to-ignore-list"] = "Default spell is added to ignore list: %s. You will not receive cooldown time updates for this spell."
--[[Translation missing --]]
L["chat:enable-only-for-target-nameplate"] = "Cooldowns will be shown on target nameplate only"
--[[Translation missing --]]
L["chat:print-updated-spells"] = "%s: your cooldown: %s sec, new cooldown: %s sec"
L["Click on icon to enable/disable tracking"] = "추적을 활성/비활성화 하려면 아이콘을 클릭하세요"
L["Copy"] = "복사하기"
L["Copy other profile to current profile:"] = "다른 프로필을 현재 프로필에 복사하기:"
L["Current profile: [%s]"] = "현재 프로필: [%s]"
L["Data from '%s' has been successfully copied to '%s'"] = "'%s'의 데이터가 성공적으로 '%s'에 복사되었습니다"
L["Delete"] = "삭제"
L["Delete profile:"] = "프로필 삭제:"
L["Disable test mode"] = "테스트 모드 비활성화"
L["Enable test mode (need at least one visible nameplate)"] = "테스트 모드 활성화 (최소 하나의 볼 수 있는 이름표 필요)"
--[[Translation missing --]]
L["Filters"] = "Filters"
--[[Translation missing --]]
L["filters.instance-types"] = [=[Set the visibility of the cooldowns
in different types of locations]=]
L["Font:"] = "글꼴:"
L["General"] = "일반"
--[[Translation missing --]]
L["general.sort-mode"] = "Sort mode:"
L["Icon size"] = "아이콘 크기"
L["Icon X-coord offset"] = "아이콘 X-좌표 위치"
L["Icon Y-coord offset"] = "아이콘 Y-좌표 위치"
--[[Translation missing --]]
L["icon-grow-direction:down"] = "Down"
--[[Translation missing --]]
L["icon-grow-direction:left"] = "Left"
--[[Translation missing --]]
L["icon-grow-direction:right"] = "Right"
--[[Translation missing --]]
L["icon-grow-direction:up"] = "Up"
--[[Translation missing --]]
L["instance-type:arena"] = "Arenas"
--[[Translation missing --]]
L["instance-type:none"] = "Open World"
--[[Translation missing --]]
L["instance-type:party"] = "5ppl dungeons"
--[[Translation missing --]]
L["instance-type:pvp"] = "Battlegrounds"
--[[Translation missing --]]
L["instance-type:raid"] = "Raid dungeons"
--[[Translation missing --]]
L["instance-type:scenario"] = "Scenarios"
--[[Translation missing --]]
L["instance-type:unknown"] = "Unknown dungeons (some quest scenarios)"
L["MISC"] = "기타"
--[[Translation missing --]]
L["msg:question:import-existing-spells"] = [=[NameplateCooldowns
There are updated cooldowns for some of your spells. Do you want to apply update?]=]
L["New spell has been added: %s"] = "새로운 주문이 추가되었습니다: %s"
L["Options are not available in combat!"] = "전투 중에는 옵션을 사용할 수 없습니다!"
--[[Translation missing --]]
L["options:borders:show-blizz-borders"] = "Show Blizzard's borders around icons"
--[[Translation missing --]]
L["options:category:borders"] = "Borders"
--[[Translation missing --]]
L["options:category:spells"] = "Spells"
--[[Translation missing --]]
L["options:category:text"] = "Text"
--[[Translation missing --]]
L["options:general:anchor-point"] = "Anchor point"
--[[Translation missing --]]
L["options:general:anchor-point-to-parent"] = "Anchor point (to parent)"
--[[Translation missing --]]
L["options:general:disable-addon-btn"] = "Disable addon"
--[[Translation missing --]]
L["options:general:enable-addon-btn"] = "Enable addon"
--[[Translation missing --]]
L["options:general:enable-only-for-target-nameplate"] = "Show the cooldowns on the current target nameplate only"
--[[Translation missing --]]
L["options:general:full-opacity-always"] = "Icons are always completely opaque"
--[[Translation missing --]]
L["options:general:full-opacity-always:tooltip"] = [=[If this option is enabled, the icons will always be completely opaque. If not, the opacity will be the same as the health bar]=]
--[[Translation missing --]]
L["options:general:icon-grow-direction"] = "Icons' growth direction"
--[[Translation missing --]]
L["options:general:ignore-nameplate-scale"] = "Ignore nameplate scale"
--[[Translation missing --]]
L["options:general:ignore-nameplate-scale:tooltip"] = [=[If this option is checked, icon size will not
change accordingly to nameplate scale
(for example, if nameplate of your target becomes bigger)]=]
--[[Translation missing --]]
L["options:general:show-cd-on-allies"] = "Show cooldowns on nameplates of allies"
--[[Translation missing --]]
L["options:general:show-inactive-cd"] = "Show inactive cooldowns"
--[[Translation missing --]]
L["options:general:show-inactive-cd:tooltip"] = [=[Pay attention: you will NOT be able to see all available cooldowns!
You will see ONLY those cooldowns that foe has already used]=]
--[[Translation missing --]]
L["options:general:space-between-icons"] = "Space between icons (px)"
--[[Translation missing --]]
L["options:profiles:open-profiles-dialog"] = "Open profiles dialog"
--[[Translation missing --]]
L["options:spells:add-new-spell"] = "Add new spell (name or id):"
--[[Translation missing --]]
L["options:spells:add-spell"] = "Add spell"
--[[Translation missing --]]
L["options:spells:click-to-select-spell"] = "Click to select spell"
--[[Translation missing --]]
L["options:spells:cooldown-time"] = "Cooldown time"
--[[Translation missing --]]
L["options:spells:delete-all-spells"] = "Delete all spells"
--[[Translation missing --]]
L["options:spells:delete-all-spells-confirmation"] = "Do you really want to delete ALL spells?"
--[[Translation missing --]]
L["options:spells:delete-spell"] = "Delete spell"
--[[Translation missing --]]
L["options:spells:disable-all-spells"] = "Disable all spells"
--[[Translation missing --]]
L["options:spells:enable-all-spells"] = "Enable all spells"
--[[Translation missing --]]
L["options:spells:enable-tracking-of-this-spell"] = "Enable tracking of this spell"
--[[Translation missing --]]
L["options:spells:icon-glow"] = "Icon glow is disabled"
--[[Translation missing --]]
L["options:spells:icon-glow-always"] = "Icon will glow if spell is on cooldown"
--[[Translation missing --]]
L["options:spells:icon-glow-threshold"] = "Icon will glow if remaining time is less than"
--[[Translation missing --]]
L["options:spells:please-push-once-more"] = "Please push once more"
--[[Translation missing --]]
L["options:spells:track-only-this-spellid"] = [=[Track only these spell IDs
(comma-separated)]=]
--[[Translation missing --]]
L["options:text:anchor-point"] = "Anchor point"
--[[Translation missing --]]
L["options:text:anchor-to-icon"] = "Anchor to icon"
--[[Translation missing --]]
L["options:text:color"] = "Text color"
--[[Translation missing --]]
L["options:text:font"] = "Font"
--[[Translation missing --]]
L["options:text:font-scale"] = "Font scale"
--[[Translation missing --]]
L["options:text:font-size"] = "Font size"
--[[Translation missing --]]
L["options:timer-text:scale-font-size"] = [=[Scale font size
according to
icon size]=]
L["Profile '%s' has been successfully deleted"] = "'%s' 프로필이 성공적으로 삭제되었습니다"
L["Profiles"] = "프로필"
L["Show border around interrupts"] = "방해 주위에 테두리 표시"
L["Show border around trinkets"] = "장신구 주위에 테두리 표시"
L["Unknown spell: %s"] = "알 수 없는 주문: %s"
L["Value must be a number"] = "값은 반드시 숫자여야 합니다"
