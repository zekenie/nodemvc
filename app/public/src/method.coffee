template = '<li class="list-group-item method">
				<input placeholder="method name" rv-value="name" class="form-control" type="text">
			</li>'

class Method extends classes.Base
	constructor:(data,parent)->
		data = _.extend {name:''}, data
		@el = $ _.template template, @
		super arguments...
		@parent.methodsContainer.append @el
		@addEventListeners()

	addEventListeners:->
		self = @

classes.Method = Method
