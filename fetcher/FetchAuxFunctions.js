//  ===================
//  IMPORT NODE MODULES
//  ===================

const degit = require('degit');

//  ======
//  CONFIG
//  ======

const repository = 'HunterGhost27/AuxiliaryFunctions'

const {
    projectFolder,
    Validator,
    config
} = require('./config')

Validator(config)

//  =============
//  AUX-FUNCTIONS
//  =============

const auxFunctions = degit(`${repository}`, config.Settings)
auxFunctions.on('info', info => console.log(info.message))
auxFunctions.clone(`Mods/${projectFolder}`)
    .then(() => console.log('Imported AuxFunctions'))
    .catch(err => console.error(err))