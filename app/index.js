#!/usr/bin/env node

var cs = require('coffee-script');
cs.register();
var train = require('express-train');

module.exports = train(__dirname);