--  =================
--  CONSOLE COMMANDER
--  =================

ConsoleCommander = {
    ['Commands'] = {},
    ['Help'] = {}
}

---Register new Console-Command
---@param command string Command Name
---@param action function Command Action
---@param description string Help Description
function ConsoleCommander:Register(command, action, description)
    self.Commands[command] = action
    self.Help[command] = description
end

---Creates the Console-Command Help Message
---@param command string Console-Command to Query
---@return string help Help-Message
function ConsoleCommander:Helper(command)
    local help = ""
    if self.Help.command then help = help .. command .. "\t" .. self.Help.command .. "\n"
    else  
        help = "Console-Command Prefix: !" .. IDENTIFIER .. "\n"
        help = help .. string.rep("=", 70) .. "\n"
        help = help .. "COMMAND\t" .. "DESCRIPTION" .. "\n"
        help = help .. string.rep("-", 70) .. "\n"
        for command, description in pairs(self.Help) do
            help = help .. command .. "\t" .. description .. "\n"
        end
        help = help .. string.rep("=", 70)
    end
    return help
end

function ConsoleCommander:Init()
    self:Register('Help', function (cmd) Ext.PrintWarning(self:Helper(cmd)) end, "Use 'Help' command for more information")
    Ext.RegisterConsoleCommand(IDENTIFIER, function(cmd, command, ...)
        for key, action in pairs(self) do
            if string.lower(key) == string.lower(command) then action(...) end
        end
    end)
end

--  ============================================================
Ext.RegisterListener('ModuleLoadStarted', ConsoleCommander.Init)
--  ============================================================