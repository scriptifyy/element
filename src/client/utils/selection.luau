local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService");

local libraries = script.Parent.Parent:WaitForChild("libraries");
local vide = require(libraries.vide);

local spring = require(script.Parent.spring);

local selecting = vide.source(false);
local players = vide.source({});

local hovering = vide.source(false);
local selected = vide.source(false);

local raycast_parameters = RaycastParams.new();
raycast_parameters.FilterType = Enum.RaycastFilterType.Include;

local function quick_manipulation(value : any, manipulation_type, source)
	local unpacked_source = source();
	manipulation_type(unpacked_source, value);
	source(unpacked_source);
end;

for _, player in game:GetService("Players"):GetPlayers() do
	if (player.Character) then
		quick_manipulation(player.Character, table.insert, players)
	end;
end;

game:GetService("Players").PlayerAdded:Connect(function(player: Player)
	player.CharacterAdded:Connect(function(character) quick_manipulation(character, table.insert, players) end);
	player.CharacterRemoving:Connect(function(character) quick_manipulation(character, table.remove, players) end);
end);

vide.apply(runService)({
	RenderStepped = function()
		if (not vide.read(selecting)) then return end;

		if (userInputService:GetLastInputType() == Enum.UserInputType.MouseButton1) then
			if (vide.read(hovering)) then
				selected(not vide.read(selected));
			end;
		end;

		if (userInputService:GetLastInputType() == Enum.UserInputType.MouseMovement) then
			local mouse_position = userInputService:GetMouseLocation();
			local ray = workspace.CurrentCamera:ScreenPointToRay(mouse_position.X, mouse_position.Y);

			raycast_parameters.FilterDescendantsInstances = vide.read(players);
			
			local raycast_result = workspace:Raycast(ray.Origin, ray.Direction * 1000, raycast_parameters);
			local raycast_instance = raycast_result and raycast_result.Instance;
			if (not raycast_instance) then return end;

			print(raycast_instance);
			
			local character = raycast_instance and raycast_instance:FindFirstAncestorOfClass("Model");

			if (character and character:FindFirstChildOfClass("Humanoid") and game:GetService("Players"):GetPlayerFromCharacter(character)) then
				vide.mount(function() 
					return vide.apply(character)({
						vide.create("Highlight")({
							FillTransparency = spring(function()
								return vide.read(selected) and 0.5 or 1;
							end, { damping = 15; frequency = 0.7 });
			
							OutlineTransparency = spring(function()
								return vide.read(hovering) and 0 or 1;
							end, { damping = 15; frequency = 0.7 })
						});
					});
				end)
			end;
		end;
	end;
});

return {
	selecting = selecting;
};