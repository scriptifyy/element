local function get_player_permission(player: Player)
	local settings = require(script.Parent.Parent.settings)();

	if (table.find(settings.permissions, player.UserId)) then
		for rank, user_id in (settings.permissions) do
			if (user_id == player.UserId) then
				return rank;
			end;
		end;
	end;

	local group_rank = player:GetRankInGroup(settings.group_id)
	if (group_rank) then
		return group_rank;
	end;

	return 0;
end;

return get_player_permission;