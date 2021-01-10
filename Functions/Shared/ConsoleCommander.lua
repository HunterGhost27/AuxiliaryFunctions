--  =================
--  CONSOLE COMMANDER
--  =================

---@class Command
---@field Name string Command Name
---@field Action function Command Action
---@field Context string Context: "Shared", "Server" or "Client"
---@field Description string Help-Messsage
---@field Params table Parameters
Command = {
    ['Name'] = "",
    ['Action'] = function() end,
    ['Context'] = "Shared",
    ['Description'] = "",
    ['Params'] = {}
}

function Command:New(object)
    local object = object or {}
    Integrate(self, object)
    return object
end

ConsoleCommander = {}

function ConsoleCommander:Register(CMD)
    if not ValidString(CMD.Name) then S7Debug:Error('Cannot register console-command. Invalid commandName') end
    self[CMD.Name] = Command:New(CMD)
end

local function isValidContext(CMD)
    if CMD.Context == "Shared" or CMD.Context == Ext.IsServer() and "Server" or "Client" then return true
    else return false end
end

function ConsoleCommander:Help(target)
    local helpMsg = ""
    if self[target] and isValidContext(self[target]) then
        helpMsg = target .. "\t" .. self[target].Description .. "\n"
        for key, value in ipairs(self[target].Params) do helpMsg = helpMsg .. "\t" .. "Parameter" .. key .. ": " .. value .. "\n" end
    else
        helpMsg = "\n"
        helpMsg = helpMsg .. string.rep("=", 70) .. "\n"
        helpMsg = helpMsg .. "COMMAND\tDESCRIPTION\n"
        helpMsg = helpMsg .. string.rep("-", 70) .. "\n"
        for name, CMD in pairs(self) do if isValidContext(CMD) then helpMsg = helpMsg .. name .. "\t" .. CMD.Description .. "\n" end end
        helpMsg = helpMsg .. string.rep("=", 70) .. "\n"
    end
    S7Debug:FWarn(helpMsg)
end

ConsoleCommander:Register({
    ['Name'] = "Help",
    ['Action'] = ConsoleCommander.Help,
    ['Context'] = "Shared",
    ['Description'] = "Displays a list of all console-commands",
    ['Params'] = {[1] = "Target Command"}
})

function ConsoleCommander:Init()
    Ext.RegisterConsoleCommand(IDENTIFIER, function(cmd, command, ...)
        if not self[command] then return end
        if isValidContext(self[command]) then self[command].Action(...) end
    end)
end

--  ============================================================
Ext.RegisterListener('ModuleLoadStarted', ConsoleCommander.Init)
--  ============================================================