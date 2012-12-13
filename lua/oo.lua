-- Simple object system.
-- Implements inheritance, new(), and :super()

oo = {}

function oo.newClass()
	local class = {}
	local class_mt = {__index = class}
	
	function class.new()
		local inst = {}
		setmetatable(inst, class_mt)
		return inst
	end
	
	return class
end

function oo.inherits(baseClass)
	local newclass = {}
	local class_mt = {__index = newclass}
	
	function newclass.new()
		local inst = {}
		setmetatable(inst, class_mt)
		return inst
	end


	function newclass:super()
		return baseClass
	end

	
	if baseClass then
		setmetatable(newclass, {__index = baseClass})
	end
	
	return newclass
end
