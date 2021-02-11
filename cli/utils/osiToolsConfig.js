const fs = require("fs"); //  Import File-System Module

//  Create OsiToolsConfig.json
const CreateOsiToolsConfig = (AuxConfig) => {
  let osiToolsConfig = {
    RequiredExtensionVersion: AuxConfig.ScriptExtenderVersion,
    ModTable: AuxConfig.ProjectName,
    FeatureFlags: AuxConfig.SEFeatureFlags,
  };

  const target = `./Mods/${AuxConfig.ProjectDirectory}`; //  Target directory
  fs.mkdirSync(target, { recursive: true }); //  Create target directory if it doesn't exist

  //  Write OsiToolsConfig.json
  fs.writeFile(
    `${target}/OsiToolsConfig.json`,
    JSON.stringify(osiToolsConfig, null, 2),
    (err) => err && console.error(err)
  );
};

//  ===========  EXPORT  =============
module.exports = CreateOsiToolsConfig;
//  ==================================