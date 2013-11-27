children = {
	'Entity':'entities'
}


template = 	'<div id="header">
				<button data-grab="addEntityBtn" class=" btn btn-success">Add Entity</button>
				<button class="btn btn-warning" data-toggle="modal" data-target="#dependencies">Dependencies</button>
				<button data-grab="downloadBtn" class=" btn btn-danger">Download</button>
				<ul data-grab="pills" class="nav pull-right nav-pills"></ul>
			</div>

			<div class="modal fade" id="dependencies">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
							<h4 class="modal-title">Dependencies</h4>
						</div>
						<div class="modal-body" data-grab="dependencyContainer">
							<input type="text" autofocus placeholder="Search bower/npm..." class="typeahead form-control" data-grab="typeahead">
							<br/><br/>
							<i>One per line</i>
							<br/><br/>
							<div class="row">
								<div class="col-sm-6">
									<p>NPM</p>
									<textarea rv-value="npm | lineToArray" class="form-control"></textarea>
								</div>
								<div class="col-sm-6">
									<p>Bower</p>
									<textarea rv-value="bower | lineToArray" class="form-control"></textarea>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
			<div class="tab-content">

			</div>'

class Project extends classes.Base
	constructor:(data,parent)->
		data = _.extend {
			name:'myProject'
			entities:[],
			bower:[],
			npm:[
				"express"
			    "express-train"
			    "express-hbs"
			    "coffee-script"
			    "mongoose"
			]
			},data
		@el = $(_.template(template,@));
		super arguments...
		$("#main").append(@el);
		@instanciateChildren children
		@addEventListeners()

	addEntity:->
		index = @entities.push new classes.Entity {},@
		@trigger 'addEntityEvt'

	toJSON:->
		_.map @entities,(entity)-> entity.toJSON()

	download:->
		prj = @toJSON()
		zip = new JSZip();
		zip.file 'bower.json', new EJS({url:'./templates/bower.ejs'}).render @bower
		zip.file 'package.json', new EJS({url:'./templates/package.ejs'}).render @npm
		zip.file 'lib/routes.coffee', new EJS({url:'./templates/routes.ejs'}).render prj
		for entity in prj
			zip.file "models/#{entity.plural}.coffee", new EJS({url:'./templates/model.ejs'}).render entity
			zip.file "controllers/#{entity.plural}Controller.coffee", new EJS({url:'./templates/controller.ejs'}).render entity
		location.href = 'data:application/zip;base64,' + zip.generate()

	addDependency:(type,dep)->
		@[type].push dep
		@set type,@[type]

	addEventListeners:->
		self = @
		@addEntityBtn.on 'click',$.proxy @addEntity,@
		@downloadBtn.on 'click',$.proxy @download,@
		@typeahead.typeahead [
			{
				name:'bower'
				prefetch:'http://bower-component-list.herokuapp.com/'
				valueKey:'name',
				engine:Hogan
				header: '<h3 class="dep-type">Bower</h3>'
			},
			{
				name:'npm'
				remote:'/npmSearch?q=%QUERY'
				header: '<h3 class="dep-type">NPM</h3>'
				limit:35
			}
		]
		@typeahead.on 'typeahead:selected',(e,selected,type)->
			self.addDependency type, selected.value || selected.name
			@.value = ''


classes.Project = Project