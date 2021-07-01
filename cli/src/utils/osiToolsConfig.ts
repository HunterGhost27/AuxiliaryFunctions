//  Library
import fs from 'fs'

//  Type Definitions
import type { AuxConfig } from './typeDefinitions'

//  ======================
//  CREATE OSITOOLS CONFIG
//  ======================

//  Create OsiToolsConfig.json
const CreateOsiToolsConfig = (AuxConfig: AuxConfig) => {

  const target = `./Mods/${AuxConfig.ProjectDirectory}` //  Target directory
  fs.mkdirSync(target, { recursive: true }) //  Create target directory if it doesn't exist

  const osiToolsConfig = {
    RequiredExtensionVersion: AuxConfig.ScriptExtenderVersion,
    ModTable: AuxConfig.ProjectName,
    FeatureFlags: AuxConfig.SEFeatureFlags,
  }

  fs.writeFile(
    `${target}/OsiToolsConfig.json`,
    JSON.stringify(osiToolsConfig, null, 2),
    (err) => err && console.error(err)
  )
}

//  ===============================
export default CreateOsiToolsConfig
//  ===============================
