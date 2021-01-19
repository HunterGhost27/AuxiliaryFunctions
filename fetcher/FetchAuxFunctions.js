//  ===================
//  IMPORT NODE MODULES
//  ===================

const fs = require('fs')
const degit = require('degit')

//  ======
//  CONFIG
//  ======

const repository = 'HunterGhost27/AuxiliaryFunctions'

const { projectFolder, Validator, config } = require('./config')
Validator(config)

//  =============
//  AUX-FUNCTIONS
//  =============

const auxFunctions = degit(`${repository}`, config.Settings)
auxFunctions.on('info', info => console.log(info.message))
auxFunctions.clone(`Mods/${projectFolder}`)
    .then(() => console.log('Imported AuxFunctions'))
    .catch(err => console.error(err))

//  =======================
//  UPDATE OSI-TOOLS-CONFIG
//  =======================

let osiToolsConfig = {
    "RequiredExtensionVersion": config.ProjectDetails.ScriptExtenderVersion || 52,
    "ModTable": config.ProjectDetails.IDENTIFIER || "S7_AuxiliaryFunctions",
    "FeatureFlags": [
        "OsirisExtensions",
        "Lua"
    ],
}
if (fs.existsSync(`Mods/${projectFolder}/OsiToolsConfig.json`)) {
    const existingOsiToolsConfig = require(`./Mods/${projectFolder}/OsiToolsConfig.json`)
    console.log('Existing OsiToolsConfig.json')
    osiToolsConfig = {
        ...osiToolsConfig,
        ...existingOsiToolsConfig
    }
}

fs.writeFileSync(`./Mods/${projectFolder}/OsiToolsConfig.json`, JSON.stringify(osiToolsConfig), 'utf8', function (err) {
    if (err) { console.log("Failed to write JSON-Object to File"); return console.log(err) }
    console.log('OsiToolsConfig.json saved')
})
