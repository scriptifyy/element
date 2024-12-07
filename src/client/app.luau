local libraries = script.Parent:WaitForChild("libraries");
local ripple = require(libraries.ripple);
local vide = require(libraries.vide);

local utils = script.Parent:WaitForChild("utils");
local components = require(utils.components);
local constants = require(utils.constants);
local globals = require(utils.globals);
local spring = require(utils.spring);
local theme = require(utils.theme);

local spring_options : ripple.SpringOptions = { damping = 15; frequency = 0.7 };
vide.strict = constants.IS_DEV;

local elements = vide.source({});
for _, element in (script.Parent.elements:GetChildren()) do
	local elements_clone = vide.read(elements);
	local required_element = require(element);

	table.insert(elements_clone, required_element);
	elements(elements_clone);
end;

local function create_app()
	local app = vide.create("ImageLabel")({
		Name = ("panel");
		AnchorPoint = Vector2.new(0.5, 0.5);

		BackgroundColor3 = spring(function()
			return theme.get_theme_color("background_color");
		end, spring_options);

		BackgroundTransparency = spring(function()
			return vide.read(globals.active) and 0 or 1;
		end, spring_options);

		Position = UDim2.fromScale(0.5, 0.5);
		Size = UDim2.fromOffset(400, 400);
	
		Image = function()
			return vide.read(globals.overlay_image);
		end;
	
		ImageTransparency = spring(function()
			return vide.read(globals.active) and 0.85 or 1;
		end, spring_options);
	
		ScaleType = Enum.ScaleType.Crop;

		components.modifiers.corner({
			radius = 20;
		});
		
		components.modifiers.gradient({
			rotation = 90;
			transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0.5),
				NumberSequenceKeypoint.new(0.5, 0.65),
				NumberSequenceKeypoint.new(1, 0.5),
			});
		});

		components.modifiers.list({
			padding = 15;

			fill_direction = Enum.FillDirection.Vertical;
			sort_order = Enum.SortOrder.LayoutOrder;
			wraps = false;

			horizontal_alignment = Enum.HorizontalAlignment.Center;
			vertical_alignment = Enum.VerticalAlignment.Center;
		});

		components.modifiers.padding({
			bottom = 15;
			left = 20;
			right = 20;
			top = 15;
		});
		
		components.modifiers.scale({
			scale = function()
				return vide.read(globals.active) and 1 or 1.25;
			end;
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
		
		vide.indexes(elements, function(element, index)
			return element();
		end);
	});

	if (constants.IS_STORY) then
		globals.active(true);
	end;

	return app;
end;

return create_app;
