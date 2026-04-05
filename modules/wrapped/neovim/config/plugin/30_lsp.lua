local now = Config.now
local add = vim.pack.add

now(function()
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
