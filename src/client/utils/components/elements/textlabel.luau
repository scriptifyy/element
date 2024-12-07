local libraries = script.Parent.Parent.Parent.Parent:WaitForChild("libraries");
local vide = require(libraries.vide);

local utils = script.Parent.Parent.Parent.Parent:WaitForChild("utils");
local rest = require(utils.rest);
local theme = require(utils.theme);
local unwrap = require(utils.unwrap);

type can_be_source<T> = T | () -> T;
type properties = {
	name : can_be_source<string>?;
	anchor_point : can_be_source<Vector2>?;
	weight : can_be_source<Enum.FontWeight>?;
	position : can_be_source<UDim2>?;
	size : can_be_source<UDim2>?;
	text : can_be_source<string>?;
	color : can_be_source<Color3>?;
	text_size : can_be_source<number>?;
	transparency : can_be_source<number>?;
	scaled : can_be_source<boolean>?;
	wrapped : can_be_source<boolean>?;
	alignment : can_be_source<Enum.TextXAlignment>?;

	[number] : any;
};

local function textlabel(properties : properties)
	local textlabel = vide.create("TextLabel")({
		Name = properties.name or ("textlabel");
		AnchorPoint = properties.anchor_point or Vector2.new(0.5, 0.5);
		BackgroundTransparency = 1;
		FontFace = Font.fromName("Montserrat", unwrap(properties.weight), Enum.FontStyle.Normal);
		Position = properties.position or UDim2.fromScale(0.5, 0.5);
		Size = properties.size or UDim2.fromScale(0.5, 0.5);
		Text = properties.text or ("The quick brown fox jumps over the lazy dog");
		TextColor3 = properties.color or theme.get_theme_color("text_color");
		TextSize = properties.text_size or 15;
		TextTransparency = properties.transparency or 0;
		TextScaled = properties.scaled or true;
		TextWrapped = properties.wrapped or true;
		TextXAlignment = properties.alignment or Enum.TextXAlignment.Center;

		rest(properties)
	});

	return textlabel;
end;

return textlabel;
