//  Import File-System Module
const fs = require("fs");

//  Create OsiToolsConfig.json
const CreateOsiToolsConfig = (AuxConfig) => {
  let osiToolsConfig = {
    RequiredExtensionVersion: AuxConfig.ScriptExtenderVersion,
    ModTable: AuxConfig.ProjectName,
    FeatureFlags: AuxConfig.SEFeatureFlags,
  };

  const osiToolsPath = `./Mods/${AuxConfig.ProjectDirectory}/OsiToolsConfig.json`;

  fs.writeFile(osiToolsPath, JSON.stringify(osiToolsConfig, null, 2), (err) => {
    if (err) {
      console.error(err);
    }
  });
};

module.exports = CreateOsiToolsConfig;
