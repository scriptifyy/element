local types = require(script.Parent.Parent.types);

return types("color3", function(): (value: any) -> boolean
	return function(value: any): boolean
		return typeof(value) == "Color3";
	end;
end);