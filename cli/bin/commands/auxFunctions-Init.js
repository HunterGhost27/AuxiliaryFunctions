//  =======
//  IMPORTS
//  =======

const fs = require("fs"); //  File-System Module
const degit = require("degit"); //  Degit files from GitHub Repository

const {
  auxConfigPath,
  LoadAuxConfig,
  PromptForMissingProperties,
} = require("../../utils/auxConfig");

const CreateOsiToolsConfig = require("../../utils/osiToolsConfig");

//  ==========
//  INITIALIZE
//  ==========

//  Initialize AuxFunctions
async function Init(options) {
  //  INITIALIZE AUXCONFIG
  let AuxConfig = LoadAuxConfig();
  AuxConfig = await PromptForMissingProperties(AuxConfig);

  //  SCAFFOLD PROJECT
  CreateOsiToolsConfig(AuxConfig);

  //  SAVE AUXCONFIG
  fs.writeFileSync(auxConfigPath, JSON.stringify(AuxConfig, null, 2), "utf8");
}

//  ====  EXPORT  ====
module.exports = Init;
//  ==================
