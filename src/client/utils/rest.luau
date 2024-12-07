--[[
	scriptifyy // 2024
	quick utility for unpacking properties for components.
]]--

return function(properties: {[any] : any}) : {[number] : any}
	return { table.unpack(properties) };
end;