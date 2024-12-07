--[[
	scriptifyy // 2024
	a table of sources that are used mainly for settings.
]]--

local libraries = script.Parent.Parent:FindFirstChild("libraries");
local vide = require(libraries.vide);

type global_types = {
	active : vide.Source<boolean>;
	keybinds : vide.Source<{Enum.KeyCode}>?;
	pattern_direction : vide.Source<"top_left_to_bottom_right" | "top_right_to_bottom_left" | "bottom_right_to_top_left" | "bottom_left_to_top_right" | "top_to_bottom" | "bottom_to_top">?;
	overlay_pattern : vide.Source<string>;
	overlay_image : vide.Source<string>;
};

local default = {
	active = false;
	keybinds = {
		Enum.KeyCode.LeftAlt;
		Enum.KeyCode.E;
	};

	pattern_direction = ("top_to_bottom");
	overlay_pattern = ("rbxassetid://2151781758");
	overlay_image = ("rbxassetid://0"); --// in-dev: 135628242996711
};

local globals : global_types = {
	active = vide.source(default.active);
	keybinds = vide.source(default.keybinds);

	pattern_direction = vide.source(default.pattern_direction);
	overlay_pattern = vide.source(default.overlay_pattern);

	overlay_image = vide.source(default.overlay_image);
};

return globals;