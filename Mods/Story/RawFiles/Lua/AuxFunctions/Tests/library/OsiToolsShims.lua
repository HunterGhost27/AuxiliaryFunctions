--  Polyfills for OsiTools

local JSON = require('Mods.Story.RawFiles.Lua.AuxFunctions.Tests.library.JSON')

Ext = {}

function Ext.JsonStringify(x) return JSON.stringify(x) end