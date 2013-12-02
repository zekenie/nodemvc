template = '<div class="controller panel panel-default">
			<span data-grab="closeEl" class="mclose pull-left">
				<span class="glyphicon glyphicon-remove"></span>
			</span>

				<div class="panel-heading">
					<input autofocus rv-input="name | codeSafe" placeholder="controller fn name" class="controller-name" type="text">
						<div class="btn-group btn-group-xs pull-right" data-toggle="buttons">
							<label class="btn btn-primary">
								<input type="radio" rv-checked="res" value="json"> JSON
							</label>
							<label class="btn btn-primary">
								<input type="radio" rv-checked="res" value="html"> HTML
							</label>
						</div>
				</div>
				<div class="panel-body">
					<div class="row">
						<div data-grab="routeContainer" class="col-xs-12">
							<input data-grab="routeInput" rv-input="route | codeSafe" placeholder="Route eg /<%=parent.plural.toLowerCase()%>/..." class="form-control controller-route" type="text">
						</div>
						<div data-grab="viewContainer" class="col-xs-6">
							<input rv-input="view | codeSafe" placeholder="view" class="form-control" data-grab="viewInput">
						</div>
					</div>
				</div>
				<div class="btn-group methodSelect" data-toggle="buttons">
					<label class="btn btn-primary">
						<input type="radio" rv-checked="method" value="get"> GET
					</label>
					<label class="btn btn-primary">
						<input type="radio" rv-checked="method" value="post"> POST
					</label>
					<label class="btn btn-primary">
						<input type="radio" rv-checked="method" value="put"> PUT
					</label>
					<label class="btn btn-primary">
						<input type="radio" rv-checked="method" value="del"> DEL
					</label>
				</div>'

class Controller extends classes.Base
	constructor:(data,parent)->
		data = _.extend {name:'',view:'',method:'',route:'',res:''}, data
		@parent = parent
		@el = $ _.template template, @
		super arguments...
		@parent.controllersContainer.append @el
		@render()
		@addEventListeners()

	showView:->
		@routeContainer.removeClass('col-xs-12').addClass 'col-xs-6'
		@viewContainer.show();

	hideView:->
		@routeContainer.addClass('col-xs-12').removeClass 'col-xs-6'
		@viewContainer.hide();

	addEventListeners:->
		self = @
		@closeEl.on 'click',->
			self.remove()
		@viewContainer.hide()
		@.on 'change:res',->
			if self.res is 'html'
				self.showView()
			else
				self.hideView()

	toJSON:->
		_.pick @, 'name','view','method','route','res'

classes.Controller = Controller
