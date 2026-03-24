local now, later, on_filetype = Config.now, Config.later, Config.on_filetype
local add = vim.pack.add

later(function()
    add({ "https://github.com/jake-stewart/multicursor.nvim" })
    local mc = require("multicursor-nvim")
    mc.setup({})
    mc.addKeymapLayer(function(layerSet)
        -- Select a different cursor as the main one.
        layerSet({ "n", "x" }, "<left>", mc.prevCursor)
        layerSet({ "n", "x" }, "<right>", mc.nextCursor)

        -- Delete the main cursor.
        layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)
        -- Enable and clear cursors using escape.
        layerSet("n", "<esc>", function()
            if not mc.cursorsEnabled() then
                mc.enableCursors()
            else
                mc.clearCursors()
            end
        end)
    end)
end)

now(function()
    add({ "https://github.com/nvim-lualine/lualine.nvim" })
    require("lualine").setup({
        sections = {
            lualine_a = { "mode" },
            lualine_b = {
                "branch",
                "diff",
                "diagnostics",
                "buffers",
            },
            lualine_c = {},
            lualine_x = { "encoding", "fileformat", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" },
        },
        tabline = {},
    })
end)

later(function()
    add({ "https://github.com/lewis6991/gitsigns.nvim" })
    require("gitsigns").setup({})
end)

later(function()
    add({ "https://github.com/monaqa/dial.nvim" })
    require("dial-config").setup()
end)

on_filetype("tex", function()
    add({ "https://github.com/lervag/vimtex" })
    vim.g.vimtex_quickfix_mode = 0
end)

on_filetype("markdown", function()
    add({ "https://github.com/toppair/peek.nvim" })
    require("peek").setup()
    vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
    vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
end)

later(function()
    add({ "https://github.com/hakonharnes/img-clip.nvim" })
end)

on_filetype("dart", function()
    add({ "https://github.com/nvim-lua/plenary.nvim" })
    add({ "https://github.com/nvim-flutter/flutter-tools.nvim" })
end)
