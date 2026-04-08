local map = vim.keymap.set
-- Clues
Config.leader_group_clues = {
  { mode = "n", keys = "<Leader>b", desc = "+Buffer" },
  { mode = "n", keys = "<Leader>w", desc = "+Window" },
  { mode = "n", keys = "<Leader>c", desc = "+Code/Lsp" },
  { mode = "n", keys = "<Leader>u", desc = "+Utility" },
}
-- General
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "j", function()
  return vim.v.count == 0 and "gj" or "j"
end, { expr = true })
vim.keymap.set({ "n", "x" }, "k", function()
  return vim.v.count == 0 and "gk" or "k"
end, { expr = true })

-- Pick
map("n", "<leader> ", function()
  Snacks.picker.files()
end, { desc = "Pick files" })
map("n", "<leader>/", function()
  Snacks.picker.grep()
end, { desc = "Live grep" })
map("n", "<leader>x", function()
  Snacks.picker.diagnostics()
end, { desc = "Pick diagnostic" })
map("n", "<leader>X", function()
  Snacks.picker.diagnostics_buffer()
end, { desc = "Pick diagnostic (buffer)" })

-- Files
map("n", "<leader>e", function()
  local file = vim.api.nvim_buf_get_name(0)
  if string.find(file, "ministarter://") then
    require("mini.files").open()
    return
  end
  require("mini.files").open(file)
end, { desc = "Explore Directory" })

-- Multi-Cursor
map({ "n", "x" }, "<M-Up>", function()
  require("multicursor-nvim").lineAddCursor(-1)
end)
map({ "n", "x" }, "<M-Down>", function()
  require("multicursor-nvim").lineAddCursor(1)
end)
map({ "n", "x" }, "<Leader>n", function()
  require("multicursor-nvim").matchAddCursor(1)
end, { desc = "Match add cursor" })

-- Lsp
local lsp_defaults = { "grn", "gra", "grr", "gri", "grn", "grx", "grt" }
for _, key in ipairs(lsp_defaults) do
  pcall(vim.keymap.del, "n", key)
end

map("n", "gd", function()
  Snacks.picker.lsp_definitions()
end, { desc = "Definition" })
map("n", "gr", function()
  Snacks.picker.lsp_references()
end, { desc = "References" })
map("n", "gi", function()
  Snacks.picker.lsp_implementations()
end, { desc = "Implementation" })
map("n", "<leader>ck", vim.lsp.buf.hover, { desc = "Hover" })
map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
map("n", "<leader>ce", vim.diagnostic.open_float, { desc = "Open error float" })

-- incremental selection treesitter/lsp
map({ "n", "x", "o" }, "<C-o>", function()
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require("vim.treesitter._select").select_parent(vim.v.count1)
  else
    vim.lsp.buf.selection_range(vim.v.count1)
  end
end, { desc = "Select parent treesitter node or outer incremental lsp selections" })

map({ "n", "x", "o" }, "<C-i>", function()
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require("vim.treesitter._select").select_child(vim.v.count1)
  else
    vim.lsp.buf.selection_range(-vim.v.count1)
  end
end, { desc = "Select child treesitter node or inner incremental lsp selections" })

-- Utility
map("n", "<leader>us", function()
  MiniDiff.toggle_overlay()
end, { desc = "Git summary" })
map("n", "<leader>ul", "<cmd>VimtexCompile<cr>", { desc = "Compile LaTeX" })
map("n", "<leader>up", "<cmd>PasteImage<cr>", { desc = "Paste image" })
map("n", "<leader>un", function()
  MiniNotify.show_history()
end, { desc = "Notification history" })
-- map("n", "<leader>um", function()
--     require("peek").open()
-- end, { desc = "Paste image" })

-- Dial
map("n", "<C-k>", function()
  require("dial.map").manipulate("increment", "normal")
end)
map("n", "<C-j>", function()
  require("dial.map").manipulate("decrement", "normal")
end)
map("n", "g<C-k>", function()
  require("dial.map").manipulate("increment", "gnormal")
end, { desc = "Increment" })
map("n", "g<C-j>", function()
  require("dial.map").manipulate("decrement", "gnormal")
end, { desc = "Decrement" })
map("x", "<C-k>", function()
  require("dial.map").manipulate("increment", "visual")
end)
map("x", "<C-j>", function()
  require("dial.map").manipulate("decrement", "visual")
end)
map("x", "g<C-k>", function()
  require("dial.map").manipulate("increment", "gvisual")
end, { desc = "Increment" })
map("x", "g<C-j>", function()
  require("dial.map").manipulate("decrement", "gvisual")
end, { desc = "Decrement" })

-- buffer stuff
map("n", "<leader>bd", ":bd<CR>", { desc = "Close buffer", noremap = true, silent = true })
map("n", "<leader>bo", ":%bd|e#|bd#<CR>", { desc = "Close other buffers", noremap = true, silent = true })
map("n", "<leader>bb", "<C-^>", { desc = "Previous buffer", noremap = true, silent = true })
map("n", "<leader>bl", ":bnext<CR>", { desc = "Next buffer", noremap = true, silent = true })
map("n", "<leader>bh", ":bprevious<CR>", { desc = "Previous buffer", noremap = true, silent = true })
map("n", "L", ":bnext<CR>", { desc = "Next buffer", noremap = true, silent = true })
map("n", "H", ":bprevious<CR>", { desc = "Previous buffer", noremap = true, silent = true })

-- window stuff
map("n", "<leader>ws", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>wv", "<C-W>v", { desc = "Split window right", remap = true })
map("n", "<leader>wq", "<C-W>q", { desc = "Close window", remap = true })
map("n", "<leader>wq", "<C-W>o", { desc = "Close other windows", remap = true })
map("n", "<leader>wh", "<C-W>h", { desc = "Window left", remap = true })
map("n", "<leader>wl", "<C-W>l", { desc = "Window right", remap = true })
map("n", "<leader>wj", "<C-W>j", { desc = "Window down", remap = true })
map("n", "<leader>wk", "<C-W>k", { desc = "Window up", remap = true })
map("n", "<leader>ww", "<C-W>w", { desc = "Window next", remap = true })

-- Color Scheme
map("n", "<leader>uc", function()
  require("persistent-color").pickAndSave()
end, { desc = "Change colorscheme" })

-- Completion
map("i", "<CR>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-y>"
  else
    return "<CR>"
  end
end, { expr = true })

-- unmaps
map("n", "q:", "<Nop>")
map("n", "<F1>", "<Nop>")
