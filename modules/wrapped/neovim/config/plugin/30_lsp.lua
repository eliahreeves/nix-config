local now = Config.now
local add = vim.pack.add

now(function()
  vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
      local buf, filetype = args.buf, args.match

      local language = vim.treesitter.language.get_lang(filetype)
      if not language then
        return
      end

      -- check if parser exists and load it
      if not vim.treesitter.language.add(language) then
        return
      end
      -- enables syntax highlighting and other treesitter features
      vim.treesitter.start(buf, language)

      -- enables treesitter based indentation
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })
end)

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
