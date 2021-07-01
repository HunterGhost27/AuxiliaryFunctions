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

import init from './commands/init'

//  AUXFUNCTION INIT
//  ================

program
  .command('init')
  .description("Initialize AuxFunctions")
  .option('-r, --reinit', "Reinitialize AuxConfig")
  .action((options: AuxOptions) => init(options))

program.parse()
