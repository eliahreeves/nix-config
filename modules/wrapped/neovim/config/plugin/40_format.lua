local now, now_if_args, later = Config.now, Config.now_if_args, Config.later
local add = vim.pack.add

later(function()
  add({ "https://github.com/stevearc/conform.nvim" })
  require("conform").setup({
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_on_save = { timeout_ms = 500 },

    formatters_by_ft = {
      cpp = { "clang-format" },
      lua = { "stylua" },
      nix = { "alejandra" },
      bash = { "shfmt" },
      go = { "gofumpt" },
      python = { "ruff" },
      rust = { "rustfmt" },
      json = { "jq" },
      markdown = { "injected" },
      tex = { "latexindent" },
      sql = { "sql_formatter" },
      verilog = { "verible-verilog-format" },
      systemverilog = { "verible-verilog-format" },
    },
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" },
      },
      sql_formatter = {
        args = { "--config", '{"language": "postgresql", "uppercase": true}' },
      },
      stylua = { prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" } },
      ruff = {
        command = "ruff",
        args = { "format", "--stdin-filename", "$FILENAME", "-" },
      },
      ["verible-verilog-format"] = {
        command = "verible-verilog-format",
        args = { "-" },
        -- args = { "--failsafe_=false" },
      },
    },
  })
end)
