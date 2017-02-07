'use strict';

const Generator = require('yeoman-generator')
const chalk = require('chalk')
const toPascalCase = require('to-pascal-case')

module.exports = Generator.extend({

  prompting: function () {

    this.log(`This generator bootstraps a set of smart contracts implementing the DOUG pattern.`)

    const prompts = [{
      type    : 'input',
      name    : 'name',
      message : `What is your project name?`,
      default : this.appname
    }, {
      type    : 'confirm',
      name    : 'isStringsLibrary',
      message : `Would you like to install ${chalk.green('strings')} library?`
    }, {
      type    : 'confirm',
      name    : 'isStoreContract',
      message : `Would you like to pre-create a key/value store contract?`
    }]

    return this.prompt(prompts).then(function (props) {
      props.name = toPascalCase(props.name)
      props.pragmaSolidity = '^0.4.2'
      this.props = props
    }.bind(this))
  },

  writing: function () {

    // Gitignore
    if (this.props.isStringsLibrary) this.fs.copy(this.templatePath('.gitignore'), this.destinationPath('.gitignore'))

    // Libraries
    if (this.props.isStringsLibrary) this.fs.copyTpl(this.templatePath('libraries/strings.sol'), this.destinationPath('src/libraries/strings.sol'), this.props)

    // Utils
    this.fs.copyTpl(this.templatePath('utils/owned.sol'), this.destinationPath('src/utils/owned.sol'), this.props)

    // Framework
    this.fs.copyTpl(this.templatePath('framework/doug_provider.sol'), this.destinationPath('src/framework/doug_provider.sol'), this.props)
    this.fs.copyTpl(this.templatePath('framework/doug_main.sol'), this.destinationPath('src/framework/doug_main.sol'), this.props)
    this.fs.copyTpl(this.templatePath('framework/doug_contract.sol'), this.destinationPath('src/framework/doug_contract.sol'), this.props)
    this.fs.copyTpl(this.templatePath('framework/doug_entity.sol'), this.destinationPath('src/framework/doug_entity.sol'), this.props)

    // Contracts
    this.fs.copyTpl(this.templatePath('application/main.sol'), this.destinationPath('src/application/main.sol'), this.props)
    if (this.props.isStoreContract) this.fs.copyTpl(this.templatePath('application/keystore.sol'), this.destinationPath('src/application/keystore.sol'), this.props)
  }
})
