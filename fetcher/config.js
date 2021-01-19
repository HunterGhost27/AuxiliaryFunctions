const config = require('./auxConfig.json')

Validator = (config) => {
    if (config == null) {
        console.error('Config is null')
        return
    }

    if (config.ProjectDetails.UUID == null) {
        console.error('Config.ProjectDetails does not have a UUID')
        return
    }

    if (config.ProjectDetails.IDENTIFIER == null) {
        config.error('Config.ProjectDetails does not havev a IDENTIFIER')
    }
}

config.Settings = {
    cache: false,
    force: false,
    verbose: false,
    ...config.Settings
}

const projectFolder = config.ProjectDetails.ProjectFolder || `${config.ProjectDetails.IDENTIFIER}_${config.ProjectDetails.UUID}`

module.exports = {
    config,
    projectFolder,
    Validator
}