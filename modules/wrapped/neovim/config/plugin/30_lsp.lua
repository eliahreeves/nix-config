local now_if_args = Config.now_if_args
local add = vim.pack.add

now_if_args(function()
    add({ "https://github.com/neovim/nvim-lspconfig" })

    vim.lsp.config("slang-server", {
        cmd = { "slang-server" },
        root_markers = { ".git", ".slang" },
        filetypes = {
            "systemverilog",
            "verilog",
        },
    })

    vim.lsp.enable({
        "slang-server",
        "lua_ls",
        "bashls",
        "nixd",
        "clangd",
        "gopls",
        "rust_analyzer",
        "texlab",
        "ltex_plus",
        "pyright",
    })
end)
