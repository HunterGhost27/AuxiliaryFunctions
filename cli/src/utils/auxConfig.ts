//  Library
import fs from 'fs'
import inquirer from 'inquirer'

//  Type Definitions
import type { AuxConfig } from './typeDefinitions'

//  -------------------------------------------
export const auxConfigPath = './AuxConfig.json'
//  -------------------------------------------

//  ==========================
//  AUX-CONFIG FILE-MANAGEMENT
//  ==========================

//  Loads AuxConfig.json from the Current-Working-Directory
export const LoadAuxConfig = (): AuxConfig | {} => {
  try {
    fs.accessSync(auxConfigPath) //  Try to access AuxConfig.json
  } catch (err) {
    if (err.errno == -4058) {
      //  File not found or permission error
      fs.writeFileSync(auxConfigPath, '{}') //  Create file
    } else {
      console.error(err) //  Else log error
    }
  }

  return JSON.parse(fs.readFileSync(auxConfigPath, 'utf-8')) //  Parse AuxConfig.json
}

//  ===================================
//  INQUIRE ABOUT AUX-CONFIG PROPERTIES
//  ===================================

//  Prompts user for any missing AuxConfig.json properties
export const PromptForMissingProperties = async (AuxConfig: Partial<AuxConfig>) => {
  let questions = [] //  Array to hold list of inquirer prompts
  let SCG = {} as AuxConfig //  Source-Control-Generator

  try {
    SCG = JSON.parse(fs.readFileSync('./SourceControlGenerator.json', 'utf-8'))
  } catch (err) {
    console.error(err)
  }

  //  PROJECT NAME
  if (!AuxConfig.ProjectName) {
    questions.push({
      type: 'input',
      name: 'ProjectName',
      default: SCG.ProjectName,
    });
  }

  //  PROJECT UUID
  if (!AuxConfig.ProjectUUID) {
    questions.push({
      type: 'input',
      name: 'ProjectUUID',
      default: SCG.ProjectUUID,
    });
  }

  //  SCRIPT-EXTENDER VERSION
  if (!AuxConfig.ScriptExtenderVersion) {
    questions.push({
      type: 'number',
      name: 'ScriptExtenderVersion',
      default: 52,
    });
  }

  //  SCRIPT-EXTENDER FEATURE FLAGS
  if (!AuxConfig.SEFeatureFlags) {
    questions.push({
      type: 'checkbox',
      name: 'SEFeatureFlags',
      choices: [
        "OsirisExtensions",
        "Lua",
        "Preprocessor",
        "DisableFolding",
        "CustomStats",
        "CustomStatsPane",
      ],
      default: ["OsirisExtensions", "Lua"],
    });
  }

  await inquirer
    .prompt(questions) //  Prompt for Questions
    .then((value) => (AuxConfig = { ...AuxConfig, ...value })) // Update AuxConfig
    .catch((err) => console.error(err))

  //  PROJECT DIRECTORY
  if (!AuxConfig.ProjectDirectory) {
    await inquirer
      .prompt({
        type: "input",
        name: "ProjectDirectory",
        default: `${AuxConfig.ProjectName}_${AuxConfig.ProjectUUID}`,
      })
      .then((value) => (AuxConfig.ProjectDirectory = value.ProjectDirectory))
      .catch((err) => console.error(err));
  }

  return AuxConfig as AuxConfig
}