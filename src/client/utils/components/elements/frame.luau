local libraries = script.Parent.Parent.Parent.Parent:WaitForChild("libraries");
local vide = require(libraries.vide);

local utils = script.Parent.Parent.Parent.Parent:WaitForChild("utils");
local rest = require(utils.rest);
local theme = require(utils.theme);

type can_be_source<T> = T | () -> T;
type properties = {
	name : can_be_source<string>?;
	anchor_point : can_be_source<Vector2>?;
	color : can_be_source<Color3>?;
	transparency : can_be_source<number>?;
	clip_descendants : can_be_source<boolean>?;
	position : can_be_source<UDim2>?;
	size : can_be_source<UDim2>?;
	order : can_be_source<number>?;
	
	[number] : any;
};

local function frame(properties : properties) : Frame
	local frame = vide.create("Frame")({
		Name = properties.name or "frame";
		AnchorPoint = properties.anchor_point or Vector2.new(0.5, 0.5);
		BackgroundColor3 = properties.color or theme.get_theme_color("text_color");
		BackgroundTransparency = properties.transparency or 1;
		ClipsDescendants = properties.clip_descendants or false;
		Position = properties.position or UDim2.fromScale(0.5, 0.5);
		Size = properties.size or UDim2.fromScale(0.5, 0.5);
		LayoutOrder = properties.order or 1;
		ZIndex = properties.order or 1;
		
		rest(properties);
	});
	
	return frame;
end;

return frame;