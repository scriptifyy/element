local libraries = script.Parent.Parent:WaitForChild("libraries");
local vide = require(libraries.vide);

local utils = script.Parent.Parent:WaitForChild("utils");
local components = require(utils.components);
local globals = require(utils.globals);
local motion = require(utils.motion);
local spring = require(utils.spring);
local theme = require(utils.theme);

local position_directions : { [string] : { start : UDim2; finish : UDim2 }} = {
	top_left_to_bottom_right = {
		start = UDim2.fromScale(2.5, 2.5);
		finish = UDim2.fromScale(-1.5, -1.5);
	};

	top_right_to_bottom_left = {
		start = UDim2.fromScale(-1.5, 2.5);
		finish = UDim2.fromScale(2.5, -1.5);
	};

	bottom_right_to_top_left = {
		start = UDim2.fromScale(-1.5, -1.5);
		finish = UDim2.fromScale(2.5, 2.5);
	};

	bottom_left_to_top_right = {
		start = UDim2.fromScale(2.5, -1.5);
		finish = UDim2.fromScale(-1.5, 2.5);
	};

	top_to_bottom = {
		start = UDim2.fromScale(2.5, 0.5);
		finish = UDim2.fromScale(2.5, -1.5);
	};

	bottom_to_top = {
		start = UDim2.fromScale(2.5, -1.5);
		finish = UDim2.fromScale(2.5, 0.5);
	};
};

local current_position, position = motion(position_directions[vide.read(globals.pattern_direction)].start);
position:linear(position_directions[vide.read(globals.pattern_direction)].finish, 0.05);

position:onComplete(function()
	position:immediate(position_directions[vide.read(globals.pattern_direction)].start);
	position:linear(position_directions[vide.read(globals.pattern_direction)].finish, 0.05);
end);

vide.effect(function()
	if (position:get() ~= position_directions[vide.read(globals.pattern_direction)].finish) then
		position:immediate(position_directions[vide.read(globals.pattern_direction)].start);
		position:linear(position_directions[vide.read(globals.pattern_direction)].finish);
	end;
end);

local overlay = vide.create("Folder")({
	Name = ("overrided_instances");

	vide.create("CanvasGroup")({
		Name = ("overlay");
		AnchorPoint = Vector2.new(0.5, 0.5);
		BackgroundTransparency = 1;
		Position = UDim2.fromScale(0.5, 0.5);
		Size = UDim2.fromScale(1, 1);
	
		components.modifiers.gradient({
			rotation = 90;
			transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(0.075, 1),
				NumberSequenceKeypoint.new(0.15, 0),
				NumberSequenceKeypoint.new(1, 0),
			});
		});
	
		vide.create("ImageLabel")({
			Name = ("pattern");
			AnchorPoint = Vector2.new(0.5, 0.5);
			BackgroundTransparency = 1;
			Position = current_position;
			Size = UDim2.fromScale(5, 5);
		
			Image = function()
				return vide.read(globals.overlay_pattern);
			end;
	
			ImageColor3 = spring(function()
				return theme.get_theme_color("text_color");
			end, { damping = 15; frequency = 0.7 });
	
			ImageTransparency = spring(function()
				return vide.read(globals.active) and 0.95 or 1;
			end, { damping = 15; frequency = 0.7 });
			
			ScaleType = Enum.ScaleType.Tile;
			TileSize =  UDim2.fromOffset(35, 70);
		});
	});
});
	
return overlay;