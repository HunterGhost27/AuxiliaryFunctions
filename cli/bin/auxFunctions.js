#!/usr/bin/env node
//=================

//  =======
//  IMPORTS
//  =======

require = require("esm")(module /*, options */);
const app = require("../package.json");
const program = require("commander");

//  COMMANDS
//  ========

const Init = require("./commands/auxFunctions-Init");

//  ============
//  MAIN COMMAND
//  ============

program.name("AuxFunctions").version(app.version);

program
  .command("Init")
  .description("Initialize AuxFunctions")
  .action((options) => Init(options));

program.parse();
