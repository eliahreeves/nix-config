local now, later = Config.now, Config.later
local add = vim.pack.add

now(function()
  add({ "https://github.com/vague-theme/vague.nvim" })
  add({ "https://github.com/rebelot/kanagawa.nvim" })
  add({ "https://github.com/WTFox/jellybeans.nvim" })
  require("persistent-color").loadAndSet()
end)
