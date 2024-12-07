local command = require(script.Parent.Parent.commands);

return command("kick", {
	aliases = {};
	context = ("server");
	permission_level = 5;
	arguments = {
		{
			name = "target";
			description = ("the players you would like to kick");
			type = command.types.player;
		};
	};

	on_execution = function(executor: Player, arguments)
		for _, player: Player in (arguments.target) do
			if (player:IsA("Player")) then
				player:Kick(arguments.reason);
			end;
		end
	end;
});