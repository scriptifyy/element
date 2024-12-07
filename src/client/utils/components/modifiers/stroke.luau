local libraries = script.Parent.Parent.Parent.Parent:WaitForChild("libraries");
local vide = require(libraries.vide);

local utils = script.Parent.Parent.Parent.Parent:WaitForChild("utils");
local rest = require(utils.rest);
local theme = require(utils.theme);

type can_be_source<T> = T | () -> T;
type properties = {
	color : can_be_source<Color3>?;
	thickness : can_be_source<number>?;
	transparency : can_be_source<number>?;

	[number] : any;
};

local function stroke(properties : properties) : UIStroke
	local stroke = vide.create("UIStroke")({
		Name = ("stroke");
		Color = properties.color or theme.get_theme_color("stroke_color");
		Thickness = properties.thickness or 1;
		Transparency = properties.transparency or 0;

		rest(properties);
	});

	return stroke;
end;

return stroke;