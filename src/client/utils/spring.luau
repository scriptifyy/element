--[[
	scriptifyy // 2024
	creates a ripple spring using the @littensy/ripple library.
]]--

local libraries = script.Parent.Parent:WaitForChild("libraries");
local ripple = require(libraries.ripple);
local vide = require(libraries.vide);

local motion = require(script.Parent.motion);

local function spring(source, spring_options : ripple.SpringOptions)
	local current_value, motion = motion(vide.read(source), spring_options);
	
	vide.effect(function()
		if (vide.read(source) ~= motion:get()) then 
			motion:spring(vide.read(source));
		end;
	end)
	
	return current_value, motion;
end;

return spring;