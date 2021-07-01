//  Library
import fs from 'fs' //  FileSystem Module
import chalk from 'chalk' //  Formatting
import Listr from 'listr' //  Listr Module

//  Utilities
import { auxConfigPath, LoadAuxConfig, PromptForMissingProperties } from '../utils/auxConfig'
import CreateOsiToolsConfig from '../utils/osiToolsConfig'
import DegitAuxFunctions from '../utils/degitRepo'

//  Type Definitions
import type { AuxConfig, AuxOptions } from '../utils/typeDefinitions'

//  ==========
//  INITIALIZE
//  ==========

//  Initialize AuxFunctions
async function Init(options: AuxOptions) {
  console.log(chalk.bold.inverse(" Initializing DOS2:DE Project "))

  //  INITIALIZE AUXCONFIG
  const PartialAuxConfig = options.reinit ? {} : LoadAuxConfig()
  const AuxConfig: AuxConfig = await PromptForMissingProperties(PartialAuxConfig)

  //  SCAFFOLD PROJECT
  const tasks = new Listr([
    {
      title: "Save AuxConfig.json",
      task: () =>
        fs.writeFileSync(
          auxConfigPath,
          JSON.stringify(AuxConfig, null, 2),
          {}
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
    .then(() =>
      console.log(chalk.bold.green(" DOS2:DE Project Initialized "))
    )
    .catch((reason) => console.error(chalk.bold.red(reason)));
}


//  ===============
export default Init
//  ===============
