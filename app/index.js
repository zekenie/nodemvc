#!/usr/bin/env node

require('coffee-script');
var train = require('express-train');

module.exports = train(__dirname);