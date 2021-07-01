#!/usr/bin/env node
//=================

//  Library
import { program } from 'commander'
const { version } = require('../package.json')

//  Type Definitions
import type { AuxOptions } from './utils/typeDefinitions'

//  -----------------------------------------
program.name('AuxFunctions').version(version)
//  -----------------------------------------

//  ========
//  COMMANDS
//  ========

import Init from './commands/auxFunctions-Init'

//  AUXFUNCTION INIT
//  ================

program
  .command('Init')
  .description("Initialize AuxFunctions")
  .option('-r, --reinit', "Reinitialize AuxConfig")
  .action((options: AuxOptions) => Init(options))

program.parse()
