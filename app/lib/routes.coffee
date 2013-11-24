module.exports = (app, npm) ->
	app.get('/npmJson',npm.index)
	app.get '/npmSearch',npm.search
