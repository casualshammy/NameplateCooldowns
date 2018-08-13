--[===[@non-debug@

local locales = {
	["enUS"] = @localization(locale="enUS", format="lua_table", handle-unlocalized="english")@,
	["deDE"] = @localization(locale="deDE", format="lua_table", handle-unlocalized="english")@,
	["esES"] = @localization(locale="esES", format="lua_table", handle-unlocalized="english")@,
	["esMX"] = @localization(locale="esMX", format="lua_table", handle-unlocalized="english")@,
	["frFR"] = @localization(locale="frFR", format="lua_table", handle-unlocalized="english")@,
	["itIT"] = @localization(locale="itIT", format="lua_table", handle-unlocalized="english")@,
	["koKR"] = @localization(locale="koKR", format="lua_table", handle-unlocalized="english")@,
	["ptBR"] = @localization(locale="ptBR", format="lua_table", handle-unlocalized="english")@,
	["ruRU"] = @localization(locale="ruRU", format="lua_table", handle-unlocalized="english")@,
	["zhCN"] = @localization(locale="zhCN", format="lua_table", handle-unlocalized="english")@,
	["zhTW"] = @localization(locale="zhTW", format="lua_table", handle-unlocalized="english")@,
};

--@end-non-debug@]===]

--@debug@
local locales = {
	["enUS"] = {
		["Always display CD icons at full opacity (ReloadUI is needed)"] = "Always display CD icons at full opacity (ReloadUI is needed)",
		["Click on icon to enable/disable tracking"] = "Click on icon to enable/disable tracking",
		Copy = "Copy",
		["Copy other profile to current profile:"] = "Copy other profile to current profile:",
		["Current profile: [%s]"] = "Current profile: [%s]",
		["Data from '%s' has been successfully copied to '%s'"] = "Data from '%s' has been successfully copied to '%s'",
		Delete = "Delete",
		["Delete profile:"] = "Delete profile:",
		["Disable test mode"] = "Disable test mode",
		["Enable test mode (need at least one visible nameplate)"] = "Enable test mode (need at least one visible nameplate)",
		General = "General",
		["Icon size"] = "Icon size",
		["Icon X-coord offset"] = "Icon X-coord offset",
		["Icon Y-coord offset"] = "Icon Y-coord offset",
		MISC = "Misc",
		["New spell has been added: %s"] = "New spell has been added: %s",
		["Options are not available in combat!"] = "Options are not available in combat!",
		Profiles = "Profiles",
		["Profile '%s' has been successfully deleted"] = "Profile '%s' has been successfully deleted",
		["Show border around interrupts"] = "Show border around interrupts",
		["Show border around trinkets"] = "Show border around trinkets",
		["Unknown spell: %s"] = "Unknown spell: %s",
		["Value must be a number"] = "Value must be a number",
		["Font:"] = "Font:",
		["options:general:disable-addon-btn"] = "Disable addon",
		["options:general:enable-addon-btn"] = "Enable addon",
		["chat:addon-is-disabled-note"] = "Please note: this addon is disabled. You can enable it in options dialog (/nc)",
		["chat:addon-is-enabled"] = "Addon is enabled",
		["chat:addon-is-disabled"] = "Addon is disabled",
		["chat:enable-only-for-target-nameplate"] = "Cooldowns will be shown on target nameplate only",
		["options:general:enable-only-for-target-nameplate"] = "Show the cooldowns on the current target nameplate only",
	},
	["ruRU"] = {
		["Always display CD icons at full opacity (ReloadUI is needed)"] = "Иконки заклинаний всегда полностью непрозрачны\r\n(Необходима перезагрузка интерфейса)",
		["Click on icon to enable/disable tracking"] = "Нажмите на иконку чтобы вкл/выкл отслеживание",
		["Copy"] = "Скопировать",
		["Copy other profile to current profile:"] = "Скопировать другой профиль в текущий:",
		["Current profile: [%s]"] = "Текущий профиль: [%s]",
		["Data from '%s' has been successfully copied to '%s'"] = "Профиль '%s' успешно скопирован в профиль '%s'",
		["Delete"] = "Удалить",
		["Delete profile:"] = "Удалить профиль:",
		["Disable test mode"] = "Выключить тест",
		["Enable test mode (need at least one visible nameplate)"] = "Включить тест (нужен хотя бы 1 видимый хп бар)",
		["Font:"] = "Шрифт:",
		["General"] = "Общее",
		["Icon size"] = "Размер иконок",
		["Icon X-coord offset"] = "Смещение иконок по X",
		["Icon Y-coord offset"] = "Смещение иконок по Y",
		["MISC"] = "Другое",
		["New spell has been added: %s"] = "Добавлено новое заклинание: %s",
		["Options are not available in combat!"] = "Настройки недоступны, пока идет бой!",
		["Profile '%s' has been successfully deleted"] = "Профиль '%s' успешно удален",
		["Profiles"] = "Профили",
		["Show border around interrupts"] = "Показывать контур вокруг прерываний",
		["Show border around trinkets"] = "Показывать контур вокруг тринкетов",
		["Unknown spell: %s"] = "Неизвестное заклинание: %s",
		["Value must be a number"] = "Значение должно быть числом",
		["chat:enable-only-for-target-nameplate"] = "КД будут показаны только на нэймплэйте цели",
		["options:general:enable-only-for-target-nameplate"] = "Показывать КД только на нэймплэйте цели",
	},
	["koKR"] = {
		["Always display CD icons at full opacity (ReloadUI is needed)"] = "CD 아이콘을 항상 최대 불투명도로 표시합니다 (UI 다시 불러오기 필요)",
		["Click on icon to enable/disable tracking"] = "추적을 활성/비활성화 하려면 아이콘을 클릭하세요",
		["Copy"] = "복사하기",
		["Copy other profile to current profile:"] = "다른 프로필을 현재 프로필에 복사하기:",
		["Current profile: [%s]"] = "현재 프로필: [%s]",
		["Data from '%s' has been successfully copied to '%s'"] = "'%s'의 데이터가 성공적으로 '%s'에 복사되었습니다",
		["Delete"] = "삭제",
		["Delete profile:"] = "프로필 삭제:",
		["Disable test mode"] = "테스트 모드 비활성화",
		["Enable test mode (need at least one visible nameplate)"] = "테스트 모드 활성화 (최소 하나의 볼 수 있는 이름표 필요)",
		["Font:"] = "글꼴:",
		["General"] = "일반",
		["Icon size"] = "아이콘 크기",
		["Icon X-coord offset"] = "아이콘 X-좌표 위치",
		["Icon Y-coord offset"] = "아이콘 Y-좌표 위치",
		["MISC"] = "기타",
		["New spell has been added: %s"] = "새로운 주문이 추가되었습니다: %s",
		["Options are not available in combat!"] = "전투 중에는 옵션을 사용할 수 없습니다!",
		["Profile '%s' has been successfully deleted"] = "'%s' 프로필이 성공적으로 삭제되었습니다",
		["Profiles"] = "프로필",
		["Show border around interrupts"] = "방해 주위에 테두리 표시",
		["Show border around trinkets"] = "장신구 주위에 테두리 표시",
		["Unknown spell: %s"] = "알 수 없는 주문: %s",
		["Value must be a number"] = "값은 반드시 숫자여야 합니다"
	},
	["zhCN"] = {
		["Always display CD icons at full opacity (ReloadUI is needed)"] = "始终以完全不透明显示在冷却的图标（需要重载界面）",
		["Click on icon to enable/disable tracking"] = "点击图标启用/禁用跟踪",
		["Copy"] = "复制",
		["Copy other profile to current profile:"] = "复制其他配置文件至当前配置文件：",
		["Current profile: [%s]"] = "当前配置文件：[%s]",
		["Data from '%s' has been successfully copied to '%s'"] = "从 '%s' 的数据已被成功复制到 '%s'",
		["Delete"] = "删除",
		["Delete profile:"] = "删除配置文件",
		["Disable test mode"] = "关闭测试模式",
		["Enable test mode (need at least one visible nameplate)"] = "启用测试模式（至少需要一个可见的姓名板）",
		["Font:"] = "字体：",
		["General"] = "综合",
		["Icon size"] = "图标大小",
		["Icon X-coord offset"] = "图标的X坐标偏移",
		["Icon Y-coord offset"] = "图标的Y坐标偏移",
		["MISC"] = "杂项",
		["New spell has been added: %s"] = "新的法术已添加：%s",
		["Options are not available in combat!"] = "选项在战斗中不可用！",
		["Profile '%s' has been successfully deleted"] = "配置文件 '%s' 已成功删除",
		["Profiles"] = "配置文件",
		["Show border around interrupts"] = "为打断技能显示边框",
		["Show border around trinkets"] = "为饰品显示边框",
		["Unknown spell: %s"] = "未知的法术：%s",
		["Value must be a number"] = "值必须是数字"
	},
	["zhTW"] = {
		--Translation missing 
		["Always display CD icons at full opacity (ReloadUI is needed)"] = "Always display CD icons at full opacity (ReloadUI is needed)",
		["Click on icon to enable/disable tracking"] = "点击图标开启/关闭监视",
		["Copy"] = "复制",
		["Copy other profile to current profile:"] = "将一个已保存的配置文件复制到当前配置文件:",
		["Current profile: [%s]"] = "当前配置文件: [%s]",
		["Data from '%s' has been successfully copied to '%s'"] = "已成功复制数据'%s'",
		["Delete"] = "删除",
		["Delete profile:"] = "删除配置文件:",
		["Disable test mode"] = "关闭测试模式",
		["Enable test mode (need at least one visible nameplate)"] = "开启测试模式 （屏幕范围内要有至少一个姓名板）",
		--Translation missing 
		["Font:"] = "Font:",
		["General"] = "通用",
		["Icon size"] = "图标大小",
		["Icon X-coord offset"] = "X偏移量",
		["Icon Y-coord offset"] = "Y偏移量",
		["MISC"] = "种族技能",
		["New spell has been added: %s"] = "已添加新的法术: %s",
		["Options are not available in combat!"] = "不能在战斗状态下进行设置！",
		["Profile '%s' has been successfully deleted"] = "成功删除配置文件 '%s'",
		["Profiles"] = "配置文件",
		--Translation missing 
		["Show border around interrupts"] = "Show border around interrupts",
		--Translation missing 
		["Show border around trinkets"] = "Show border around trinkets",
		["Unknown spell: %s"] = "未知的法术: %s",
		["Value must be a number"] = "必须填写数字"
	},
};
--@end-debug@

-- locales["koKR"] = locales["enUS"];
-- locales["zhCN"] = locales["enUS"];
-- locales["zhTW"] = locales["enUS"];

--			Test
--locales["ruRU"] = locales["zhTW"];

local localizedClasses = {};
FillLocalizedClassList(localizedClasses);
for _, localeTable in pairs(locales) do
	for classToken, localizedClassName in pairs(localizedClasses) do
		localeTable[classToken] = localizedClassName;
	end
end

local _, addonTable = ...;
addonTable.L = locales[GetLocale()];
addonTable.L = setmetatable(addonTable.L, {
	__index = function(t, key)
		local enus = locales["enUS"][key];
		if (enus ~= nil) then
			return enus;
		else
			print("NameplateCooldowns: missing localisation: "..key);
			return key;
		end
	end
});