//  Import File-System Module
const fs = require("fs");

//  Create OsiToolsConfig.json
const CreateOsiToolsConfig = (AuxConfig) => {
  let osiToolsConfig = {
    RequiredExtensionVersion: AuxConfig.ScriptExtenderVersion,
    ModTable: AuxConfig.ProjectName,
    FeatureFlags: AuxConfig.SEFeatureFlags,
  };

  fs.writeFile(
    `./Mods/${AuxConfig.ProjectDirectory}/OsiToolsConfig.json`,
    JSON.stringify(osiToolsConfig, null, 2),
    (err) => {
      if (err) {
        console.error(err);
      }
    }
  );
};

module.exports = CreateOsiToolsConfig;
