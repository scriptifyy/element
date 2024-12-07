--[[
	scriptifyy // 2024
	creates a ripple motion with the @littensys/ripple library.
]]--

local runService = game:GetService("RunService");

local libraries = script.Parent.Parent:WaitForChild("libraries");
local ripple = require(libraries.ripple);
local vide = require(libraries.vide);

local function motion(initial : ripple.MotionGoal, options : ripple.SpringOptions?)
	local motion = ripple.createMotion(initial);
	local motion_value = vide.source(initial);
	
	local heartbeat = runService.Heartbeat:Connect(function(delta)
		local value = motion:step(delta);
		if (value ~= vide.read(motion_value)) then
			motion_value(value);
		end;
	end);
	
	vide.effect(function()
		motion:spring(initial, options);
	end);
		
	vide.cleanup(function()
		heartbeat:Disconnect();
		heartbeat = nil;
	end);
	
	return motion_value, motion;
end;

return motion;
