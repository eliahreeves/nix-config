#!/usr/bin/env lua

local tmplt_path = "@templatePath@"
local command = arg[1]

local function list_templates()
    local pfile = io.popen("ls -1 " .. tmplt_path)
    if pfile then
        for filename in pfile:lines() do
            print(filename)
        end
        pfile:close()
    else
        print("Error: Directory '" .. tmplt_path .. "' does not exist.")
    end
end

if command == "list" then
    list_templates()
elseif command then
    local source = tmplt_path .. "/" .. command
    local f = io.open(source, "r")
    if f then
        f:close()
        local hook_script_path = source .. "/tmpltHook.sh"
        local hook_file = io.open(hook_script_path, "r")

        local pfile = io.popen("ls -A " .. source)
        if pfile then
            for filename in pfile:lines() do
                if filename ~= "tmpltHook.sh" then
                    os.execute("cp -rn --no-preserve=mode " .. source .. "/" .. filename .. " .")
                end
            end
            pfile:close()
        end

        if hook_file then
            hook_file:close()
            os.execute("sh " .. hook_script_path)
        end
        print("Successfully initialized " .. command)
    else
        print("Error: Template '" .. command .. "' not found.")
    end
else
    print("Usage: tmplt list | tmplt [name]")
end
