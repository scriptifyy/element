local libraries = script.Parent.Parent:WaitForChild("libraries");
local ripple = require(libraries.ripple);
local vide = require(libraries.vide);

local utils = script.Parent.Parent:WaitForChild("utils");
local components = require(utils.components);
local globals = require(utils.globals);
local spring = require(utils.spring);
local theme = require(utils.theme);

local spring_options : ripple.SpringOptions = { damping = 15; frequency = 0.7 };

local pages = vide.source({})
for _, page in (script.Parent.content:GetChildren()) do
	local pages_clone = vide.read(pages);
	local required_page = require(page);

	table.insert(pages_clone, required_page);
	pages(pages_clone);
end;

local content = components.elements.frame({
	name = ("content");

	color = spring(function()
		return theme.get_theme_color("background_color");
	end, spring_options);

	transparency = spring(function()
		return vide.read(globals.active) and 0.7 or 1;
	end, spring_options);
		
	position = UDim2.fromScale(0.5, 0.5);
	size = UDim2.fromScale(1, 0.85);
	order = 3;

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

	vide.indexes(pages, function(page, index)
		return page();
	end);
});

return content;