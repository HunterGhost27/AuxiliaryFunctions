//  =======
//  IMPORTS
//  =======

const fs = require("fs"); //  File-System Module
const chalk = require("chalk"); //  Formatting
const Listr = require("listr"); // Listr Module

const {
  auxConfigPath,
  LoadAuxConfig,
  PromptForMissingProperties,
} = require("../../utils/auxConfig");

const CreateOsiToolsConfig = require("../../utils/osiToolsConfig");
const DegitAuxFunctions = require("../../utils/degitRepo");

//  ==========
//  INITIALIZE
//  ==========

//  Initialize AuxFunctions
async function Init(options) {
  console.log(chalk.bold.inverse(" Initializing DOS2:DE Project "));

  //  INITIALIZE AUXCONFIG
  let AuxConfig = options.reinit ? {} : LoadAuxConfig();
  AuxConfig = await PromptForMissingProperties(AuxConfig);

  //  SCAFFOLD PROJECT
  const tasks = new Listr([
    {
      title: "Save AuxConfig.json",
      task: () =>
        fs.writeFileSync(
          auxConfigPath,
          JSON.stringify(AuxConfig, null, 2),
          "utf8"
        ),
    },
    {
      title: "Create OsiToolsConfig.json",
      task: () => CreateOsiToolsConfig(AuxConfig),
    },
    {
      title: "Degit AuxFunctions from HunterGhost27/AuxiliaryFunctions",
      task: () => DegitAuxFunctions(AuxConfig),
    },
  ]);

  await tasks
    .run()
    .then((response) =>
      console.log(chalk.bold.green(" DOS2:DE Project Initialized "))
    )
    .catch((reason) => console.error(chalk.bold.red(reason)));
}

//  ====  EXPORT  ====
module.exports = Init;
//  ==================
