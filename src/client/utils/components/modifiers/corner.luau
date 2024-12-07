local libraries = script.Parent.Parent.Parent.Parent:WaitForChild("libraries");
local vide = require(libraries.vide);

local utils = script.Parent.Parent.Parent.Parent:WaitForChild("utils");
local rest = require(utils.rest);
local spring = require(utils.spring);
local unwrap = require(utils.unwrap);

type can_be_source<T> = T | () -> T;
type properties = {
	radius : can_be_source<number>?;
	
	[number] : any;
};

local function corner(properties : properties) : UICorner
	local corner = vide.create("UICorner")({
		Name = ("corner");
		
		CornerRadius = spring(function()
			return UDim.new(0, unwrap(properties.radius));
		end, { damping = 15; frequency = 0.7 });
		
		rest(properties);
	});

	return corner;
end;

return corner;