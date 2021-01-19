const degit = require('degit');

//  ======
//  CONFIG
//  ======

const repository = 'HunterGhost27/AuxiliaryFunctions'
const config = require('./fetcherConfig.json')
const projectFolder = config.ProjectDetails.ProjectFolder || `${config.ProjectDetails.IDENTIFIER}_${config.ProjectDetails.UUID}`
config.Settings = {
    cache: false,
    force: false,
    verbose: false,
    ...config.Settings
}

//  =============
//  AUX-FUNCTIONS
//  =============

const auxFunctions = degit(`${repository}`, config.Settings)
auxFunctions.on('info', info => console.log(info.message))
auxFunctions.clone(`Mods/${projectFolder}`)
    .then(() => console.log('Imported AuxFunctions'))
    .catch(err => console.error(err))