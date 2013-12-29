request = require 'request'
_ = require 'lodash'
npmArray = []
request.get 'http://registry.npmjs.org/-/all/',{json:true},(err,resp,body)->
	throw err if err
	npmArray = Object.keys body or {}
	console.log 'done loading npm stuff'

module.exports = ->
	controller =
		index: (req, res, next) ->
			res.json npmArray
		search: (req,res,next) ->
			if npmArray.length > 0
				filtered = npmArray.filter (el)->
					el.indexOf(req.query.q) is 0
				res.json filtered
			else
				res.json []