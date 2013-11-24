request = require 'request'
_ = require 'lodash'
npmArray = []
request.get 'http://registry.npmjs.org/-/all/',{json:true},(err,resp,body)->
	throw err if err
	npmArray = Object.keys(body)
	console.log 'done loading npm stuff'

module.exports = ->
	controller =
		index: (req, res, next) ->
			res.json npmArray
		search: (req,res,next) ->
			filtered = npmArray.filter (el)->
				el.indexOf(req.query.q) is 0
			res.json filtered