-- luacheck: no max line length
-- luacheck: globals LibStub

local L = LibStub("AceLocale-3.0"):NewLocale("NameplateCooldowns", "deDE");
L = L or {}
L["anchor-point:bottom"] = "Unten"
L["anchor-point:bottomleft"] = "Unten links"
L["anchor-point:bottomright"] = "Unten rechts"
L["anchor-point:center"] = "Mitte"
L["anchor-point:left"] = "Links"
L["anchor-point:right"] = "Rechts"
L["anchor-point:top"] = "Oben"
L["anchor-point:topleft"] = "Oben links"
L["anchor-point:topright"] = "Oben rechts"
L["anchor-point:x-offset"] = "X-Versatz"
L["anchor-point:y-offset"] = "Y-Versatz"
L["chat:addon-is-disabled"] = "Addon ist deaktiviert"
L["chat:addon-is-disabled-note"] = "Bitte beachte: Dieses Addon ist deaktiviert. Du kannst es in den Optionen aktivieren (/nc) "
L["chat:addon-is-enabled"] = "Addon ist aktiviert"
L["chat:default-spell-is-added-to-ignore-list"] = "Standardzauber wird zur Ignorierliste hinzugefügt: %s. Du wirst keine Aktualisierungen von Abklingzeiten für diesen Zauber erhalten."
L["chat:enable-only-for-target-nameplate"] = "Abklingzeiten werden nur auf der Namensplakette deines Ziels angezeigt"
L["chat:print-updated-spells"] = "%s: Deine Abklingzeit: %s Sek., Neue Abklingzeit: %s Sek."
L["Click on icon to enable/disable tracking"] = "Klicke auf das Symbol, um die Verfolgung ein-/auszuschalten"
L["Copy"] = "Kopieren"
L["Copy other profile to current profile:"] = "Kopiere ein anderes Profil zu dem aktuellen:"
L["Current profile: [%s]"] = "Aktuelles Profil: [%s]"
L["Data from '%s' has been successfully copied to '%s'"] = "Daten von '%s' wurden erfolgreich zu '%s' kopiert."
L["Delete"] = "Löschen"
L["Delete profile:"] = "Profil löschen:"
L["Disable test mode"] = "Testmodus deaktivieren"
L["Enable test mode (need at least one visible nameplate)"] = "Testmodus aktivieren\\r\\n(es muss mindestens eine Namensplakette sichtbar sein)"
L["Filters"] = "Filter"
L["filters.instance-types"] = "Stelle die Sichtbarkeit der Abklingzeiten abhängig von der Art der Instanzen ein."
L["Font:"] = "Schriftart:"
L["General"] = "Allgemein"
L["general.sort-mode"] = "Sortieren nach:"
L["Icon size"] = "Symbolgröße "
L["Icon X-coord offset"] = "X-Position des Symbols"
L["Icon Y-coord offset"] = "Y-Position des Symbols"
L["icon-grow-direction:down"] = "Nach unten"
L["icon-grow-direction:left"] = "Nach links"
L["icon-grow-direction:right"] = "Nach rechts"
L["icon-grow-direction:up"] = "Nach oben"
L["instance-type:arena"] = "Arenen"
L["instance-type:none"] = "Offene Welt"
L["instance-type:party"] = "5-Mann-Dungeons"
L["instance-type:pvp"] = "Schlachtfelder"
L["instance-type:raid"] = "Schlachtzüge"
L["instance-type:scenario"] = "Szenarien"
L["instance-type:unknown"] = "Unbekannte Dungeons (Manche Questszenarien)"
L["MISC"] = "Verschiedenes"
L["msg:question:import-existing-spells"] = [=[NameplateCooldowns
Es gibt aktualisierte Abklingzeiten für manche deiner Zauber. Möchtest du sie aktualisieren?]=]
L["New spell has been added: %s"] = "Ein neuer Zauber wurde hinzugefügt: %s"
L["Options are not available in combat!"] = "Einstellungen sind nicht im Kampf verfügbar"
--[[Translation missing --]]
L["options:borders:show-blizz-borders"] = "Show Blizzard's borders around icons"
L["options:category:borders"] = "Rahmen"
L["options:category:spells"] = "Zauber"
L["options:category:text"] = "Text"
L["options:general:anchor-point"] = "Ankerpunkt"
--[[Translation missing --]]
L["options:general:anchor-point-to-parent"] = "Anchor point (to parent)"
L["options:general:disable-addon-btn"] = "Addon deaktivieren"
L["options:general:enable-addon-btn"] = "Addon aktivieren"
L["options:general:enable-only-for-target-nameplate"] = "Die Abklingzeit nur auf der Namensplakette des aktuellen Ziels anzeigen"
--[[Translation missing --]]
L["options:general:full-opacity-always"] = "Icons are always completely opaque"
--[[Translation missing --]]
L["options:general:full-opacity-always:tooltip"] = [=[If this option is enabled, the icons will 
always be completely opaque. If not, the opacity
will be the same as the health bar]=]
L["options:general:icon-grow-direction"] = "Die Wuchsrichtung der Symbole"
L["options:general:ignore-nameplate-scale"] = "Namensplakettenskalierung ignorieren"
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
L["options:general:space-between-icons"] = "Platz zwischen Symbolen (px)"
L["options:profiles:open-profiles-dialog"] = "Profildialog öffnen"
L["options:spells:add-new-spell"] = "Füge neuen Zauber hinzu (Name oder ID):"
L["options:spells:add-spell"] = "Zauber hinzufügen"
L["options:spells:click-to-select-spell"] = "Klicke, um einen Zauber auszuwählen"
L["options:spells:cooldown-time"] = "Abklingzeit"
L["options:spells:delete-all-spells"] = "Alle Zauber entfernen"
L["options:spells:delete-all-spells-confirmation"] = "Möchtest du wirklich ALLE Zauber entfernen?"
L["options:spells:delete-spell"] = "Zauber löschen"
L["options:spells:disable-all-spells"] = "Alle Zauber deaktivieren"
L["options:spells:enable-all-spells"] = "Alle Zauber aktivieren"
L["options:spells:enable-tracking-of-this-spell"] = "Verfolgung dieses Zaubers aktivieren"
L["options:spells:icon-glow"] = "Symbolleuchten ist deaktiviert"
L["options:spells:icon-glow-always"] = "Symbol wird leuchten, falls der Zauber abklingt"
L["options:spells:icon-glow-threshold"] = "Symbol wird leuchten, falls die verbleibende Zeit weniger ist als"
L["options:spells:please-push-once-more"] = "Bitte drücke noch einmal"
L["options:spells:track-only-this-spellid"] = [=[Nur diese Zauber-IDs verfolgen
(kommasepariert)]=]
L["options:text:anchor-point"] = "Ankerpunkt"
--[[Translation missing --]]
L["options:text:anchor-to-icon"] = "Anchor to icon"
L["options:text:color"] = "Schriftfarbe"
L["options:text:font"] = "Schriftart"
L["options:text:font-scale"] = "Schriftskalierung"
L["options:text:font-size"] = "Schriftgröße"
--[[Translation missing --]]
L["options:timer-text:scale-font-size"] = [=[Scale font size
according to
icon size]=]
L["Profile '%s' has been successfully deleted"] = "Profil '%s' wurde erfolgreich gelöscht."
L["Profiles"] = "Profile"
L["Show border around interrupts"] = "Rahmen um Unterbrechungen anzeigen"
L["Show border around trinkets"] = "Rahmen um Schmuckstücke anzeigen"
L["Unknown spell: %s"] = "Unbekannter Zauber: %s"
L["Value must be a number"] = "Der Wert muss eine Zahl sein."

