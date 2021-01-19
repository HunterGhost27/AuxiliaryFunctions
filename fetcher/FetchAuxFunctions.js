const degit = require('degit');

//  ======
//  CONFIG
//  ======

const repository = 'HunterGhost27/AuxiliaryFunctions/'
const config = require('./fetcherConfig.json')
const projectFolder = config.ProjectFolder || config.IDENTIFIER + '_' + config.UUID

//  =============
//  AUX-FUNCTIONS
//  =============

//  AuxFunctions
//  ============

const auxFunctions = degit(repository + 'AuxFunctions', {
    cache: true,
    force: true,
    verbose: true,
})

auxFunctions.on('info', info => {
    console.log(info.message)
})

auxFunctions.clone('Mods/' + projectFolder + '/Story/RawFiles/Lua/').then(() => {
    console.log('Imported AuxFunctions to Lua-Folder');
})

//  Auxiliary.lua
//  =============

const aux = degit(repository + 'Auxiliary.lua', {
    cache: true,
    verbose: true
})

aux.on('info', info => {
    console.log(info.message)
})

aux.clone('Mods/' + projectFolder + 'Story/RawFiles/Lua/').then(() => {
    console.log('Imported Auxiliary.lua to Lua-Folder')
})