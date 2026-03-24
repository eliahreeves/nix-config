local M = {}
M.saveLocation = vim.fn.stdpath("data") .. "colorscheme"
M.save = function(opt)
    if opt == nil or opt == "" then
        return
    end
    local file = io.open(M.saveLocation, "w")
    if file then
        file:write(opt)
        file:close()
    else
        vim.notify("Failed to save colorscheme")
    end
end
M.load = function()
    local file = io.open(M.saveLocation, "r")
    if not file then
        return nil
    end

    local content = file:read("*all")
    file:close()

    return vim.trim(content)
end
M.pickAndSave = function()
    local res = MiniExtra.pickers.colorschemes()
    M.save(res)
end
M.loadAndSet = function()
    local colorscheme = M.load()
    if colorscheme ~= nil and colorscheme ~= "" then
        vim.cmd.colorscheme(colorscheme)
    end
end
return M
