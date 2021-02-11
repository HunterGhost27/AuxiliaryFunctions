//  Import File-System Module
const fs = require("fs");

//  Create OsiToolsConfig.json
const CreateOsiToolsConfig = (AuxConfig) => {
  let osiToolsConfig = {
    RequiredExtensionVersion: AuxConfig.ScriptExtenderVersion,
    ModTable: AuxConfig.ProjectName,
    FeatureFlags: AuxConfig.SEFeatureFlags,
  };

  const target = `./Mods/${AuxConfig.ProjectDirectory}`;
  fs.mkdirSync(target, { recursive: true });

  fs.writeFile(
    `${target}/OsiToolsConfig.json`,
    JSON.stringify(osiToolsConfig, null, 2),
    (err) => err && console.error(err)
  );
};

module.exports = CreateOsiToolsConfig;
