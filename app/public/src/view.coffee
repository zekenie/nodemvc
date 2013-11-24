template = '<div class="view">
				<input placeholder="view name" rv-value="name" class="form-control" type="text">
			</div>'

class View extends classes.Base
	constructor:(data,parent)->
		data = _.extend {name:''}, data
		@el = $ _.template template, @
		super arguments...
		@parent.viewsContainer.append @el
		@addEventListeners()

	addEventListeners:->
		self = @

classes.View = View
