--  ==========
--  CENTRALIZE
--  ==========

CENTRAL = {}
CENTRAL[IDENTIFIER] = {
    ["Author"] = MODINFO.Author,
    ["Name"] = MODINFO.Name,
    ["UUID"] = MODINFO.UUID,
    ["Version"] = MODINFO.Version,
    ["ModVersion"] = "0.0.0.0",
    ["ModSettings"] = {},
}

function CENTRAL:Load()
    self = Integrate(self, LoadFile('S7Central.json'))
    Settings:Write(self.ModSettings)
end

function CENTRAL:Sync()
    for key, _ in pairs(self[IDENTIFIER]) do
        if IsValid(MODINFO[key]) then
            self[IDENTIFIER][key] = Rematerialize(MODINFO[key])
        end
    end
end

function CENTRAL:Save() SaveFile('S7Central.json', Rematerialize(self)) end

function CENTRAL:ReSync()
    self:Load()
    self:Sync()
    self:Save()
end