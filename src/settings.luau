local libraries = script.Parent:FindFirstChild("libraries");
local charm = require(libraries.charm);

local default_settings = charm.atom({
	permissions = {
		[255] = game.CreatorId;
	};

	group_id = 0;
});

return default_settings;