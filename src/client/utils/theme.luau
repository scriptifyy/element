--[[
	scriptifyy // 2024
	a basic theming system.
]]--

local libraries = script.Parent.Parent:WaitForChild("libraries");
local vide = require(libraries.vide);

local current_theme = vide.source("light")
local themes = {
    dark = {
        background_color = Color3.fromRGB(25, 25, 25);
        stroke_color = Color3.fromRGB(75, 75, 75);
        text_color = Color3.fromRGB(255, 255, 255);
    };

    light = {
        background_color = Color3.fromRGB(225, 225, 225);
        stroke_color = Color3.fromRGB(150, 150, 150);
        text_color = Color3.fromRGB(25, 25, 25);
    };
};

type theme_properties = "background_color" | "stroke_color" | "text_color";

local function change_theme(theme_name : string)
    assert(themes[theme_name], ("the given theme_name [%s] does not exist"):format(theme_name));
    current_theme(theme_name);
end;

local function get_theme_color(property : theme_properties)
    assert(themes[vide.read(current_theme)], ("the given theme_name [%s] does not exist"):format(vide.read(current_theme)));
    assert(themes[vide.read(current_theme)][property], ("the given property [%s] does not exist"):format(property));

    return themes[vide.read(current_theme)][property];
end;

game:GetService("UserInputService").InputBegan:Connect(function(input, game_processed)
    if (game_processed) then return end;

    if (input.KeyCode == Enum.KeyCode.RightAlt) then
        change_theme(vide.read(current_theme) == "dark" and "light" or "dark")
    end;
end);

return {
    current_theme = current_theme;
    change_theme = change_theme;
    get_theme_color = get_theme_color;
};
