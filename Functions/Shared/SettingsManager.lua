--  ================
--  SETTINGS MANAGER
--  ================

---@class Settings @Mod-Settings
SettingsFile = File:New({['Name'] = MODINFO.SubdirPrefix .. IDENTIFIER .. "Settings.json"})
DefaultSettings = DefaultSettings or {}
SettingsFile.Contents = Integrate(DefaultSettings, MODINFO.ModSettings)
Settings = SettingsFile.Contents

---Loads CENTRAL file and Updates settings
function Settings:Load()
    CENTRAL:Load()
    self:Update(CENTRAL[IDENTIFIER].ModSettings)
end

---Updates settings on a case-by-case basis
---@param parent Settings
---@param settings Settings
---@param default Settings
local function updateSetting(parent, settings, default)
    if not IsValid(parent) or not IsValid(settings) then return end
    for key, value in pairs(default) do
        if type(value) == 'table' then updateSetting(parent[key], settings[key], value) end
        if parent[key] == settings[key] then break end
        if settings[key] == false then parent[key] = false end
        parent[key] = settings[key] or value
    end
end

---Updates Settings
---@param settings Settings
function Settings:Update(settings)
    local settings = settings or {}
    updateSetting(self, settings, DefaultSettings)
    self:Sync()
end

---Synchronizes Settings with MODINFO.ModSettings and PersistentVars.Settings
function Settings:Sync() MODINFO.ModSettings = self end

---Saves Settings in CENTRAL file
function Settings:Save()
   self:Sync()
   CENTRAL:Sync()
   CENTRAL:Save()
end

--  ============================================================================================
if Ext.IsServer() then Ext.RegisterOsirisListener('GameStarted', 2, 'before', Settings.Sync) end
--  ============================================================================================
