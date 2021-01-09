--  ==============
--  MOD VERSIONING
--  ==============

--  PARSE MOD VERSIONS
--  ------------------

--- Parse modVersion
---@param version string|table|number
---@param returnMode string|nil 'string', 'table' or nil
function ParseVersion(version, returnMode)
    local major, minor, revision, build = 0, 0, 0, 0
    local versionTable = {}

    if type(version) == "string" then
        if string.gmatch(version, "[^.]+") ~= nil then
            for v in string.gmatch(version, "[^.]+") do versionTable[#versionTable + 1] = v end
            major, minor, revision, build = table.unpack(versionTable)
        else
            version = math.floor(tonumber(version))
            ParseVersion(version)
        end

    elseif type(version) == "table" then
        versionTable = version
        major, minor, revision, build = table.unpack(versionTable)

    elseif type(version) == "number" then
        version = math.tointeger(version)
        major = math.floor(version >> 28)
        minor = math.floor(version >> 24) & 0x0F
        revision = math.floor(version >> 16) & 0xFF
        build = math.floor(version & 0xFFFF)
        versionTable = table.pack(major, minor, revision, build)
	end

    if returnMode == "table" then return versionTable
    elseif returnMode == "string" then return string.format("%s.%s.%s.%s", major, minor, revision, build)
    else return major, minor, revision, build end
end
