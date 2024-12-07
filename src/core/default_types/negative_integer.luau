local types = require(script.Parent.Parent.types);

return types("negative_integer", function(...: number): (value: any) -> boolean
	local options = { ... };
	return function(value: any): boolean
		if (typeof(value) ~= "number" or math.floor(value) ~= value or value >= 0) then
			return false;
		end;

		if (#options > 0) then
			for _, option in ipairs(options) do
				if value == option then
					return true;
				end;
			end;

			return false;
		end;

		return true;
	end;
end);