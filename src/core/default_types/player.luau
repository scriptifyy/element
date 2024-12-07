local types = require(script.Parent.Parent.types);

return types("player", function(): (value: any) -> boolean
	return function(value: any): boolean
		if (typeof(value) == "table") then
			for _, player in ipairs(value) do
				if (typeof(player) ~= "Instance" or not player:IsA("Player")) then
					return false;
				end;
			end;
	
			return true;
		end;
	
		return false;
	end;
end);
