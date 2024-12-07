export type argument_structure = {
    name: string;
    description: string;
    type: (value: any) -> boolean;
    value: any?;
} ;

export type command_structure = {
    aliases: { string? };
	context: "server" | "client";
	permission_level: number;
	arguments: { argument_structure };
	on_execution: (executor: Player, extra_data: { any }) -> ();
};

export type command = {
    registered_commands: { 
        [string]: typeof(setmetatable({} :: command_structure, {} :: {
             __call: (executor: Player, extra_data: { any }) -> (); 
        }));
    };

    registered_default_commands: { 
        [string]: typeof(setmetatable({} :: command_structure, {} :: {
            __call: (executor: Player, extra_data: { any }) -> (); 
        }));
    };
};

local command: command  = {
   registered_commands = {};
   registered_default_commands = {};
};

local permissions = require(script.Parent.permissions);

local function create_command(command_name: string, command_data: command_structure)
    if (not command_name or typeof(command_name) ~= "string") then
        return warn("command name must be a non-empty string. ensure you are passing a valid name.");
    end;

    if (command.registered_commands[command_name]) then
        return warn(`command '{ command_name }' is already registered.`);
    end;

    if (not command_data or typeof(command_data) ~= "table") then
        return warn("the command data must be a valid table.");
    end;

    if (typeof(command_data.aliases) ~= "table") then
        return warn("'aliases' must be a table of strings.");
    end;

    for _, alias in ipairs(command_data.aliases) do
        if (alias and typeof(alias) ~= "string") then
            return warn("each alias must be a valid string.");
        end;
    end;

    if (not command_data.context or typeof(command_data.context) ~= "string") then
        return warn("unable to identify the context to run the command. ensure 'context' is either 'server' or 'client'.");
    end;

    local valid_contexts = { server = true, client = true };
    if (not command_data.context or not valid_contexts[command_data.context]) then
        return warn("context must be either 'server' or 'client'.");
    end;

    if (not command_data.permission_level or typeof(command_data.permission_level) ~= "number" or command_data.permission_level < 0 or command_data.permission_level > 255) then
        return warn("permission level must be a number between 0 and 255.");
    end;

    if (not command_data.on_execution or typeof(command_data.on_execution) ~= "function") then
        return warn("unable to find the 'on_execution' function. make sure the command has a valid execution handler.");
    end;

    if (not command_data.arguments or typeof(command_data.arguments) ~= "table") then
        return warn("the 'arguments' must be an array.");
    end;

    for index: number, argument: argument_structure in ipairs(command_data.arguments) do
        if (typeof(argument.name) ~= "string" or argument.name == "") then
            return warn(`argument { index } has an invalid or missing 'name'.`);
        end;

        if (typeof(argument.description) ~= "string" or argument.description == "") then
            return warn(`argument { index } has an invalid or missing 'description'.`);
        end;

        if (typeof(argument.type) ~= "function") then
            return warn(`argument { index } has an invalid 'type' validator. it must be a function.`);
        end;
    end;

    local entry = setmetatable(command_data, {
        __call = function(self, executor: Player, arguments)
            if (permissions(executor) > self.permission_level) then
                warn(`unable to proceed due to invalid permissions. minimum permission level: { self.permission_level }`);
            end;

            local default_arguments = self.arguments;
            local current_arguments = {};
        
            for index: number, argument: argument_structure in ipairs(default_arguments) do
                local value = arguments[argument.name];
        
                if (value) then
                    if (not argument.type(value)) then
                        return warn(`unable to proceed with an invalid argument type for { argument.name }: expected { tostring(argument.type) }, got { typeof(value) }`);
                    end;
        
                    local entry = table.clone(default_arguments[index]);
                    entry["value"] = value;
                    current_arguments[index] = entry;
                else
                    return warn(`unable to proceed with missing argument: { argument.name }`);
                end;
            end;
        
            if (#current_arguments ~= #default_arguments) then
                return warn(`unable to proceed with a missmatched argumend count, expected { #default_arguments }, but got: { #current_arguments }.`);
            end;

            return self.on_execution(executor, {
                name = self.name;
                aliases = self.aliases;
                context = self.context;
                permission_level = self.permission_level;    
                arguments = current_arguments;
            });
        end;
    });

    command_data["name"] = command_name;
    command.registered_commands[command_name] = entry;

    return command.registered_commands[command_name];
end;

return setmetatable(command, {
    __index = function(_, command_name: string)
        return command.registered_commands[command_name] or warn(`could not find the { command_name } command.`);
    end;

    __call = function(_, name: string, command_data: command_structure)
        return create_command(name, command_data);
    end;
});
