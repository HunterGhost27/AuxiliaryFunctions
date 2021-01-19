const degit = require('degit');

//  ======
//  CONFIG
//  ======

const repository = 'HunterGhost27/AuxiliaryFunctions'
const config = require('./fetcherConfig.json')
const projectFolder = config.ProjectDetails.ProjectFolder || `${config.ProjectDetails.IDENTIFIER}_${config.ProjectDetails.UUID}`

//  =============
//  AUX-FUNCTIONS
//  =============

//  AuxFunctions
//  ============

const auxFunctions = degit(`${repository}`, {
    cache: config.Settings.cache || true,
    force: config.Settings.force || true,
    verbose: config.Settings.verbose || true,
})

auxFunctions.on('info', info => {
    console.log(info.message)
})

auxFunctions.clone(`Mods/${projectFolder}`).then(() => {
    console.log('Imported AuxFunctions');
})