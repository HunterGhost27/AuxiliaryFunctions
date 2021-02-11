//  =======
//  IMPORTS
//  =======

const fs = require("fs"); //  File-System Module
const degit = require("degit"); //  Degit files from GitHub Repository

//  -------------   REPOSITORY   ---------------
const repo = "HunterGhost27/AuxiliaryFunctions";
//  --------------------------------------------

//  ====================
//  UPDATE DEGIT OPTIONS
//  ====================

//  Returns degit options
const DegitOptions = (options) => {
  return {
    cache: options?.cache || false,
    verbose: options?.verbose || false,
    force: options?.force || false,
  };
};

//  =================
//  SCAFFOLD AUX-MAIN
//  =================

//  Creates a tempalte Auxiliary.lua in /Story/RawFiles/Lua
const CreateAuxMain = (AuxConfig) => `
----------------------------------------------------------------
--==============================================================

IDENTIFIER = '${AuxConfig.ProjectName}'

---@class MODINFO: ModInfo
---@field ModVersion string
---@field ModSettings table
---@field DefaultSettings table
---@field SubdirPrefix string
MODINFO = Ext.GetModInfo('${AuxConfig.ProjectUUID}')

--  ========  AUX FUNCTIONS  ========
Ext.Require('AuxFunctions/Index.lua')
--  =================================

--==============================================================
----------------------------------------------------------------
`;

//  ===================
//  DEGIT AUX-FUNCTIONS
//  ===================

const DegitAuxFunctions = (AuxConfig, options) => {
  //  Initialize Degit
  const lua = degit(
    `${repo}/Story/RawFiles/Lua/AuxFunctions`,
    DegitOptions(options)
  );

  //  Check target directory
  const target = `./Mods/${AuxConfig.ProjectDirectory}/Story/RawFiles/Lua`;
  fs.mkdirSync(target, { recursive: true });

  //  Degit Repository
  lua
    .clone(`${target}/AuxFunctions/`)
    .then(() =>
      console.log(`Cloned ${repo}#master into ${target}/AuxFunctions/`)
    )
    .catch((err) => {
      if (err.code === "DEST_NOT_EMPTY") {
        console.log(`Destination(${target}/AuxFunctions/) is not empty!`);
      }
    });

  //  Scaffold Auxiliary.lua
  fs.access(`${target}/Auxiliary.lua`, (err) => {
    if (err) {
      if (err.errno === -4058) {
        fs.writeFile(
          `${target}/Auxiliary.lua`,
          CreateAuxMain(AuxConfig),
          (err) => err && console.error(err)
        );
      } else {
        console.error(err);
      }
    }
  });
};

//  =======    EXPORT   ===========
module.exports = DegitAuxFunctions;
//  ===============================
