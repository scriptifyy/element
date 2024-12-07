local players = game:GetService("Players");
local runService = game:GetService("RunService");

local core = script:WaitForChild("core");
local permissions = require(core.permissions);

local libraries = script:WaitForChild("libraries");
local promise = require(libraries.promise);

local default_registered_types = {};
local default_registered_commands = {};
local default_settings = require(script.settings);

local function start(settings : typeof(default_settings()))
	if (not runService:IsServer()) then
		return warn("");
	end;

	if (script:GetAttribute("started")) then
		return warn("");
	end;
	
	for rank, user_id in pairs(settings.permissions) do
		if (typeof(user_id) ~= "number") then
			return warn("");
		end

		if (typeof(rank) ~= "number" or rank < 0 or rank > 255) then
			return warn("");
		end;
	end;

	if (settings.group_id ~= 0) then
		local group_exists = game:GetService("GroupService"):GetGroupInfoAsync(settings.group_id);
		if (not group_exists) then
			return warn("");
		end;
	end;

	default_settings(settings);

	promise.new(function(resolve, reject)
		for type_name, type_module in ipairs(core.default_types:GetChildren()) do
			require(type_module);
		end;

		if (#default_registered_types == #core.default_types:GetChildren()) then
			resolve(default_registered_types);
		else
			reject("");	
		end;
	end):andThen(function()
		return promise.new(function(resolve, reject)
			for command_name, command_module in ipairs(core.default_commands:GetChildren()) do
				require(command_module);
			end;
	
			if (#default_registered_commands == #core.default_commands:GetChildren()) then
				resolve(default_registered_commands);
			else
				reject("");	
			end;
		end); 
	end):catch(warn);

	for _, player: Player in players:GetPlayers() do
		if (permissions(player)) ~= 0 then
			local client_interface = script:WaitForChild("client"):Clone();
			client_interface.Parent = player:WaitForChild("PlayerGui");
		end;
	end;

	players.PlayerAdded:Connect(function(player: Player)
		if (permissions(player)) ~= 0 then
			local client_interface = script:WaitForChild("client"):Clone();
			client_interface.Parent = player:WaitForChild("PlayerGui");
		end;
	end);

	return print("✨ // successfully started element.");
end;

return {
	start = start;
	default_registered_types = default_registered_types;
	default_registered_commands = default_registered_commands;
	default_settings = default_settings;
};
