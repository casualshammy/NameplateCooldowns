-- luacheck: no max line length
-- luacheck: globals LibStub

local L = LibStub("AceLocale-3.0"):NewLocale("NameplateCooldowns", "zhCN");
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
L["chat:addon-is-disabled"] = "插件已停用"
L["chat:addon-is-disabled-note"] = "请注意: 这个插件已被停用，你可以在设置页面 (/nc) 中启用。"
L["chat:addon-is-enabled"] = "插件已启用"
L["chat:default-spell-is-added-to-ignore-list"] = "预设法术已加入忽略列表: %s，将不会显示这个法术的冷却时间。"
L["chat:enable-only-for-target-nameplate"] = "只在当前目标的血条上显示技能冷却"
L["chat:print-updated-spells"] = "%s: 你的冷却: %s 秒，新的冷却: %s 秒"
L["Click on icon to enable/disable tracking"] = "点击图标启用/禁用跟踪"
L["Copy"] = "复制"
L["Copy other profile to current profile:"] = "复制其他配置文件至当前配置文件："
L["Current profile: [%s]"] = "当前配置文件：[%s]"
L["Data from '%s' has been successfully copied to '%s'"] = "从 '%s' 的数据已被成功复制到 '%s'"
L["Delete"] = "删除"
L["Delete profile:"] = "删除配置文件"
L["Disable test mode"] = "关闭测试模式"
L["Enable test mode (need at least one visible nameplate)"] = "启用测试模式（至少需要一个可见的姓名板）"
L["Filters"] = "过滤器"
L["filters.instance-types"] = "设置在不同地域下是否显示冷却"
L["Font:"] = "字体："
L["General"] = "综合"
L["general.sort-mode"] = "排序方式:"
L["Icon size"] = "图标大小"
L["Icon X-coord offset"] = "图标的X坐标偏移"
L["Icon Y-coord offset"] = "图标的Y坐标偏移"
--[[Translation missing --]]
L["icon-grow-direction:down"] = "Down"
--[[Translation missing --]]
L["icon-grow-direction:left"] = "Left"
--[[Translation missing --]]
L["icon-grow-direction:right"] = "Right"
--[[Translation missing --]]
L["icon-grow-direction:up"] = "Up"
L["instance-type:arena"] = "竞技场"
L["instance-type:none"] = "野外"
L["instance-type:party"] = "5人地下城"
L["instance-type:pvp"] = "战场"
L["instance-type:raid"] = "团队副本"
L["instance-type:scenario"] = "场景战役"
L["instance-type:unknown"] = "未知地域(某些任务场景)"
L["MISC"] = "杂项"
L["msg:question:import-existing-spells"] = [=[NameplateCooldowns
你的某些法术冷却已更新，是否要应用更新?]=]
L["New spell has been added: %s"] = "新的法术已添加：%s"
L["Options are not available in combat!"] = "选项在战斗中不可用！"
--[[Translation missing --]]
L["options:borders:show-blizz-borders"] = "Show Blizzard's borders around icons"
--[[Translation missing --]]
L["options:category:borders"] = "Borders"
L["options:category:spells"] = "法术"
--[[Translation missing --]]
L["options:category:text"] = "Text"
--[[Translation missing --]]
L["options:general:anchor-point"] = "Anchor point"
--[[Translation missing --]]
L["options:general:anchor-point-to-parent"] = "Anchor point (to parent)"
L["options:general:disable-addon-btn"] = "禁用插件"
L["options:general:enable-addon-btn"] = "启用插件"
L["options:general:enable-only-for-target-nameplate"] = "只在当前目标的姓名板上显示技能冷却"
--[[Translation missing --]]
L["options:general:full-opacity-always"] = "Icons are always completely opaque"
--[[Translation missing --]]
L["options:general:full-opacity-always:tooltip"] = [=[If this option is enabled, the icons will 
always be completely opaque. If not, the opacity
will be the same as the health bar]=]
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
L["options:general:space-between-icons"] = "图标间距(px)"
L["options:profiles:open-profiles-dialog"] = "打开配置文件窗口"
L["options:spells:add-new-spell"] = "添加新的法术 (名称或ID):"
L["options:spells:add-spell"] = "添加法术"
L["options:spells:click-to-select-spell"] = "点击以选择法术"
L["options:spells:cooldown-time"] = "冷却时间"
L["options:spells:delete-all-spells"] = "删除所有法术"
L["options:spells:delete-all-spells-confirmation"] = "确定要删除所有法术?"
L["options:spells:delete-spell"] = "删除法术"
--[[Translation missing --]]
L["options:spells:disable-all-spells"] = "Disable all spells"
--[[Translation missing --]]
L["options:spells:enable-all-spells"] = "Enable all spells"
L["options:spells:enable-tracking-of-this-spell"] = "开始追踪这个法术"
L["options:spells:icon-glow"] = "高亮图标已被禁用"
L["options:spells:icon-glow-always"] = "图标高亮，当法术冷却中"
L["options:spells:icon-glow-threshold"] = "图标高亮，当剩余时间小于"
--[[Translation missing --]]
L["options:spells:please-push-once-more"] = "Please push once more"
L["options:spells:track-only-this-spellid"] = [=[只追踪这些法术ID
(使用逗号分隔)]=]
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
L["Profile '%s' has been successfully deleted"] = "配置文件 '%s' 已成功删除"
L["Profiles"] = "配置文件"
L["Show border around interrupts"] = "为打断技能显示边框"
L["Show border around trinkets"] = "为饰品显示边框"
L["Unknown spell: %s"] = "未知的法术：%s"
L["Value must be a number"] = "值必须是数字"
