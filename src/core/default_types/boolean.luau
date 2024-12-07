local types = require(script.Parent.Parent.types);

return types("boolean", function()
	return function(value)
		return typeof(value) == "boolean";
	end;
end);