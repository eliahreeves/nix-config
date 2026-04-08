local now, later = Config.now, Config.later
now(function()
  require("mini.icons").setup({
    use_file_extension = function(ext, _)
      local suf3, suf4 = ext:sub(-3), ext:sub(-4)
      return suf3 ~= "scm" and suf3 ~= "txt" and suf3 ~= "yml" and suf4 ~= "json" and suf4 ~= "yaml"
    end,
  })
  later(MiniIcons.mock_nvim_web_devicons)
  later(MiniIcons.tweak_lsp_kind)
end)

now(function()
  local starter = require("mini.starter")
  local basicActions = {
    { name = "New buffer", action = "enew", section = "Basic actions" },
    { name = "Quit Neovim", action = "qall", section = "Basic actions" },
    {
      name = "Edit Config",
      action = function()
        local config = vim.fn.stdpath("config")
        vim.api.nvim_set_current_dir(config)
        Snacks.picker.files()
      end,

      section = "Basic actions",
    },
    { name = "Update Plugins", action = "lua vim.pack.update()", section = "Basic actions" },
  }
  starter.setup({
    header = require("header").random_header(),
    items = {
      starter.sections.recent_files(5, false),
      basicActions,
    },
    footer = "",
  })
end)

now(function()
  local blacklist = { "ltex_plus" }
  local predicate = function(notif)
    if not notif.msg then
      return true
    end

    for _, val in ipairs(blacklist) do
      if notif.msg:find(val) then
        return false
      end
    end
    return true
  end
  local custom_sort = function(notif_arr)
    return MiniNotify.default_sort(vim.tbl_filter(predicate, notif_arr))
  end
  require("mini.notify").setup({
    content = { sort = custom_sort },
    lsp_progress = {
      enable = true,
      level = "INFO",
      duration_last = 200,
    },
  })
end)

later(function()
  require("mini.snippets").setup()
end)

later(function()
  require("mini.extra").setup()
end)

later(function()
  require("mini.files").setup({ windows = { preview = true } })
end)

later(function()
  require("mini.diff").setup()
end)

later(function()
  local miniclue = require("mini.clue")
  miniclue.setup({
    window = {
      delay = 500,
    },
    triggers = {
      -- Leader triggers
      { mode = { "n", "x" }, keys = "<Leader>" },
      -- `[` and `]` keys
      { mode = "n", keys = "[" },
      { mode = "n", keys = "]" },
      -- Built-in completion
      { mode = "i", keys = "<C-x>" },
      -- `g` key
      { mode = { "n", "x" }, keys = "g" },
      -- `s` key
      { mode = { "n", "x" }, keys = "s" },
      -- Marks
      { mode = { "n", "x" }, keys = "'" },
      { mode = { "n", "x" }, keys = "`" },
      -- Registers
      { mode = { "n", "x" }, keys = '"' },
      { mode = { "i", "c" }, keys = "<C-r>" },
      -- Window commands
      { mode = "n", keys = "<C-w>" },
      -- `z` key
      { mode = { "n", "x" }, keys = "z" },
    },

    clues = {
      Config.leader_group_clues,
      -- Enhance this by adding descriptions for <Leader> mapping groups
      miniclue.gen_clues.square_brackets(),
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.windows(),
      miniclue.gen_clues.z(),
    },
  })
end)

later(function()
  require("mini.surround").setup()
end)
