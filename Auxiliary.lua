----------------------------------------------------------------
--==============================================================

IDENTIFIER = '>>IDENTIFIER<<'

---@class MODINFO: ModInfo
---@field ModVersion string
---@field ModSettings table
---@field SubdirPrefix string
MODINFO = Ext.GetModInfo('>>UUID<<')

DefaultSettings = {}

PersistentVars = {}

--  ========  AUX FUNCTIONS  =========
Ext.Require("Functions/Auxiliary.lua")
--  ==================================

--==============================================================
----------------------------------------------------------------