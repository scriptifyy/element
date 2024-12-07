--[[
	scriptifyy // 2024
	quick utility for unwrapping values that could be sources.
]]--

type can_be_source<T> = T | () -> T;

local function unwrap<T>(value : can_be_source<T>) : T
	if (typeof(value) == "function") then
		return value();
	else
		return value;
	end;
end;

return unwrap;