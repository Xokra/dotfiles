vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

--tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs ( prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.softtabstop = 2 -- 2
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true

opt.wrap = false

--use undotree
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.hlsearch = false
opt.incsearch = true

opt.scrolloff = 9
opt.signcolumn = "yes"
opt.isfname:append("@-@")

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

opt.cursorline = false

opt.termguicolors = true
opt.background = "dark"

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent or

--opt.updatetime = 50
--opt.colorcolumn = "80"

--clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register
-- what happen now?

--split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

opt.undofile = true
