const degit = require("degit"); //  Degit files from GitHub Repository

const repo = "HunterGhost27/AuxiliaryFunctions";

const emitter = degit(`${repo}/Story/`, {
  cache: false,
  verbose: false,
  force: false,
});

emitter.on("info", (info) => console.log(info.message));

const DegitAuxFunctions = (AuxConfig) => {
  const target = `./Mods/${AuxConfig.ProjectDirectory}/Story/`;
  emitter.clone(target).catch((err) => {
    if (err.code === "DEST_NOT_EMPTY") {
      console.log("Destination is not empty!");
    }
  });
};

module.exports = DegitAuxFunctions;
