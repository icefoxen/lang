define([
    // Dependency list
    'dojo/dom',
    'dojo/fx',
    'dojo/domReady!'

], function(dom, fx) {
    // Callback function that is called once this
    // module is done loading.
    var oldText = {};
    // Return an object that is the value of this module
    return {
	setText: function (id, text) {
	    var greeting = dom.byId(id);
	    oldText[id] = greeting.innerHTML;
	    greeting.innerHTML = text;

	    // Everything's better with animation, right?
	    // Doesn't seem to work currently, but, forget it.
	    fx.slideTo({
		node: greeting,
		top: 100,
		left: 200
	    }).play();
	},

	restoreText: function (id) {
	    var node = dom.byId(id);
	    node.innerHTML = oldText[id];
	    delete oldText[id];
	}
    };
});
