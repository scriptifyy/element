local userInputService = game:GetService("UserInputService");

local players = game:GetService("Players");
local client = players.LocalPlayer;

local libraries = script:WaitForChild("libraries");
local ripple = require(libraries.ripple);
local vide = require(libraries.vide);

local utils = script:WaitForChild("utils");
local globals = require(utils.globals);
local selection = require(utils.selection);
local spring = require(utils.spring);

local spring_options : ripple.SpringOptions = { damping = 15; frequency = 0.7 };

script.AncestryChanged:Connect(function(_, parent : Instance?)
	if (parent and typeof(parent.Parent) == "Player") then
		vide.mount(function() 
			local interface = vide.create("ScreenGui")({
				Name = ("element");
				IgnoreGuiInset = true;
		
				require(script.app)();
			});
		
			local blur = vide.create("BlurEffect")({
				Name = ("element_blur");
				Parent = game:GetService("Lighting");
		
				Size = spring(function()
					return vide.read(globals.active) and 15 or 0
				end, spring_options);
			});
		
			local input_connection = userInputService.InputBegan:Connect(function(input, game_processed)
				if (game_processed) then return end;
		
				local first_keybind = vide.read(globals.keybinds)[1];
				local second_keybind = vide.read(globals.keybinds)[2];
		
				if (input.KeyCode == first_keybind and userInputService:IsKeyDown(second_keybind) 
					or input.KeyCode == second_keybind and userInputService:IsKeyDown(first_keybind)) then
					globals.active(not vide.read(globals.active));
					selection.selecting(not vide.read(selection.selecting));
				end;
			end);
		
			vide.cleanup(function()
				interface:Destroy();
				blur:Destroy();
		
				input_connection:Disconnect();
				input_connection = nil;
			end);
		
			return interface;
		end, client:WaitForChild("PlayerGui"));
	end;
end);