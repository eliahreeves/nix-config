-- General ====================================================================
vim.g.mapleader = " " -- Use `<Space>` as a leader key
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
vim.opt.swapfile = false

vim.o.mouse = "a" -- Enable mouse
vim.o.switchbuf = "usetab" -- Use already opened buffers when switching
vim.o.undofile = true -- Enable persistent undo

vim.o.shada = "'100,<50,s10,:1000,/100,@100,h" -- Limit ShaDa file (for startup)

-- UI =========================================================================
vim.o.breakindent = true -- Indent wrapped lines to match line start
vim.o.breakindentopt = "list:-1" -- Add padding for lists (if 'wrap' is set)
vim.o.colorcolumn = "+1" -- Draw column on the right of maximum width
vim.o.cursorline = false -- Enable current line highlighting
vim.o.linebreak = true -- Wrap lines at 'breakat' (if 'wrap' is set)
vim.o.list = true -- Show helpful text indicators
vim.o.number = true -- Show line numbers
vim.o.relativenumber = true -- Show relative line number
vim.o.pumheight = 10 -- Make popup menu smaller
vim.o.ruler = false -- Don't show cursor coordinates
vim.o.shortmess = "CFOSWaco" -- Disable some built-in completion messages
vim.o.showmode = false -- Don't show mode in command line
vim.o.splitbelow = true -- Horizontal splits will be below
vim.o.splitkeep = "screen" -- Reduce scroll during window split
vim.o.splitright = true -- Vertical splits will be to the right
vim.o.cmdheight = 0 -- No Command window
vim.opt.fillchars = { eob = " " } --Don't show ~ at end of buffer
vim.diagnostic.config({
  signs = false,
  virtual_text = {
    spacing = 4,
    source = "if_many",
    prefix = "●",
  },
  severity_sort = true,
  float = {
    border = "rounded",
  },
  underline = true,
  update_in_insert = false,
})

-- Editing ====================================================================
vim.o.autoindent = true -- Use auto indent
vim.o.expandtab = true -- Convert tabs to spaces
vim.o.formatoptions = "rqnl1j" -- Improve comment editing
vim.o.ignorecase = true -- Ignore case during search
vim.o.incsearch = true -- Show search matches while typing
vim.o.infercase = true -- Infer case in built-in completion
vim.o.shiftwidth = 2 -- Use this number of spaces for indentation
vim.o.smartcase = true -- Respect case if search pattern has upper case
vim.o.smartindent = true -- Make indenting smart
vim.o.spelloptions = "camel" -- Treat camelCase word parts as separate words
vim.o.tabstop = 2 -- Show tab as this number of spaces
vim.o.virtualedit = "block" -- Allow going past end of line in blockwise mode

vim.o.completeopt = "menuone,noinsert" -- Setting this forces my preffered behavior for mini.completion

vim.o.iskeyword = "@,48-57,_,192-255,-" -- Treat dash as `word` textobject part
