--[[
	scriptifyy // 2024
	constants that are used in development for testing, debugging etc.
]]--

local runService = game:GetService("RunService");

return {
	IS_DEV = runService:IsStudio();
	IS_STORY = runService:IsStudio() and not runService:IsRunning();
};