define([
    // Dependency list
    'dojo/dom'

], function(dom) {
    // Callback function that is called once this
    // module is done loading.
    var oldText = {};
    // Return an object that is the value of this module
    return {
	setText: function (id, text) {
	    var node = dom.byId(id);
	    oldText[id] = node.innerHTML;
	    node.innerHTML = text;
	},

	restoreText: function (id) {
	    var node = dom.byId(id);
	    node.innerHTML = oldText[id];
	    delete oldText[id];
	}
    };
});
