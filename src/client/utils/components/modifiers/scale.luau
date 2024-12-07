local libraries = script.Parent.Parent.Parent.Parent:WaitForChild("libraries");
local vide = require(libraries.vide);

local utils = script.Parent.Parent.Parent.Parent:WaitForChild("utils");
local constants = require(utils.constants);
local rest = require(utils.rest);
local unwrap = require(utils.unwrap);
local spring = require(utils.spring);
local viewport = require(utils.viewport);

type can_be_source<T> = T | () -> T;
type properties = {
	scale : can_be_source<number>?;

	[number] : any;
};

local function average(vector : Vector2) : number
	return vector:Dot(Vector2.new(1, 1)) / 2;
end;

local function scale(properties : properties) : UIScale
	local scale = vide.create("UIScale")({
		Name = ("scale");

		Scale = spring(function()
			local averageDefaultViewportSize = average(viewport.default_viewport_size);
			local averageCurrentViewportSize = average(viewport.current_viewport_size());

			local factor = (averageDefaultViewportSize / averageCurrentViewportSize);
			local number = unwrap(properties.scale);

			return constants.IS_STORY and number or number / factor;
		end, { damping = 15; frequency = 0.7 });

		rest(properties);
	});

	return scale;	
end;

return scale;