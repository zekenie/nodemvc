class Base
	constructor:(data,parent)->
		for k,v of data
			@[k]=v
		@id = @id or _.uniqueId @constructor.name + '_'
		@parent = parent if parent?
		@setupEls()
		@render()

	render:->
		@el.data 'obj', @
		rivets.bind @el,@

	on:(evt,fn)->
		$(@).on(evt,fn)
		@

	trigger:(evt)->
		$(@).trigger(evt);
		@

	set:(prop,val)->
		@[prop]=val
		@trigger 'change:' + prop
		@

	has:(prop)->
		@[prop]?

	remove:->
		if confirm 'rly?'
			self = @
			if @el
				@el.hide 250, -> self.el.remove()
			word = words[@constructor.name.toLowerCase()]
			@parent[word] = _.filter @parent[word], (el)-> el.id isnt self.id

	setupEls:->
		if @el
			for grabEl in @el.find '[data-grab]'
				grabEl = $ grabEl
				@[grabEl.attr 'data-grab'] = grabEl
			if @els
				for k,selector of @els
					@[k] = @el.find selector
		@

	instanciateChildren:(children)->
		self = @
		if children?
			for _class,list in children
				@[list] = @[list] || []
				if @[list].length isnt 0
					@[list] = @[list].map (item)->
						new classes[_class]? item,self
		@

classes.Base = Base
