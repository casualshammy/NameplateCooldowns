-- luacheck: no max line length
-- luacheck: globals wipe

local _, addonTable = ...;

local next, SpellNameByID, math_ceil = next, addonTable.SpellNameByID, math.ceil;

local function GetDefaultDBEntryForSpell()
    return {
        ["enabled"] = true,
        ["cooldown"] = 60,
        ["glow"] = nil,
        ["spellIDs"] = nil,
    };
end

local migrations = {
    [0] = function()
        local db = addonTable.db;
        if (db.CDsTable ~= nil and next(db.CDsTable)) then
			for spellID, enabled in pairs(db.CDsTable) do
                local spellName = SpellNameByID[spellID];
                local cooldown;
                for _, spellsTable in pairs(addonTable.CDs) do
                    for defaultSpellID, defaultCd in pairs(spellsTable) do
                        if (spellID == defaultSpellID) then
                            cooldown = defaultCd;
                        end
                    end
                end
				if (db.SpellCDs[spellName] == nil and cooldown ~= nil) then
					db.SpellCDs[spellName] = GetDefaultDBEntryForSpell();
					db.SpellCDs[spellName].enabled = enabled;
					db.SpellCDs[spellName].cooldown = cooldown;
					db.SpellCDs[spellName].spellIDs = { [spellID] = true; };
				end
			end
			db.CDsTable = nil;
		end
		if (db.TimerTextSize == nil) then
			db.TimerTextSize = math_ceil(db.IconSize - db.IconSize/2);
		end
    end,
    [1] = function()
        local db = addonTable.db;
        for spellName, spellInfo in pairs(db.SpellCDs) do
            if (spellInfo.class == nil) then
                for class, spellsTable in pairs(addonTable.CDs) do
                    for spellID in pairs(spellsTable) do
                        if (SpellNameByID[spellID] == spellName) then
                            spellInfo.class = class;
                        end
                    end
                end
            end
            spellInfo.refSpellID = nil;
        end
    end,
    [2] = function()
        local db = addonTable.db;
        for _, spellInfo in pairs(db.SpellCDs) do
            spellInfo.texture = nil;
        end
    end,
    [3] = function()
        local db = addonTable.db;
        for spellName, spellInfo in pairs(db.SpellCDs) do
            if (spellInfo.class == nil) then
                local found = false;
                for class, spellsTable in pairs(addonTable.CDs) do
                    for spellID in pairs(spellsTable) do
                        if (SpellNameByID[spellID] == spellName) then
                            spellInfo.class = class;
                            found = true;
                            break;
                        end
                    end
                end
                if (not found) then spellInfo.class = addonTable.UNKNOWN_CLASS; end
            end
        end
    end,
    [4] = function()
        local db = addonTable.db;
        db.UnwantedDefaultSpells = nil;
        db.CDsTable = nil;
    end,
    [5] = function()
        local db = addonTable.db;
        for spellName, spellInfo in pairs(db.SpellCDs) do
            if (spellName == SpellNameByID[336126]) then
                if (spellInfo.spellIDs ~= nil and not spellInfo.spellIDs[336126]) then
                    spellInfo.spellIDs[336126] = true;
                end
            end
        end
    end,
};

function addonTable.MigrateDB()
    for i = addonTable.db.MigrationVersion, (addonTable.table_count(migrations)-1) do
        migrations[i]();
        addonTable.Print("Converting DB up to version", i);
    end
    addonTable.db.MigrationVersion = addonTable.table_count(migrations);
end

function addonTable.ImportNewSpells()

end
