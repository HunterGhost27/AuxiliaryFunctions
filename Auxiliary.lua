----------------------------------------------------------------
--==============================================================

IDENTIFIER = '>>IDENTIFIER<<'

---@class MODINFO: ModInfo
---@field ModVersion string
---@field ModSettings table
---@field DefaultSettings table
---@field SubdirPrefix string
MODINFO = Ext.GetModInfo('>>UUID<<')

--  ========  AUX FUNCTIONS  ========
Ext.Require("AuxFunctions/Index.lua")
--  =================================

--==============================================================
----------------------------------------------------------------