template = '<tr class="property">
				<td><button data-grab="arrayBtn" type="button" class="btn btn-default btn-sm" data-toggle="button">[ ]</button></td>
				<td><input autofocus class="form-control" type="text" size="6" placeholder="key" rv-input="key | codeSafe"></td>
				<td>
					<select data-grab="typeSelect" rv-value="type" class="form-control">
						<option></option>
					</select>
				</td>
				<td>
					<select data-grab="refSelect" rv-value="ref" class="hide form-control">
						<option></option>
					</select>
				</td>
				<td class="delete" width="9%"><button data-grab="deleteBtn" class="btn btn-sm btn-danger"><span class="glyphicon glyphicon-remove"></span></button></td>
			</tr>'

possibleTypes = [
	"String"
	"Number"
	"Boolean"
	"Array"
	"Buffer"
	"Date"
	"Schema.Types.ObjectId"
	"Schema.Types.Mixed"
]

class Property extends classes.Base
	constructor:(data,parent)->
		data = _.extend {key:'',type:'',array:false,ref:''}, data
		@el = $ _.template template, @
		@project = parent.parent.parent
		super arguments...
		@parent.propertiesContainer.append @el
		@addEventListeners()

	renderRefs:->
		@refSelect.html '<option></option>'
		for entity in _.pluck @project.entities,'plural'
			@refSelect.append '<option>' + entity + '</option>'
		@refSelect.val @ref


	render:->
		for type in possibleTypes
			@typeSelect.append '<option>' + type + '</option>'
		@typeSelect.val @hook
		@arrayBtn.addClass 'active' if @array is true
		@renderRefs()
		super()

	addEventListeners:->
		self = @
		@arrayBtn.on 'click', ->
			self.array = !self.array
			return true

		@project.on 'addEntityEvt',->
			self.renderRefs()

		@typeSelect.on 'change', ->
			self.refSelect.addClass 'hide'
			self.refSelect.removeClass 'hide' if @.value is 'ObjectId'

		@deleteBtn.on 'click',->
			self.remove();

	toJSON:->
		_.pick @, 'key','type','array','ref'

classes.Property = Property