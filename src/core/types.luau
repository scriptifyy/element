export type type_structure = () -> (value: any) -> boolean;
export type registered_types = {[string]: type_structure};

local registered_types = {};

local function create_type(type_name: string, type_data: type_structure)
	if (not type_name or typeof(type_name) ~= "string") then
        return warn("");
    end;

	if (not type_data or typeof(type_data) ~= "function") then
		return warn("");
	end;

	registered_types[type_name] = type_data;
	return registered_types[type_name];
end;

return setmetatable(registered_types, {
	__index = function(_, type_name: string): type_structure
		return registered_types[type_name] or warn(`could not find the { type_name } type.`);
	end;

	__call = function(_, name: string, type_data: type_structure)
		return create_type(name, type_data);
	end;
});