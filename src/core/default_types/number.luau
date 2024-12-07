local types = require(script.Parent.Parent.types);

return types("number", function(min: number?, max: number?): (value: any) -> boolean
	return function(value: any): boolean
		if (typeof(value) ~= "number") then
			return false;
		end;

		if (min and value < min) then
			return false;
		end;

		if (max and value > max) then
			return false;
		end;

		return true;
	end;
end);
