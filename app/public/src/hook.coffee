template = '<tr class="hook">
				<td>
					<select autofocus class="form-control" rv-value="hook" data-grab="hookSelect">
						<option></option>
					</select>
				</td>
				<td>
					<select class="form-control" rv-value="action" data-grab="actionSelect">
						<option></option>
					</select>
				</td>
				<td>
					<input rv-value="comment" class="form-control" type="text">
				</td>
				<td class="delete" width="9%"><button data-grab="deleteBtn" class="btn btn-sm btn-danger"><span class="glyphicon glyphicon-remove"></span></button></td>
			</tr>'

possibleHooks = ['pre','post']
possibleActions = ['save','remove']

# hooks can have hook type (pre,post), action (save,remove), and a comment
class Hook extends classes.Base
	constructor:(data,parent)->
		data = _.extend {hook:'',action:'',comment:''}, data
		@el = $ _.template template, @
		super arguments...
		@parent.hooksContainer.append @el
		@addEventListeners()

	render:->
		for hook in possibleHooks
			@hookSelect.append '<option>' + hook + '</option>'
		for action in possibleActions
			@actionSelect.append '<option>' + action + '</option>'
		@hookSelect.val @hook
		@actionSelect.val @action
		super()

	addEventListeners:->
		self = @
		@deleteBtn.on 'click',->
			self.remove();

	toJSON:->
		_.pick @, 'comment','action','hook'

classes.Hook = Hook
