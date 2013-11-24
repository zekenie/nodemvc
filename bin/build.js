#!/usr/bin/env node

var fs = require('fs'),
	unzip = require('unzip'),
	path = require('path');

//This is because the ejs package I'm using sucks.
fs.createReadStream(path.join(process.cwd(),'app/public/bower_components/ejs/index.zip'))
	.pipe(unzip.Extract({path:path.join(process.cwd(),'app/public/bower_components/ejs/')}));

process.on('uncaughtException',function(e) {
	console.log(e.stack);
})