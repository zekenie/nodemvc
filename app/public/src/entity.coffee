children = {
	'Controller':'controllers'
}

pillTemplate = '<li class="active"><a href="#<%=id%>" data-toggle="pill">{singular}</a></li>'

template = 	'<div class="tab-pane" id="<%=id%>">
				<div class="row dark">
					<div class="col-md-6">
						<input autofocus class="input-lg form-control" data-grab="singularInput" rv-input="singular | firstLower" placeholder="Singular name (eg user)">
					</div>
					<div class="col-md-6">
						<input class="input-lg form-control" data-grab="pluralInput" rv-input="plural | firstCap" placeholder="Plural name (eg Users)">
					</div>
				</div>

				<div class="row">
					<div class="col-md-6" data-grab="modelContainer"></div>
					<div class="col-md-6" data-grab="controllersContainer">

						<div class="page-header">
							<h3 >Controllers
								<button class="btn btn-xs btn-success pull-right" data-grab="addControllerBtn">+</button>
							</h3>
						</div>

					</div>
				</div>
			</div>'

class Entity extends classes.Base
	constructor:(data,parent)->
		data = _.extend {model:{},controllers:[],singular:'',plural:''}, data
		@id = @id or _.uniqueId @constructor.name + '_'
		@el = $(_.template(template,this));
		super arguments...
		@model = new classes.Model @model, @

		$(".tab-content").append(@el);
		$(".tab-pane").removeClass "active"
		@el.addClass 'active'

		$('.nav-pills li').removeClass 'active'
		pill = $ _.template pillTemplate, @
		rivets.bind pill,@
		@parent.pills.append pill

		@instanciateChildren children
		@addEventListeners()

	addController:->
		@controllers.push new classes.Controller {},@
		@trigger 'addControllerEvt'


	addEventListeners:->
		self = @
		@addControllerBtn.on 'click',$.proxy @addController,@
		@pluralInput.on 'blur',->
			self.set 'singular', pluralize.singular @value.charAt(0).toLowerCase() + @value.slice(1)
		@singularInput.on 'blur',->
			self.set 'plural', pluralize @value.charAt(0).toUpperCase() + @value.slice(1)

	toJSON:->
		resp = _.pick @, 'plural','singular'
		resp.model = @model.toJSON()
		resp.controllers = _.map @controllers, (c)-> c.toJSON()
		resp

classes.Entity = Entity