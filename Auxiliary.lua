----------------------------------------------------------------
--==============================================================

IDENTIFIER = '>>IDENTIFIER<<'

---@class MODINFO: ModInfo
---@field ModVersion string
---@field ModSettings table
---@field DefaultSettings table
---@field SubdirPrefix string
MODINFO = Ext.GetModInfo('>>UUID<<')
MODINFO.DefaultSettings = {}

PersistentVars = {}

--  ========  AUX FUNCTIONS  =========
Ext.Require("Functions/Auxiliary.lua")
--  ==================================

--==============================================================
----------------------------------------------------------------