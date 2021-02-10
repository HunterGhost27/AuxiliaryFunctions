#!/usr/bin/env node
//=================

//  =======
//  IMPORTS
//  =======

require = require("esm")(module /*, options */);
const app = require("../package.json");
const program = require("commander");

//  ============
//  MAIN COMMAND
//  ============

program
  .name("AuxFunctions")
  .version(app.version)
  .action(() => console.log("Sync"))
  .parse(process.argv);
