local libraries = script.Parent.Parent.Parent.Parent:WaitForChild("libraries");
local vide = require(libraries.vide);

local utils = script.Parent.Parent.Parent.Parent:WaitForChild("utils");
local rest = require(utils.rest);

type can_be_source<T> = T | () -> T;
type properties = {
	color : can_be_source<ColorSequence>?;
	rotation : can_be_source<number>?;
	transparency : can_be_source<NumberSequence>?;

	[number] : any;
};

local function gradient(properties : properties) : UIGradient
	local gradient = vide.create("UIGradient")({
		Name = ("gradient");
		Color = properties.color or ColorSequence.new(Color3.fromRGB(255, 255, 255));
		Rotation = properties.rotation or 0;
		Transparency = properties.transparency or NumberSequence.new(0);

		rest(properties);
	});

	return gradient;
end;

return gradient;