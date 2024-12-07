local libraries = script.Parent.Parent.Parent.Parent:WaitForChild("libraries");
local ripple = require(libraries.ripple);
local vide = require(libraries.vide);

local utils = script.Parent.Parent.Parent.Parent:WaitForChild("utils");
local rest = require(utils.rest);
local unwrap = require(utils.unwrap);
local spring = require(utils.spring);

local spring_options : ripple.SpringOptions = { damping = 15; frequency = 0.7 };

type can_be_source<T> = T | () -> T;
type properties = {
	bottom : can_be_source<number>?;
	left : can_be_source<number>?;
	right : can_be_source<number>?;
	top : can_be_source<number>?;

	[number] : any;
};

local function padding(properties : properties) : UIPadding
	local padding = vide.create("UIPadding")({
		Name = ("padding");

		PaddingBottom = spring(function()
			return UDim.new(0, unwrap(properties.bottom) or 15);
		end, spring_options);

		PaddingLeft = spring(function()
			return UDim.new(0, unwrap(properties.left) or 15);
		end, spring_options);

		PaddingRight = spring(function()
			return UDim.new(0, unwrap(properties.right) or 15);
		end, spring_options);

		PaddingTop = spring(function()
			return UDim.new(0, unwrap(properties.top) or 15);
		end, spring_options);

		rest(properties);
	});

	return padding;
end;

return padding;
