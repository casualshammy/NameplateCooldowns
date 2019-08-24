--[===[@non-debug@

local locales = {
	["enUS"] = 
	@localization(locale="enUS", format="lua_table", handle-unlocalized="english")@,
	["deDE"] = 
	@localization(locale="deDE", format="lua_table", handle-unlocalized="english")@,
	["esES"] = 
	@localization(locale="esES", format="lua_table", handle-unlocalized="english")@,
	["esMX"] = 
	@localization(locale="esMX", format="lua_table", handle-unlocalized="english")@,
	["frFR"] = 
	@localization(locale="frFR", format="lua_table", handle-unlocalized="english")@,
	["itIT"] = 
	@localization(locale="itIT", format="lua_table", handle-unlocalized="english")@,
	["koKR"] = 
	@localization(locale="koKR", format="lua_table", handle-unlocalized="english")@,
	["ptBR"] = 
	@localization(locale="ptBR", format="lua_table", handle-unlocalized="english")@,
	["ruRU"] = 
	@localization(locale="ruRU", format="lua_table", handle-unlocalized="english")@,
	["zhCN"] = 
	@localization(locale="zhCN", format="lua_table", handle-unlocalized="english")@,
	["zhTW"] = 
	@localization(locale="zhTW", format="lua_table", handle-unlocalized="english")@,
};

--@end-non-debug@]===]

--@debug@
local locales = {
	["enUS"] = 
	{
		["Always display CD icons at full opacity (ReloadUI is needed)"] = "Always display CD icons at full opacity (ReloadUI is needed)",
		["chat:addon-is-disabled"] = "Addon is disabled",
		["chat:addon-is-disabled-note"] = "Please note: this addon is disabled. You can enable it in options dialog (/nc)",
		["chat:addon-is-enabled"] = "Addon is enabled",
		["chat:default-spell-is-added-to-ignore-list"] = "Default spell is added to ignore list: %s. You will not receive cooldown time updates for this spell.",
		["chat:enable-only-for-target-nameplate"] = "Cooldowns will be shown on target nameplate only",
		["chat:print-updated-spells"] = "%s: your cooldown: %s sec, new cooldown: %s sec",
		["Click on icon to enable/disable tracking"] = "Click on icon to enable/disable tracking",
		["Copy"] = "Copy",
		["Copy other profile to current profile:"] = "Copy other profile to current profile:",
		["Current profile: [%s]"] = "Current profile: [%s]",
		["Data from '%s' has been successfully copied to '%s'"] = "Data from '%s' has been successfully copied to '%s'",
		["Delete"] = "Delete",
		["Delete profile:"] = "Delete profile:",
		["Disable test mode"] = "Disable test mode",
		["Enable test mode (need at least one visible nameplate)"] = "Enable test mode (need at least one visible nameplate)",
		["Filters"] = "Filters",
		["filters.instance-types"] = [=[Set the visibility of the cooldowns
	in different types of locations]=],
		["Font:"] = "Font:",
		["General"] = "General",
		["general.sort-mode"] = "Sort mode:",
		["Icon size"] = "Icon size",
		["Icon X-coord offset"] = "Icon X-coord offset",
		["Icon Y-coord offset"] = "Icon Y-coord offset",
		["instance-type:arena"] = "Arenas",
		["instance-type:none"] = "Open World",
		["instance-type:party"] = "5ppl dungeons",
		["instance-type:pvp"] = "Battlegrounds",
		["instance-type:raid"] = "Raid dungeons",
		["instance-type:scenario"] = "Scenarios",
		["instance-type:unknown"] = "Unknown dungeons (some quest scenarios)",
		["MISC"] = "Misc",
		["msg:question:import-existing-spells"] = [=[NameplateCooldowns
	There are updated cooldowns for some of your spells. Do you want to apply update?]=],
		["New spell has been added: %s"] = "New spell has been added: %s",
		["Options are not available in combat!"] = "Options are not available in combat!",
		["options:category:spells"] = "Spells",
		["options:general:disable-addon-btn"] = "Disable addon",
		["options:general:enable-addon-btn"] = "Enable addon",
		["options:general:enable-only-for-target-nameplate"] = "Show the cooldowns on the current target nameplate only",
		["options:general:space-between-icons"] = "Space between icons (px)",
		["options:profiles:open-profiles-dialog"] = "Open profiles dialog",
		["options:spells:add-new-spell"] = "Add new spell (name or id):",
		["options:spells:add-spell"] = "Add spell",
		["options:spells:click-to-select-spell"] = "Click to select spell",
		["options:spells:cooldown-time"] = "Cooldown time",
		["options:spells:delete-all-spells"] = "Delete all spells",
		["options:spells:delete-all-spells-confirmation"] = "Do you really want to delete ALL spells?",
		["options:spells:delete-spell"] = "Delete spell",
		["options:spells:disable-all-spells"] = "Disable all spells",
		["options:spells:enable-all-spells"] = "Enable all spells",
		["options:spells:enable-tracking-of-this-spell"] = "Enable tracking of this spell",
		["options:spells:icon-glow"] = "Icon glow is disabled",
		["options:spells:icon-glow-always"] = "Icon will glow if spell is on cooldown",
		["options:spells:icon-glow-threshold"] = "Icon will glow if remaining time is less than",
		["options:spells:please-push-once-more"] = "Please push once more",
		["options:spells:track-only-this-spellid"] = [=[Track only these spell IDs
	(comma-separated)]=],
		["Profile '%s' has been successfully deleted"] = "Profile '%s' has been successfully deleted",
		["Profiles"] = "Profiles",
		["Show border around interrupts"] = "Show border around interrupts",
		["Show border around trinkets"] = "Show border around trinkets",
		["Unknown spell: %s"] = "Unknown spell: %s",
		["Value must be a number"] = "Value must be a number"
	},
	["ruRU"] = 
{
	["Always display CD icons at full opacity (ReloadUI is needed)"] = [=[Иконки заклинаний всегда полностью непрозрачны
(Необходима перезагрузка интерфейса)]=],
	["chat:addon-is-disabled"] = "Аддон отключен",
	["chat:addon-is-disabled-note"] = "Обратите внимание: этот аддон отключен. Вы можете включить его командой (/nc)",
	["chat:addon-is-enabled"] = "Аддон включен",
	["chat:default-spell-is-added-to-ignore-list"] = "Заклинание добавлено в игнор-лист: %s. Вы не будете получать обновления кулдаунов для этого заклинания от разработчика.",
	["chat:enable-only-for-target-nameplate"] = "КД будут показаны только на нэймплэйте цели",
	["chat:print-updated-spells"] = "%s: прошлое значение: %s сек., новое значение: %s сек.",
	["Click on icon to enable/disable tracking"] = "Нажмите на иконку чтобы вкл/выкл отслеживание",
	["Copy"] = "Скопировать",
	["Copy other profile to current profile:"] = "Скопировать другой профиль в текущий:",
	["Current profile: [%s]"] = "Текущий профиль: [%s]",
	["Data from '%s' has been successfully copied to '%s'"] = "Профиль '%s' успешно скопирован в профиль '%s'",
	["Delete"] = "Удалить",
	["Delete profile:"] = "Удалить профиль:",
	["Disable test mode"] = "Выключить тест",
	["Enable test mode (need at least one visible nameplate)"] = "Включить тест (нужен хотя бы 1 видимый хп бар)",
	["Filters"] = "Фильтры",
	["filters.instance-types"] = [=[Настроить видимость кулдаунов
в различных типах локаций]=],
	["Font:"] = "Шрифт:",
	["General"] = "Общее",
	["general.sort-mode"] = "Режим сортировки:",
	["Icon size"] = "Размер иконок",
	["Icon X-coord offset"] = "Смещение иконок по X",
	["Icon Y-coord offset"] = "Смещение иконок по Y",
	["instance-type:arena"] = "Арена",
	["instance-type:none"] = "Открытый мир",
	["instance-type:party"] = "Подземелья на 5 человек",
	["instance-type:pvp"] = "Поля битв",
	["instance-type:raid"] = "Рейдовые подземелья",
	["instance-type:scenario"] = "Сценарии",
	["instance-type:unknown"] = "Неизвестные типы подземелий",
	["MISC"] = "Другое",
	["msg:question:import-existing-spells"] = [=[NameplateCooldowns
Доступны обновленные значения кулдаунов для некоторых ваших заклинаний. Хотите применить обновление?]=],
	["New spell has been added: %s"] = "Добавлено новое заклинание: %s",
	["Options are not available in combat!"] = "Настройки недоступны, пока идет бой!",
	["options:category:spells"] = "Заклинания",
	["options:general:disable-addon-btn"] = "Отключить аддон",
	["options:general:enable-addon-btn"] = "Включить аддон",
	["options:general:enable-only-for-target-nameplate"] = "Показывать КД только на нэймплэйте цели",
	["options:general:space-between-icons"] = "Расстояние между иконками (пикс.)",
	["options:profiles:open-profiles-dialog"] = "Открыть окно профилей",
	["options:spells:add-new-spell"] = "Добавить заклинание (название или id):",
	["options:spells:add-spell"] = "Добавить",
	["options:spells:click-to-select-spell"] = "Нажмите, чтобы выбрать заклинание",
	["options:spells:cooldown-time"] = "Значение кулдауна",
	["options:spells:delete-all-spells"] = "Удалить все заклинания",
	["options:spells:delete-all-spells-confirmation"] = "Вы действительно хотите удалить ВСЕ заклинания?",
	["options:spells:delete-spell"] = "Удалить заклинание",
	["options:spells:enable-tracking-of-this-spell"] = "Включить отслеживание этого заклинания",
	["options:spells:icon-glow"] = "Подсветка иконки выключена",
	["options:spells:icon-glow-always"] = "Подсветка иконки включена постоянно",
	["options:spells:icon-glow-threshold"] = [=[Иконка будет подсвечиваться если оставшееся
время кулдауна меньше чем]=],
	["options:spells:track-only-this-spellid"] = [=[Отслеживать только эти id заклинания
(разделять запятыми)]=],
	["Profile '%s' has been successfully deleted"] = "Профиль '%s' успешно удален",
	["Profiles"] = "Профили",
	["Show border around interrupts"] = "Показывать контур вокруг прерываний",
	["Show border around trinkets"] = "Показывать контур вокруг тринкетов",
	["Unknown spell: %s"] = "Неизвестное заклинание: %s",
	["Value must be a number"] = "Значение должно быть числом"
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