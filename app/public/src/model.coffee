children = {
	Property:'properties'
	Method:'methods'
	Hook:'hooks'
}

template = 		'<div class="model">
					<div class="page-header">
						<h3>Model:</h3>
					</div>

					<div class="panel panel-default">
						<div class="panel-heading">
							Props
							<button class="btn pull-right btn-xs btn-success" data-grab="addPropertyBtn">+</button>
						</div>
						<table class="table table-condensed">
							<thead>
								<tr>
									<th></th>
									<th>Key</th>
									<th>Type</th>
									<th>Reference</th>
									<th></th>
								</tr>
							</thead>
							<tbody data-grab="propertiesContainer"></tbody>
						</table>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							Hooks
							<button class="btn btn-xs btn-success pull-right" data-grab="addHookBtn">+</button>
						</div>
						<table class="table table-condensed">
							<thead>
								<tr>
									<th>Type</th>
									<th>Action</th>
									<th>Comment</th>
									<th></th>
								</tr>
							</thead>
							<tbody data-grab="hooksContainer"></tbody>
						</table>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							Methods <small class="pull-right">One per line</small>
							<!--<button class="btn btn-xs pull-right" data-grab="addMethodBtn">+</button>-->
						</div>
						<div class="panel-body">
							<div class="row">
								<div class="col-xs-4"><strong>Statics</strong></div>
								<div class="col-xs-4"><strong>Instance</strong></div>
								<div class="col-xs-4"><strong>Virtuals</strong></div>
							</div>
							<div class="row">
								<div class="col-xs-4"><textarea rv-value="statics | lineToArray" class="form-control"></textarea></div>
								<div class="col-xs-4"><textarea rv-value="instance | lineToArray" class="form-control"></textarea></div>
								<div class="col-xs-4"><textarea rv-value="virtuals | lineToArray" class="form-control"></textarea></div>
							</div>
						</div>
					</div>
				</div>'

class Model extends classes.Base
	constructor:(data,parent)->
		data = _.extend {hooks:[],properties:[],instance:[],statics:[],virtuals:[]}, data
		@el = $(_.template(template,@));
		super arguments...
		@parent.modelContainer.append @el;
		@instanciateChildren children
		@addEventListeners()

	addHook:->
		@hooks.push new classes.Hook {},@

	addProperty:->
		@properties.push new classes.Property {},@

	addEventListeners:->
		self = @
		@addHookBtn.on 'click', $.proxy @addHook,@
		@addPropertyBtn.on 'click', $.proxy @addProperty, @

	toJSON:->
		resp = _.pick @, 'statics','instance','virtuals'
		for type in ['hooks','properties']
			resp[type] = @[type].map (e)-> e.toJSON()
		resp


classes.Model = Model