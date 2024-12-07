local types = require(script.Parent.Parent.types);

return types("enum", function(enum_type)
	return function(value)
		return typeof(value) == "EnumItem" and value.EnumType == enum_type;
	end;
end);