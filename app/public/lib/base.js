// Generated by CoffeeScript 1.6.3
(function() {
  var Base;

  Base = (function() {
    function Base(data, parent) {
      var k, v;
      for (k in data) {
        v = data[k];
        this[k] = v;
      }
      this.id = this.id || _.uniqueId(this.constructor.name + '_');
      if (parent != null) {
        this.parent = parent;
      }
      this.setupEls();
      this.render();
    }

    Base.prototype.render = function() {
      this.el.data('obj', this);
      return rivets.bind(this.el, this);
    };

    Base.prototype.on = function(evt, fn) {
      $(this).on(evt, fn);
      return this;
    };

    Base.prototype.trigger = function(evt) {
      $(this).trigger(evt);
      return this;
    };

    Base.prototype.set = function(prop, val) {
      this[prop] = val;
      this.trigger('change:' + prop);
      return this;
    };

    Base.prototype.has = function(prop) {
      return this[prop] != null;
    };

    Base.prototype.remove = function() {
      var self, word;
      if (confirm('rly?')) {
        self = this;
        if (this.el) {
          this.el.hide(250, function() {
            return self.el.remove();
          });
        }
        word = words[this.constructor.name.toLowerCase()];
        return this.parent[word] = _.filter(this.parent[word], function(el) {
          return el.id !== self.id;
        });
      }
    };

    Base.prototype.setupEls = function() {
      var grabEl, k, selector, _i, _len, _ref, _ref1;
      if (this.el) {
        _ref = this.el.find('[data-grab]');
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          grabEl = _ref[_i];
          grabEl = $(grabEl);
          this[grabEl.attr('data-grab')] = grabEl;
        }
        if (this.els) {
          _ref1 = this.els;
          for (k in _ref1) {
            selector = _ref1[k];
            this[k] = this.el.find(selector);
          }
        }
      }
      return this;
    };

    Base.prototype.instanciateChildren = function(children) {
      var list, self, _class, _i, _len;
      self = this;
      if (children != null) {
        for (list = _i = 0, _len = children.length; _i < _len; list = ++_i) {
          _class = children[list];
          this[list] = this[list] || [];
          if (this[list].length !== 0) {
            this[list] = this[list].map(function(item) {
              return typeof classes[_class] === "function" ? new classes[_class](item, self) : void 0;
            });
          }
        }
      }
      return this;
    };

    return Base;

  })();

  classes.Base = Base;

}).call(this);
