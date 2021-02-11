#!/usr/bin/env node
//=================

//  =======
//  IMPORTS
//  =======

const { version } = require("../package.json");
const program = require("commander");

//  ========
//  COMMANDS
//  ========

const Init = require("./commands/auxFunctions-Init");

program.name("AuxFunctions").version(version);

//  AUXFUNCTION INIT
//  ================

program
  .command("Init")
  .description("Initialize AuxFunctions")
  .option("-r, --reinit", "Reinitialize AuxConfig")
  .action((options) => Init(options));

//  PARSE ARGUMENTS
//  ===============

program.parse();
