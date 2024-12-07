--[[
	scriptifyy // 2024
	returns the viewport the ui was designed on and the current users viewport.
]]--

local camera = workspace.CurrentCamera;

local libraries = script.Parent.Parent:FindFirstChild("libraries");
local vide = require(libraries.vide);

local default_viewport_size = Vector2.new(1550, 775);
local current_viewport_size = vide.source(camera.ViewportSize);

vide.mount(function()
	return vide.apply(camera)({
		vide.changed("ViewportSize", function()
			current_viewport_size(camera.ViewportSize);
		end);
	})
end, workspace);

return {
	default_viewport_size = default_viewport_size;
	current_viewport_size = current_viewport_size;	
};