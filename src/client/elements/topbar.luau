local libraries = script.Parent.Parent:WaitForChild("libraries");
local ripple = require(libraries.ripple);
local vide = require(libraries.vide);

local utils = script.Parent.Parent:WaitForChild("utils");
local components = require(utils.components);
local globals = require(utils.globals);
local spring = require(utils.spring);
local theme = require(utils.theme);

local spring_options : ripple.SpringOptions = { damping = 15; frequency = 0.7 };

local topbar = components.elements.frame({
	name = ("topbar");
	
	color = spring(function()
		return theme.get_theme_color("background_color");
	end, spring_options);
	
	transparency = spring(function()
		return vide.read(globals.active) and 0.7 or 1;
	end, spring_options);
	
	position = UDim2.fromScale(0.5, 0.5);
	size = UDim2.fromScale(1, 0.09);
	order = 2;
	
	components.modifiers.corner({
		radius = 15;
	});
	
	components.modifiers.gradient({
		rotation = 90;
		transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0.5),
			NumberSequenceKeypoint.new(0.5, 0.65),
			NumberSequenceKeypoint.new(1, 0.5),
		});
	});
	
	components.modifiers.stroke({
		color = spring(function()
			return theme.get_theme_color("stroke_color");
		end, spring_options);
		
		thickness = 1;

		transparency = spring(function()
			return vide.read(globals.active) and 0.7 or 1;
		end, spring_options);
	});

	components.elements.textlabel({
		name = ("title");
		weight = Enum.FontWeight.SemiBold;
		position = UDim2.fromScale(0.5, 0.5);
		size = UDim2.fromOffset(200, 20);
		text = ("element");

		color = spring(function()
			return theme.get_theme_color("text_color");
		end, spring_options);

		transparency = spring(function()
			return vide.read(globals.active) and 0.3 or 1;	
		end, spring_options);

		scaled = true;
		wrapped = true;
		alignment = Enum.TextXAlignment.Center;
	});
});

return topbar;