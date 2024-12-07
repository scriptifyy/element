local elements = script.elements;
local modifiers = script.modifiers;

local components = {	
	elements = {
		frame = require(elements.frame);
		textlabel = require(elements.textlabel);
	};
	
	modifiers = {
		corner = require(modifiers.corner);
		gradient = require(modifiers.gradient);
		list = require(modifiers.list);
		padding = require(modifiers.padding);
		scale = require(modifiers.scale);
		stroke = require(modifiers.stroke);
	};

};

return components;