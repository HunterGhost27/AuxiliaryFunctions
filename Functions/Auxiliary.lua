--  ===================
--  AUXILIARY FUNCTIONS
--  ===================

--  IMPORT SHARED
--  =============

Ext.Require('Functions/Shared/General.lua')
Ext.Require('Functions/Shared/Strings.lua')
Ext.Require('Functions/Shared/Tables.lua')
Ext.Require('Functions/Shared/Files.lua')
Ext.Require('Functions/Shared/Versioning.lua')
Ext.Require('Functions/Shared/Networker.lua')
Ext.Require('Functions/Shared/Debug.lua')

--  IMPORT SERVER-SIDE
--  ==================

if Ext.IsServer() then
    Ext.Require('Functions/Server/ConsoleCommander.lua')
end

--  IMPORT CLIENT-SIDE
--  ==================

if Ext.IsClient() then
    
end