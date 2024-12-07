local libraries = script.Parent.Parent.Parent.Parent:WaitForChild("libraries");
local vide = require(libraries.vide);

local utils = script.Parent.Parent.Parent.Parent:WaitForChild("utils");
local rest = require(utils.rest);
local unwrap = require(utils.unwrap);
local spring = require(utils.spring);

type can_be_source<T> = T | () -> T;
type properties = {
	padding : can_be_source<number>?;

	fill_direction : can_be_source<Enum.FillDirection>?;
	sort_order : can_be_source<Enum.SortOrder>?;
	wraps : can_be_source<boolean>?;

	horizontal_alignment : can_be_source<Enum.HorizontalAlignment>?;
	vertical_alignment : can_be_source<Enum.HorizontalAlignment>?;

	[number] : any;
};

local function list(properties : properties) : UIListLayout
	local list = vide.create("UIListLayout")({
		Name = ("list");

		Padding = spring(function()
			return UDim.new(0, unwrap(properties.padding) or 15);
		end, { damping = 15; frequency = 0.7 });

		FillDirection = properties.fill_direction or Enum.FillDirection.Vertical;
		SortOrder = properties.sort_order or Enum.SortOrder.LayoutOrder;
		Wraps = properties.wraps or true;

		HorizontalAlignment = properties.horizontal_alignment or Enum.HorizontalAlignment.Center;
		VerticalAlignment = properties.vertical_alignment or Enum.VerticalAlignment.Top;

		rest(properties);
	});

	return list;
end;

return list;
