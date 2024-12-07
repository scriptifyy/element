local vide = require(script.Parent:WaitForChild("libraries").vide);

local utils = script.Parent:WaitForChild("utils");
local globals = require(utils.globals);

local story = {
	vide = vide;
	controls = globals;
	story = function(props)
		return require(script.Parent.app)();
	end;
};

return story;