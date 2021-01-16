--  ================
--  SETTINGS MANAGER
--  ================

SettingsFile = File:New({['Name'] = MODINFO.SubdirPrefix .. IDENTIFIER .. "Settings.json"})
MODINFO.DefaultSettings = MODINFO.DefaultSettings or {}
SettingsFile.Contents = Integrate(MODINFO.DefaultSettings, MODINFO.ModSettings)
---@class Settings @Mod-Settings
Settings = SettingsFile.Contents

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
    updateSetting(self, settings, MODINFO.DefaultSettings)
    self:Sync()
end

function Settings:Load()
    SettingsFile:Load()
end

---Synchronizes Settings with MODINFO.ModSettings
function Settings:Sync() MODINFO.ModSettings = self end

---Saves Settings in CENTRAL file
function Settings:Save()
   self:Sync()
   SettingsFile:Save()
end

--  ============================================================================================
if Ext.IsServer() then Ext.RegisterOsirisListener('GameStarted', 2, 'before', Settings.Sync) end
--  ============================================================================================
